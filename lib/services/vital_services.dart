import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/utils/api_response.dart';
import '../models/vitals.dart';

class VitalsServices {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to add vitals to Firebase Firestore
  static Future<APIResponse<String?>> addVitalsToFirebase({
    required Vitals vitals,
  }) async {
    try {
      final userData = vitals.toJson();
      await _firestore.collection('vitals').add(userData);

      return APIResponse(
          success: true, data: '', message: 'Vitals added successfully');
    } catch (e) {
      return APIResponse(success: false, message: e.toString());
    }
  }

  static Stream<List<Vitals>> streamAllVitals({required String patientEmail}) {
    return _firestore.collection('vitals').where('patientEmail', isEqualTo: patientEmail).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Vitals.fromJson(doc.data())).toList();
    });
  }
}
