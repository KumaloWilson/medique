import 'package:flutter/material.dart';
import 'package:medique/core/constants/color_constants.dart';
import 'package:medique/models/prescription.dart';
import 'medicine_card.dart';

class PrescriptionCard extends StatelessWidget {
  final Prescription prescription;
  const PrescriptionCard({super.key, required this.prescription});

  @override
  Widget build(BuildContext context) {

    List<String> dateAndTime = prescription.prescriptionDate.toString().split(' ');


    String date = dateAndTime[0];
    String time = dateAndTime[1];

    // Split the time to get hours and minutes
    List<String> timeParts = time.split(':');
    String hours = timeParts[0];
    String minutes = timeParts[1];



    return Container(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Row(
                children: [
                  Text(
                    "$hours:$minutes",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Pallete.primaryColor
                    ),
                  ),

                  SizedBox(
                    width: 16,
                  ),

                  Text(
                    date,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Pallete.primaryColor
                    ),

                  ),
                ],
              ),
              PopupMenuButton<int>(
                onSelected: (value) {
                  switch (value) {
                    case 0:
                    // Perform action for option 1
                      print('Option 1 selected');
                      break;
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 0,
                    child: Text('Download Copy'),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          const Divider(),

          SizedBox(
            height: 190,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: prescription.medicines.map((e) => MedicineCard(medicine: e)).toList(),
            ),
          ),

          const SizedBox(
            height: 8,
          ),


          const Divider(color: Pallete.primaryColor,),
          if(prescription.notes.isNotEmpty)const Text(
            'Notes',
            style: TextStyle(
                fontWeight: FontWeight.bold
            ),
          ),

          const SizedBox(
            height: 8,
          ),

          Text(
            prescription.notes,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12
            ),
          ),
        ],
      ),
    );
  }
}
