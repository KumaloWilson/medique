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
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          PopupMenuButton<int>(
            onSelected: (value) {
              switch (value) {
                case 0:
                  Get.toNamed(RoutesHelper.addVitalsScreen, arguments: [user, widget.patient]);
                  break;
                case 1:
                  //Helpers.temporaryNavigator(context, PrescribeMedicine(patient: widget.patient,));
                  break;
                case 2:
                  Get.toNamed(RoutesHelper.askMediguideScreen);
                  break;

                case 3:
                  Get.toNamed(RoutesHelper.viewPatientVitalsHistory, arguments: widget.patient);
                  break;

                case 4:
                // Perform action for option 1
                  //Helpers.temporaryNavigator(context, PatientMedicalHistory(patient: widget.patient,));
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 0,
                child: Text('Add Vitals', style: TextStyle(fontSize: 14),),
              ),

              const PopupMenuItem(
                value: 1,
                child: Text('Prescribe Medicine', style: TextStyle(fontSize: 14),),
              ),

              const PopupMenuItem(
                value: 2,
                child: Text('Ask MediGuide', style: TextStyle(fontSize: 14),),
              ),

              const PopupMenuItem(
                value: 3,
                child: Text('Vitals History', style: TextStyle(fontSize: 14),),
              ),

              const PopupMenuItem(
                value: 4,
                child: Text('Medical History', style: TextStyle(fontSize: 14),),
              ),

            ],
          ),
        ],

      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  color: Colors.white,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                       horizontal: 16,
                       vertical: 24
                    ),
                    height: 350,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(40)
                        ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                              ),
                              decoration: const BoxDecoration(
                                  color: Pallete.primaryColor,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                  )
                              ),
                              child: Text(
                                widget.patient.personalDetails!.gender ?? '',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
                              ),
                            ).animate().slideY(
                                begin: -10,
                                duration: const Duration(seconds: 2))
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          "${widget.patient.personalDetails!.firstName} ${widget.patient.personalDetails!.lastName}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                            '${AddPatientHelper.calculateAge(widget.patient.personalDetails!.dateOfBirth!)} years',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.only(topRight: Radius.circular(40))),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'About',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey,
                            )
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Contact Details',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Email",
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.bold,
                                    fontSize: 14
                                  ),
                                ),
                                Text(
                                  widget.patient.personalDetails!.email ?? '',
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 14
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 8,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Phone Number",
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14
                                  ),
                                ),
                                Text(
                                  widget.patient.personalDetails!.phoneNumber ?? '',
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 14
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 8,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Address",
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14
                                  ),
                                ),
                                Text(
                                  widget.patient.personalDetails!.address ?? '',
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 14
                                  ),
                                ),
                              ],
                            ),



                            const SizedBox(
                              height: 8,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "City",
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14
                                  ),
                                ),
                                Text(
                                  widget.patient.personalDetails!.email ?? '',
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 14
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey,
                            )
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Next of Kin',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,

                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Name",
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14
                                  ),
                                ),
                                Text(
                                  widget.patient.nextOfKinDetails != null
                                      ? "${widget.patient.nextOfKinDetails!.firstName.toString()} ${widget.patient.nextOfKinDetails!.lastName.toString()}"
                                      : '',
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 14
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 8,
                            ),


                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Email",
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.bold,
                                      fontSize: 14
                                  ),
                                ),
                                Text(
                                  widget.patient.nextOfKinDetails != null
                                    ? widget.patient.nextOfKinDetails!.email.toString()
                                    : '',
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 14
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 8,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Phone Number",
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14
                                  ),
                                ),
                                Text(
                                  widget.patient.nextOfKinDetails != null
                                      ? widget.patient.nextOfKinDetails!.phoneNumber.toString()
                                      : '',
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 14
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 8,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Address",
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14
                                  ),
                                ),
                                Text(
                                  widget.patient.nextOfKinDetails != null
                                      ? widget.patient.nextOfKinDetails!.address.toString()
                                      : '',
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 14
                                  ),
                                ),
                              ],
                            ),



                            const SizedBox(
                              height: 8,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "City",
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  widget.patient.nextOfKinDetails != null
                                      ? widget.patient.nextOfKinDetails!.nationality.toString()  : '',
                                  style: TextStyle(
                                      color: Colors.grey.shade600
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              right: 16,
              top: 60,
              child: CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(
                  widget.patient.personalDetails!.displayPicture ?? NetworkImageConstants.logo,
                )
              ),
            )
          ],
        ),
      ),
    );
  }


}




