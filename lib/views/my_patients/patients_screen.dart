import 'package:MediGuideAI/helpers/helpers/genenal_helpers.dart';
import 'package:MediGuideAI/services/patient/get_my_patient_services.dart';
import 'package:MediGuideAI/views/doctor_module/my_patients/view_patients_by_category.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../constant/colors.dart';
import '../../../models/patient.dart';
import '../../widgets/PatientCard.dart';
import '../../widgets/network_error.dart';

class PatientsScreen extends StatefulWidget {
  const PatientsScreen({super.key});

  @override
  State<PatientsScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {

  final user = FirebaseAuth.instance.currentUser;
  static const pageSize = 5;
  final PagingController<int, Patient> _patientsPagingController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _patientsPagingController.addPageRequestListener((pageKey) {
      GetMyPatient.fetchMyPatients(
          pageKey: pageKey,
          pageSize: pageSize,
          pagingController: _patientsPagingController,
          docEmail: user!.email!
      );
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.primaryColor,
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Pallete.primaryColor,
          centerTitle: true,
          title: const Text(
            'My Patients'
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Container(
              color: Colors.white,
              child: Container(
                decoration: const BoxDecoration(
                    color: Pallete.primaryColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        width: 270,
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide:
                              const BorderSide(color: Pallete.primaryColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            labelText: 'Search ',
                            labelStyle: const TextStyle(color: Colors.grey),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.grey,
                              size: 30,
                            ),
                          ),
                          style: const TextStyle(color: Pallete.primaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      body: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topRight: Radius.circular(30))),
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'All Patients',
                  style: GoogleFonts.roboto(
                      color: Pallete.lightPrimaryTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Helpers.temporaryNavigator(context, const ViewAllPatients(category: 'all'));
                  },
                  child: Text(
                    'See all',
                    style: GoogleFonts.roboto(
                        color: Pallete.primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),

            SizedBox(
              height: 210,
              width: MediaQuery.sizeOf(context).width,
              child: PagedListView<int, Patient>(
                scrollDirection: Axis.horizontal,
                pagingController: _patientsPagingController,
                builderDelegate: PagedChildBuilderDelegate<Patient>(
                  itemBuilder: (context, patient, index) {
                    return PatientCard(
                      patient: patient
                    );
                  },
                  firstPageErrorIndicatorBuilder: (_) =>
                      NetworkError(onTap: () {}),
                  animateTransitions: true,
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Admitted',
                  style: GoogleFonts.roboto(
                      color: Pallete.lightPrimaryTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    Helpers.temporaryNavigator(context, const ViewAllPatients(category: 'admitted'));
                  },
                  child: Text(
                    'See all',
                    style: GoogleFonts.roboto(
                        color: Pallete.primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              height: 210,
              width: MediaQuery.sizeOf(context).width,
              child: PagedListView<int, Patient>(
                scrollDirection: Axis.horizontal,
                pagingController: _patientsPagingController,
                builderDelegate: PagedChildBuilderDelegate<Patient>(
                  itemBuilder: (context, patient, index) {
                    return PatientCard(
                        patient: patient
                    );
                  },
                  firstPageErrorIndicatorBuilder: (_) =>
                      NetworkError(onTap: () {}),
                  animateTransitions: true,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Discharged',
                  style: GoogleFonts.roboto(
                      color: Pallete.lightPrimaryTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    Helpers.temporaryNavigator(context, const ViewAllPatients(category: 'active'));
                  },
                  child: Text(
                    'See all',
                    style: GoogleFonts.roboto(
                        color: Pallete.primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              height: 210,
              width: MediaQuery.sizeOf(context).width,
              child: PagedListView<int, Patient>(
                scrollDirection: Axis.horizontal,
                pagingController: _patientsPagingController,
                builderDelegate: PagedChildBuilderDelegate<Patient>(
                  itemBuilder: (context, patient, index) {
                    return PatientCard(
                        patient: patient
                    );
                  },
                  firstPageErrorIndicatorBuilder: (_) =>
                      NetworkError(onTap: () {}),
                  animateTransitions: true,
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Deceased',
                  style: GoogleFonts.roboto(
                      color: Pallete.lightPrimaryTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    Helpers.temporaryNavigator(context, const ViewAllPatients(category: 'deceased'));
                  },
                  child: Text(
                    'See all',
                    style: GoogleFonts.roboto(
                        color: Pallete.primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              height: 210,
              width: MediaQuery.sizeOf(context).width,
              child: PagedListView<int, Patient>(
                scrollDirection: Axis.horizontal,
                pagingController: _patientsPagingController,
                builderDelegate: PagedChildBuilderDelegate<Patient>(
                  itemBuilder: (context, patient, index) {
                    return PatientCard(
                        patient: patient
                    );
                  },
                  firstPageErrorIndicatorBuilder: (_) =>
                      NetworkError(onTap: () {}),
                  animateTransitions: true,
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
