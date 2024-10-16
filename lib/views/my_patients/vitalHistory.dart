import 'package:flutter/material.dart';
import '../../core/constants/color_constants.dart';
import '../../models/patient.dart';
import '../../models/vitals.dart';
import '../../services/vital_services.dart';
import '../../widgets/cards/vitals_card.dart';

class ViewPatientVitalsHistory extends StatefulWidget {
  final Patient patient;
  const ViewPatientVitalsHistory({super.key, required this.patient});

  @override
  State<ViewPatientVitalsHistory> createState() => _ViewPatientVitalsHistoryState();
}

class _ViewPatientVitalsHistoryState extends State<ViewPatientVitalsHistory> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Pallete.primaryColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
            '${widget.patient.personalDetails!.firstName.toString()}`s Vitals',
          style: const TextStyle(
            color: Colors.white
          ),
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
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 16,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topRight: Radius.circular(30))
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: StreamBuilder<List<Vitals>>(
            stream: VitalsServices.streamAllVitals(
              patientEmail: widget.patient.personalDetails!.email!,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No vitals found.'));
              }

              final vitalsList = snapshot.data!;

              return ListView.builder(
                itemCount: vitalsList.length,
                itemBuilder: (context, index) {
                  return VitalsCard(vitals: vitalsList[index]);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
