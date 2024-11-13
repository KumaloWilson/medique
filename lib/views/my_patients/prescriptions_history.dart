import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medique/widgets/cards/prescription_card.dart';
import '../../core/constants/color_constants.dart';
import '../../core/utils/api_response.dart';
import '../../models/patient.dart';
import '../../models/prescription.dart';
import '../../services/prescription_services.dart';

class PatientMedicalHistory extends StatefulWidget {
  final Patient patient;
  const PatientMedicalHistory({super.key, required this.patient});

  @override
  State<PatientMedicalHistory> createState() => _PatientMedicalHistoryState();
}

class _PatientMedicalHistoryState extends State<PatientMedicalHistory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Pallete.primaryColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Medical History',
          style: TextStyle(color: Colors.white),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Container(
            color: Colors.white,
            child: Container(
              decoration: const BoxDecoration(
                  color: Pallete.primaryColor,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TabBar(
                    controller: _tabController,
                    physics: const BouncingScrollPhysics(),
                    isScrollable: false,
                    tabAlignment: TabAlignment.fill,
                    unselectedLabelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    labelStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    tabs: const [
                      Tab(text: 'Ongoing'),
                      Tab(text: 'History'),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topRight: Radius.circular(30))),
        child: StreamBuilder<List<Prescription>>(
          stream: PrescriptionServices.streamPatientPrescriptions(patientEmail:  widget.patient.personalDetails!.email!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError || !snapshot.hasData) {
              return const Center(child: Text('Error loading prescriptions.'));
            }

            final ongoingPrescriptions = snapshot.data!;
            final historyPrescriptions = snapshot.data!;

            return TabBarView(
              controller: _tabController,
              children: <Widget>[
                PrescriptionList(prescriptions: ongoingPrescriptions),
                PrescriptionList(prescriptions: historyPrescriptions),
              ],
            );
          },
        ),
      ),
    );
  }
}


class PrescriptionList extends StatelessWidget {
  final List<Prescription> prescriptions;

  const PrescriptionList({super.key, required this.prescriptions});

  @override
  Widget build(BuildContext context) {
    if (prescriptions.isEmpty) {
      return const Center(child: Text('No prescriptions found.'));
    }

    return ListView.builder(
      itemCount: prescriptions.length,
      itemBuilder: (context, index) {
        final prescription = prescriptions[index];
        return PrescriptionCard(prescription: prescription);
      },
    );
  }
}