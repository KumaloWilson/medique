import 'package:flutter/material.dart';
import 'package:medique/core/constants/color_constants.dart';
import 'package:medique/models/patient.dart';
import 'package:medique/services/patient_services.dart';
import '../../widgets/cards/patient_card.dart';

class PatientsScreen extends StatefulWidget {
  const PatientsScreen({super.key});

  @override
  State<PatientsScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Pallete.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text('My Patients', style: TextStyle(color: Colors.white),),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Container(
            color: Colors.white,
            child: Container(
              decoration: const BoxDecoration(
                color: Pallete.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: 270,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value.trim();
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
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
          borderRadius: BorderRadius.only(topRight: Radius.circular(30)),
        ),
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<List<Patient>>(
          stream: PatientServices.streamAllUsers(), // Use the stream here
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error loading patients.'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No patients found.'));
            }

            List<Patient> patients = snapshot.data!;

            if (_searchQuery.isNotEmpty) {
              patients = patients.where((patient) {
                final name = '${patient.personalDetails!.firstName} ${patient.personalDetails!.lastName}'.toLowerCase();
                return name.contains(_searchQuery.toLowerCase());
              }).toList();
            }

            return ListView(
              children: [
                _buildSection('All Patients', patients),
                _buildSection('Admitted', patients.where((p) => p.status == 'admitted').toList()),
                _buildSection('Discharged', patients.where((p) => p.status == 'discharged').toList()),
                _buildSection('Deceased', patients.where((p) => p.status == 'deceased').toList()),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Patient> patients) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                // Handle view all action if needed
              },
              child: const Text(
                'See all',
                style: TextStyle(
                  color: Pallete.primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 225,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: patients.length,
            itemBuilder: (context, index) {
              return PatientCard(patient: patients[index]);
            },
          ),
        ),
      ],
    );
  }
}
