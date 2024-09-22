import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medique/core/constants/color_constants.dart';
import 'package:medique/models/patient_personal_details.dart';
import 'package:medique/repository/helpers/add_patinet_helper.dart';
import 'package:medique/widgets/custom_button/general_button.dart';
import '../../models/next_of_kin.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/text_fields/custom_text_field.dart';

class AddNextOfKin extends StatefulWidget {
  final User user;
  final PatientPersonalDetails patientPersonalDetails;
  const AddNextOfKin({super.key, required this.user, required this.patientPersonalDetails});

  @override
  State<AddNextOfKin> createState() => _AddNextOfKinState();
}

class _AddNextOfKinState extends State<AddNextOfKin> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController nationalIdController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  String? _selectedGender;
  String? _selectedRelationship;
  String? _selectedTitle;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    nationalIdController.dispose();
    addressController.dispose();
    occupationController.dispose();
    dateOfBirthController.dispose();
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
          'Add Next of Kin',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Next of Kin Details',
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
              selectedValue: 'Mr',
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
            CustomTextField(
              controller: dateOfBirthController,
              labelText: 'Date of Birth',
              prefixIcon: const Icon(Icons.cake),
              keyBoardType: TextInputType.datetime,
            ),
            const SizedBox(height: 16),
            CustomDropDown(
              items: const [
                'Father',
                'Mother',
                'Sibling',
                'Spouse',
                'Child',
                'Friend',
                'Cousin',
                'Other'
              ],
              prefixIcon: Icons.family_restroom,
              isEnabled: true,
              selectedValue: 'Father',
              onChanged: (value) {
                setState(() {
                  _selectedRelationship = value;
                });
              },
            ),

            const SizedBox(height: 16),
            CustomDropDown(
              items: const ['Male', 'Female', 'Other'],
              prefixIcon: Icons.transgender,
              isEnabled: true,
              selectedValue: 'Male',
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                });
              },
            ),
            const SizedBox(height: 24),
            Center(
              child: GeneralButton(
                onTap: () {
                  final nextOfKinDetails = NextOfKinDetails(
                    firstName: firstNameController.text,
                    lastName: lastNameController.text,
                    email: emailController.text,
                    phoneNumber: phoneNumberController.text,
                    nationalId: nationalIdController.text,
                    address: addressController.text,
                    occupation: occupationController.text,
                    dateOfBirth: dateOfBirthController.text,
                    title: _selectedTitle,
                    relationship: _selectedRelationship,
                    gender: _selectedGender,
                  );

                  AddPatientHelper.validateAndSubmitPatientData(
                    addedBy: widget.user.email!,
                    patientPersonalDetails: widget.patientPersonalDetails,
                    nextOfKinDetails: nextOfKinDetails,

                  );
                },
                borderRadius: 10,
                btnColor: Pallete.primaryColor,
                width: 200,
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
