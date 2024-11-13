import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:medique/core/constants/color_constants.dart';
import 'package:medique/models/patient_personal_details.dart';
import 'package:medique/repository/helpers/add_patinet_helper.dart';
import 'package:medique/widgets/custom_button/general_button.dart';
import 'package:medique/widgets/custom_dropdown.dart';
import '../../widgets/text_fields/custom_text_field.dart';

class AddPatient extends StatefulWidget {
  final User user;
  const AddPatient({super.key, required this.user});

  @override
  State<AddPatient> createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController nationalIdController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  DateTime? dob;
  String? _selectedGender;
  String? _selectedTitle;
  String? _selectedMaritalStatus;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    nationalIdController.dispose();
    addressController.dispose();
    occupationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.primaryColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Add Patient',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Personal Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            CustomDropDown(
              items: const ['Mr', 'Mrs', 'Ms'],
              prefixIcon: Icons.title,
              isEnabled: true,
              selectedValue: _selectedTitle ?? 'Mr',
              onChanged: (value) {
                setState(() {
                  _selectedTitle = value;
                });
              },
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: firstNameController,
              labelText: 'First Name',
              prefixIcon: const Icon(Icons.person),
              keyBoardType: TextInputType.text,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: lastNameController,
              labelText: 'Last Name',
              prefixIcon: const Icon(Icons.person),
              keyBoardType: TextInputType.text,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: emailController,
              labelText: 'Email',
              prefixIcon: const Icon(Icons.email),
              keyBoardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: phoneNumberController,
              labelText: 'Phone Number',
              prefixIcon: const Icon(Icons.phone),
              keyBoardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: nationalIdController,
              labelText: 'National ID',
              prefixIcon: const Icon(Icons.badge),
              keyBoardType: TextInputType.text,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: addressController,
              labelText: 'Address',
              prefixIcon: const Icon(Icons.home),
              keyBoardType: TextInputType.text,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: occupationController,
              labelText: 'Occupation',
              prefixIcon: const Icon(Icons.work),
              keyBoardType: TextInputType.text,
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () async {
                dob = await AddPatientHelper.pickDate(
                    context: context,
                    initialDate: DateTime(2000),
                    firstDate: DateTime(1900));
                setState(() {});
              },
              child: CustomTextField(
                labelText: 'Date of Birth',
                prefixIcon: const Icon(Icons.cake, color: Colors.grey),
                enabled: false,
                controller: TextEditingController(
                  text:
                  dob != null ? DateFormat('yyyy-MM-dd').format(dob!) : '',
                ),
              ),
            ),

            const SizedBox(height: 16),
            CustomDropDown(
              items: const ['Single', 'Married', 'Divorced', 'Widowed'],
              prefixIcon: Icons.title,
              isEnabled: true,
              selectedValue: _selectedMaritalStatus ?? 'Single',
              onChanged: (value) {
                setState(() {
                  _selectedMaritalStatus = value;
                });
              },
            ),
            const SizedBox(height: 16),
            CustomDropDown(
              items: const ['Male', 'Female', 'Other'],
              prefixIcon: Icons.transgender,
              isEnabled: true,
              selectedValue: _selectedGender ?? 'Male',
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                });
              },
            ),
            const SizedBox(height: 24),
            Center(
              child: GeneralButton(
                onTap: (){
                  final patientPersonalDetails = PatientPersonalDetails(
                    patientId: _autoGenID(),
                    firstName: firstNameController.text,
                    lastName: lastNameController.text,
                    email: emailController.text,
                    phoneNumber: phoneNumberController.text,
                    nationalId: nationalIdController.text,
                    address: addressController.text,
                    occupation: occupationController.text,
                    dateOfBirth: dob.toString(),
                    registrationDate: DateTime.now().toString(),
                    maritalStatus: _selectedMaritalStatus,
                    title: _selectedTitle,
                    gender: _selectedGender,
                  );

                  AddPatientHelper.validateAndSubmitPatientDetailsForm(user: widget.user ,patientPersonalDetails: patientPersonalDetails);

                },
                borderRadius: 10,
                btnColor: Pallete.primaryColor,
                width: 200,
                child: const Text(
                  'Next',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  static String _autoGenID() {
    return FirebaseFirestore.instance.collection('patients').doc().id;
  }
}
