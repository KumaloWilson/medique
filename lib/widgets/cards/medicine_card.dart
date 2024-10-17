import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';

import '../../core/constants/color_constants.dart';
import '../../models/medicine.dart';

class MedicineCard extends StatelessWidget {
  final Medicine medicine;
  const MedicineCard({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    List<IconData> icons = [
      LineIcons.pills,

      FontAwesomeIcons.pills,
    ];

    List<Color> colors = [
      Colors.redAccent,
      Pallete.primaryColor,
      Colors.green,
      Colors.pink,
      Colors.amber,
      Colors.blue
    ];

    // Create a random number generator
    final random = Random();

    // Randomly select an icon and a color
    final icon = icons[random.nextInt(icons.length)];
    final iconConColor = colors[random.nextInt(colors.length)];


    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20)
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: iconConColor,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            medicine.name.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            medicine.dosage,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            width: MediaQuery.sizeOf(context).width,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: Pallete.primaryColor,
                borderRadius: BorderRadius.circular(20)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  medicine.frequency,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12
                  ),
                ),
                const Icon(
                  Icons.watch_later,
                  color: Colors.white,
                  size: 20,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
