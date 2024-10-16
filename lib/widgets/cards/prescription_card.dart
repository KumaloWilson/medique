import 'package:flutter/material.dart';
import 'package:medique/models/prescription.dart';
import 'medicine_card.dart';

class PrescriptionCard extends StatelessWidget {
  final Prescription prescription;
  const PrescriptionCard({super.key, required this.prescription});

  @override
  Widget build(BuildContext context) {
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

              Text(
                '${prescription.prescriptionDate}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,

                ),

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
            height: 170,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: prescription.medicines.map((e) => MedicineCard(medicine: e)).toList(),
            ),
          ),

          const SizedBox(
            height: 8,
          ),


          const Divider(),
          const Text(
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
                color: Colors.black
            ),
          ),
        ],
      ),
    );
  }
}
