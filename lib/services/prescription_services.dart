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

      return APIResponse(success: true, data: '', message: 'Prescriptions added successfully');
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


  // Stream patient prescriptions based on patient email
  static Stream<List<Prescription>> streamPatientPrescriptions({required String patientEmail}) {
    return _firestore
        .collection('prescriptions')
        .where('patientEmail', isEqualTo: patientEmail)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Prescription.fromJson(doc.data())).toList());
  }
}

