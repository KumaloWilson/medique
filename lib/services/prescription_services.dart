import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medique/core/utils/logs.dart';
import 'package:medique/models/prescription.dart';
import 'package:http/http.dart' as http;
import '../core/utils/api_response.dart';

class PrescriptionServices{
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static Future<APIResponse<String?>> addPrescription({
    required Prescription prescription,
  }) async {
    try {

      final prescriptionData = prescription.toJson();
      await _firestore.collection('prescriptions').add(prescriptionData);

      return APIResponse(
          success: true, data: '', message: 'Prescriptions added successfully');
    } catch (e) {
      return APIResponse(success: false, message: e.toString());
    }
  }


  static Future<APIResponse<List<String>>> getMedicationSuggestions(String query) async {
    try {
      final response = await http.get(Uri.parse('https://api.fda.gov/drug/drugsfda.json?search=$query'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('results')) {
          final List<dynamic> results = data['results'];
          return APIResponse(
            message: 'Success',
            success: true,
            data: results
                .where((item) => item['openfda'] != null && item['openfda'].containsKey('brand_name'))
                .map((item) => item['openfda']['brand_name'][0].toString())
                .toList()
          );
        }
      }
    } catch (e) {
      DevLogs.logError('Error fetching medication suggestions: $e');
      return APIResponse(
        message: 'Error fetching medication',
        success: false
      );
    }
    return APIResponse(
      message: 'Error fetching medication',
      success: false,
      data: []
    );
  }

  // Stream to listen for real-time prescription updates and classify them into Ongoing and History
  static Stream<APIResponse<Map<String, List<Prescription>>>> getPrescriptionsStream({required String patientEmail}) {
    return _firestore
        .collection('prescriptions')
        .where('patientEmail', isEqualTo: patientEmail)
        .snapshots()
        .map((snapshot) {
      List<Prescription> ongoingPrescriptions = [];
      List<Prescription> historyPrescriptions = [];

      for (var doc in snapshot.docs) {
        Prescription prescription =
        Prescription.fromJson(doc.data() as Map<String, dynamic>);

        // Check for each medicine if it's ongoing or history
        bool isOngoing = false;
        for (var medicine in prescription.medicines) {
          DateTime prescriptionEndDate = DateTime.parse(prescription.prescriptionDate)
              .add(Duration(days: int.parse(medicine.duration)));

          if (prescriptionEndDate.isAfter(DateTime.now())) {
            isOngoing = true;
            break;
          }
        }

        if (isOngoing) {
          ongoingPrescriptions.add(prescription);
        } else {
          historyPrescriptions.add(prescription);
        }
      }

      return APIResponse(
        success: true,
        message: 'Prescriptions retrieved successfully',
        data: {
          'ongoing': ongoingPrescriptions,
          'history': historyPrescriptions,
        },
      );
    }).handleError((error) {
      return APIResponse(success: false, message: 'Error retrieving prescriptions: $error');
    });
  }

}

