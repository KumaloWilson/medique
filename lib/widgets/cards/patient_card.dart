

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medique/core/utils/routes.dart';
import 'package:medique/repository/helpers/add_patinet_helper.dart';

import '../../models/patient.dart';

class PatientCard extends StatelessWidget {
  final double? marginRight;
  final Patient patient;
  const PatientCard({super.key, required this.patient, this.marginRight});



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> Get.toNamed(RoutesHelper.viewPatientScreen, arguments: patient),
      child: Container(
        margin: EdgeInsets.only(right: marginRight ?? 20, bottom: 10, top: 2),
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              offset: const Offset(2, 2),
              blurRadius: 6,
            ),
            BoxShadow(
              color: Colors.grey.shade50,
              offset: const Offset(-2, -2),
              blurRadius: 6,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage(
                         patient.personalDetails!.displayPicture ?? ''
                      )
                  )
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${patient.personalDetails!.firstName} ${patient.personalDetails!.lastName}',
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    patient.status ?? 'Unknown',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                      patient.personalDetails!.gender!,
                      style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.bold,
                          fontSize: 13)
                  ),

                  Text(
                    '${AddPatientHelper.calculateAge(patient.personalDetails!.dateOfBirth!)} years',
                    style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.bold,
                          fontSize: 13)
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
