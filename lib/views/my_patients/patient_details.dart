import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:medique/core/constants/network_image_constants.dart';
import 'package:medique/core/utils/routes.dart';
import '../../core/constants/color_constants.dart';
import '../../models/patient.dart';
import '../../repository/helpers/add_patinet_helper.dart';

class PatientDetailsScreen extends StatefulWidget {
  final Patient patient;
  const PatientDetailsScreen({super.key, required this.patient});

  @override
  State<PatientDetailsScreen> createState() => _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends State<PatientDetailsScreen> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Pallete.primaryColor.withOpacity(0.9),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        shadowColor: Colors.grey.withOpacity(0.2),
        title: const Text('Patient Details', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) {
              switch (value) {
                case 0:
                  Get.toNamed(RoutesHelper.addVitalsScreen, arguments: [user, widget.patient]);
                  break;
                case 1:
                  Get.toNamed(RoutesHelper.prescribeMedicineScreen, arguments: widget.patient);
                  break;
                case 2:
                  Get.toNamed(RoutesHelper.symptomCheckerScreen);
                  break;
                case 3:
                  Get.toNamed(RoutesHelper.viewPatientVitalsHistory, arguments: widget.patient);
                  break;
                case 4:
                  Get.toNamed(RoutesHelper.viewPatientMedicalHistory, arguments: widget.patient);
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 0,
                child: ListTile(
                  leading: Icon(Icons.add, color: Pallete.primaryColor),
                  title: Text('Add Vitals'),
                ),
              ),
              const PopupMenuItem(
                value: 1,
                child: ListTile(
                  leading: Icon(Icons.local_hospital, color: Pallete.primaryColor),
                  title: Text('Prescribe Medicine'),
                ),
              ),
              const PopupMenuItem(
                value: 2,
                child: ListTile(
                  leading: Icon(Icons.help_outline, color: Pallete.primaryColor),
                  title: Text('Ask MediGuide'),
                ),
              ),
              const PopupMenuItem(
                value: 3,
                child: ListTile(
                  leading: Icon(Icons.history, color: Pallete.primaryColor),
                  title: Text('Vitals History'),
                ),
              ),
              const PopupMenuItem(
                value: 4,
                child: ListTile(
                  leading: Icon(Icons.book, color: Pallete.primaryColor),
                  title: Text('Medical History'),
                ),
              ),
            ],
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Pallete.primaryColor.withOpacity(0.1), Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "${widget.patient.personalDetails!.firstName} ${widget.patient.personalDetails!.lastName}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.black87,
                            ),
                          ).animate().slideY(delay: 300.ms, begin: -0.2),
                          const SizedBox(height: 12),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Text(
                            '${AddPatientHelper.calculateAge(widget.patient.personalDetails!.dateOfBirth!)} years',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600,
                            ),
                          ).animate().fadeIn(delay: 500.ms),
                        ],
                      ),

                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Pallete.primaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              widget.patient.personalDetails!.gender ?? '',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ).animate().fadeIn(duration: const Duration(milliseconds: 1500)),
                        ],
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'About',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildInfoCard('Contact Details', [
                        _buildInfoRow('Email', widget.patient.personalDetails!.email ?? ''),
                        _buildInfoRow('Phone Number', widget.patient.personalDetails!.phoneNumber ?? ''),
                        _buildInfoRow('Address', widget.patient.personalDetails!.address ?? ''),
                        _buildInfoRow('City', widget.patient.personalDetails!.address ?? ''),
                      ]),
                      const SizedBox(height: 10),
                      _buildInfoCard('Next of Kin', [
                        _buildInfoRow('Name', widget.patient.nextOfKinDetails != null ? "${widget.patient.nextOfKinDetails!.firstName} ${widget.patient.nextOfKinDetails!.lastName}" : ''),
                        _buildInfoRow('Email', widget.patient.nextOfKinDetails?.email ?? ''),
                        _buildInfoRow('Phone Number', widget.patient.nextOfKinDetails?.phoneNumber ?? ''),
                        _buildInfoRow('Address', widget.patient.nextOfKinDetails?.address ?? ''),
                      ]),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              right: 16,
              top: 80,
              child: CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(
                  widget.patient.personalDetails!.displayPicture ?? 'https://cdn-icons-png.flaticon.com/128/2302/2302715.png',
                ),
                backgroundColor: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Column(
            children: children,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
