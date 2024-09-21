

import 'package:flutter/material.dart';

import '../../models/patient.dart';

class PatientCard extends StatelessWidget {
  final double? marginRight;
  final Patient patient;
  const PatientCard({super.key, required this.patient, this.marginRight});

  int calculateAge(String stringBirthDate) {
    // Split the date string into day, month, and year components
    List<String> dateComponents = stringBirthDate.split("-");
    int day = int.parse(dateComponents[0]);
    int month = int.parse(dateComponents[1]);
    int year = int.parse(dateComponents[2]);

    // Construct a new date string in the format "YYYY-MM-DD" (ISO 8601)
    String isoDateString = "$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}";

    // Parse the ISO date string into a DateTime object
    DateTime birthDate = DateTime.parse(isoDateString);
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;

    // Check if the birthday has occurred this year
    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month && currentDate.day < birthDate.day)) {
      age--;
    }

    return age;
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //onTap: ()=> Helpers.temporaryNavigator(context, PatientDetailsScreen(patient: patient,)),
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
              height: 100,
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
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    patient.status ?? 'Unknown',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
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
                    '\n${calculateAge(patient.personalDetails!.dateOfBirth!)} years',
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
