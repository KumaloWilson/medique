import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medique/core/utils/routes.dart';
import 'package:medique/models/patient.dart';
import 'package:medique/models/patient_personal_details.dart';
import 'package:medique/services/patient_services.dart';
import '../../models/next_of_kin.dart';
import '../../widgets/circular_loader/circular_loader.dart';
import '../../widgets/snackbar/custom_snackbar.dart';

class AddPatientHelper{
  static void validateAndSubmitPatientDetailsForm({
    required User user,
    required PatientPersonalDetails patientPersonalDetails
  }) async {
    // Validate first name
    if (patientPersonalDetails.firstName!.isEmpty) {
      CustomSnackBar.showErrorSnackbar(message: 'First name is required.');
      return;
    }

    // Validate last name
    if (patientPersonalDetails.lastName!.isEmpty) {
      CustomSnackBar.showErrorSnackbar(message: 'Last name is required.');
      return;
    }

    // Validate phone number
    if (patientPersonalDetails.phoneNumber!.isEmpty) {
      CustomSnackBar.showErrorSnackbar(message: 'Phone number is required.');
      return;
    }

    // Ensure the phone number is valid (you can add your own regex)
    if (!GetUtils.isPhoneNumber(patientPersonalDetails.phoneNumber!)) {
      CustomSnackBar.showErrorSnackbar(message: 'Please input a valid phone number.');
      return;
    }

    // Validate national ID
    if (patientPersonalDetails.nationalId!.isEmpty) {
      CustomSnackBar.showErrorSnackbar(message: 'National ID is required.');
      return;
    }

    // Validate gender
    if (patientPersonalDetails.gender == null || patientPersonalDetails.gender!.isEmpty) {
      CustomSnackBar.showErrorSnackbar(message: 'Please select a gender.');
      return;
    }

    // Validate email
    if (patientPersonalDetails.email!.isEmpty) {
      CustomSnackBar.showErrorSnackbar(message: 'Email is required.');
      return;
    }

    // Ensure the email is valid
    if (!GetUtils.isEmail(patientPersonalDetails.email!)) {
      CustomSnackBar.showErrorSnackbar(message: 'Please input a valid email.');
      return;
    }

    Get.toNamed(
      RoutesHelper.nextOfKinDetailsScreen,
      arguments: [user, patientPersonalDetails]
    );
  }

  static void validateAndSubmitPatientData({required String addedBy, required PatientPersonalDetails patientPersonalDetails, required NextOfKinDetails nextOfKinDetails}) async{
    if (nextOfKinDetails.firstName == null || nextOfKinDetails.firstName!.isEmpty) {
      CustomSnackBar.showErrorSnackbar(message: 'Next of kin\'s first name is required.');
      return;
    }
    if (nextOfKinDetails.lastName == null || nextOfKinDetails.lastName!.isEmpty) {
      CustomSnackBar.showErrorSnackbar(message: 'Next of kin\'s last name is required.');
      return;
    }
    if (nextOfKinDetails.phoneNumber == null || nextOfKinDetails.phoneNumber!.isEmpty) {
      CustomSnackBar.showErrorSnackbar(message: 'Next of kin\'s phone number is required.');
      return;
    }
    if (!GetUtils.isPhoneNumber(nextOfKinDetails.phoneNumber!)) {
      CustomSnackBar.showErrorSnackbar(message: 'Please input a valid phone number for next of kin.');
      return;
    }


    Get.dialog(
      const CustomLoader(
        message: 'Adding Patient',
      ),
      barrierDismissible: false,
    );

    final updatedPatientDeatils = patientPersonalDetails.copyWith(
      patientId: _autoGenID()
    );

    final patient = Patient(
      id: updatedPatientDeatils.patientId,
      nextOfKinDetails: nextOfKinDetails,
      personalDetails: patientPersonalDetails,
      status: 'admitted'
    );


    await PatientServices.addPatientToFirebase(
      patient: patient
    ).then((response) {
      if (!response.success) {
        if (!Get.isSnackbarOpen) Get.back();
        CustomSnackBar.showErrorSnackbar(message: response.message ?? 'Something went wrong');
      } else {
        if (Get.isDialogOpen!) Get.back();

        CustomSnackBar.showSuccessSnackbar(message: response.message!,);
        Get.offAllNamed(RoutesHelper.initialScreen);
      }
    });
  }


  static String _autoGenID() {
    return FirebaseFirestore.instance.collection('patients').doc().id;
  }

  static Future<DateTime?> pickDate(
      {required BuildContext context,
        required DateTime initialDate,
        DateTime? firstDate}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate ?? DateTime.now(),
      lastDate: DateTime(2100),
    );

    return picked;
  }

  static int calculateAge(String stringBirthDate) {
    // Parse the provided string into a DateTime object
    DateTime birthDate = DateTime.parse(stringBirthDate);
    DateTime currentDate = DateTime.now();

    // Calculate the initial age based on the year difference
    int age = currentDate.year - birthDate.year;

    // Check if the birthday has occurred yet this year; if not, subtract 1 from the age
    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month && currentDate.day < birthDate.day)) {
      age--;
    }

    return age;
  }
}