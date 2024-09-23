import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medique/models/patient.dart';
import 'package:medique/models/vitals.dart';
import 'package:get/get.dart';

import '../../core/utils/routes.dart';
import '../../services/vital_services.dart';
import '../../widgets/circular_loader/circular_loader.dart';
import '../../widgets/snackbar/custom_snackbar.dart';

class VitalsHelper {
  static void validateAndAnalyze({
    required Patient patient,
    required String bloodPressure,
    required String heartRate,
    required String height,
    required String oxygenSaturation,
    required String respiratoryRate,
    required String temperature,
    required String weight,
  }) async {
    // Validate input fields
    if (bloodPressure.isEmpty ||
        heartRate.isEmpty ||
        height.isEmpty ||
        oxygenSaturation.isEmpty ||
        respiratoryRate.isEmpty ||
        temperature.isEmpty ||
        weight.isEmpty) {
      CustomSnackBar.showErrorSnackbar(message: 'All fields are required.');
      return;
    }


    Get.dialog(
      const CustomLoader(
        message: 'Adding Vitals',
      ),
      barrierDismissible: false,
    );


    final double heightInMeters = double.parse(height) / 100;
    final double weightInKg = double.parse(weight);
    final double bmi = weightInKg / (heightInMeters * heightInMeters);

    final vitals = Vitals(
      email: patient.personalDetails!.email!,
      createdAt: DateTime.now(),
      patientId: patient.personalDetails!.patientId!,
      id: _autoGenID(),
      bloodPressure: bloodPressure,
      heartRate: int.parse(heartRate),
      oxygenSaturation: int.parse(oxygenSaturation),
      respiratoryRate: int.parse(respiratoryRate),
      temperature: double.parse(temperature),
      weight: weightInKg,
      height: heightInMeters,
      bmi: bmi,
    );
    // Analyze vitals to generate comments
    final comments = analyzeVitals(
      bloodPressure: bloodPressure,
      heartRate: heartRate,
      respiratoryRate: respiratoryRate,
      oxygenSaturation: oxygenSaturation,
      temperature: temperature,
      weight: weight,
      height: height,
    );

    await VitalsServices.addVitalsToFirebase(vitals: vitals ).then((response) {
      if (!response.success) {
        if (!Get.isSnackbarOpen) Get.back();
        CustomSnackBar.showErrorSnackbar(message: response.message ?? 'Something went wrong');
      } else {
        if (Get.isDialogOpen!) Get.back();

        CustomSnackBar.showSuccessSnackbar(message: response.message!,);

        showCommentsDialog(comments);
      }
    });
  }

  static String _autoGenID() {
    return FirebaseFirestore.instance.collection('vitals').doc().id;
  }

  static Map<String, String> analyzeVitals({
    required String bloodPressure,
    required String heartRate,
    required String respiratoryRate,
    required String oxygenSaturation,
    required String temperature,
    required String weight,
    required String height,
  }) {
    Map<String, String> comments = {};

    // Blood Pressure Analysis
    List<String> bpValues = bloodPressure.split('/');
    int sysBP = int.tryParse(bpValues[0]) ?? 0;
    int diasBP = int.tryParse(bpValues[1]) ?? 0;
    if (sysBP > 140 || diasBP > 80) {
      comments['Blood Pressure'] = 'High blood pressure. Consider consulting a doctor.';
    } else if (sysBP < 90 || diasBP < 60) {
      comments['Blood Pressure'] = 'Low blood pressure. Monitor for any symptoms.';
    } else {
      comments['Blood Pressure'] = 'Blood pressure is normal.';
    }

    // Heart Rate Analysis
    int hr = int.tryParse(heartRate) ?? 0;
    if (hr > 100) {
      comments['Heart Rate'] = 'Heart rate is elevated. May indicate stress or physical exertion.';
    } else if (hr < 60) {
      comments['Heart Rate'] = 'Heart rate is low. Ensure there are no signs of fatigue or dizziness.';
    } else {
      comments['Heart Rate'] = 'Heart rate is within the normal range.';
    }

    // Respiratory Rate Analysis
    int rr = int.tryParse(respiratoryRate) ?? 0;
    if (rr > 20) {
      comments['Respiratory Rate'] = 'High respiratory rate. Could be a sign of respiratory distress.';
    } else if (rr < 12) {
      comments['Respiratory Rate'] = 'Low respiratory rate. Monitor breathing patterns.';
    } else {
      comments['Respiratory Rate'] = 'Respiratory rate is normal.';
    }

    // Oxygen Saturation Analysis
    int oxygen = int.tryParse(oxygenSaturation) ?? 0;
    if (oxygen < 95) {
      comments['Oxygen Saturation'] = 'Low oxygen saturation. Consider checking oxygen supply or respiratory health.';
    } else {
      comments['Oxygen Saturation'] = 'Oxygen saturation is normal.';
    }

    // Temperature Analysis
    double temp = double.tryParse(temperature) ?? 0;
    if (temp > 37.5) {
      comments['Temperature'] = 'High temperature. Indicates possible fever.';
    } else if (temp < 36.0) {
      comments['Temperature'] = 'Low temperature. Could indicate hypothermia.';
    } else {
      comments['Temperature'] = 'Temperature is within the normal range.';
    }

    // Weight and Height/BMI Analysis
    double weightVal = double.tryParse(weight) ?? 0;
    double heightVal = double.tryParse(height) ?? 0;
    if (weightVal > 0 && heightVal > 0) {
      double heightInMeters = heightVal / 100; // convert height to meters
      double bmi = weightVal / (heightInMeters * heightInMeters);
      if (bmi > 25) {
        comments['BMI'] = 'Overweight based on BMI. Consider lifestyle changes.';
      } else if (bmi < 18.5) {
        comments['BMI'] = 'Underweight based on BMI. Ensure adequate nutrition.';
      } else {
        comments['BMI'] = 'BMI is within the normal range.';
      }
    }

    return comments;
  }

  static void showCommentsDialog(Map<String, String> comments) {
    Get.dialog(
      AlertDialog(
        title: const Text('Vital Analysis'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: comments.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  '${entry.key}: ${entry.value}',
                  style: const TextStyle(fontSize: 16),
                ),
              );
            }).toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

}
