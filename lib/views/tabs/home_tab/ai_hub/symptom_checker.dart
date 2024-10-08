import 'dart:math';
import 'package:flutter/material.dart';

import '../../../../core/constants/color_constants.dart';
import '../../../../widgets/text_fields/custom_text_field.dart';

class SymptomChecker extends StatefulWidget {
  const SymptomChecker({super.key});

  @override
  State<SymptomChecker> createState() => _SymptomCheckerState();
}

class _SymptomCheckerState extends State<SymptomChecker> {

  List<String> images = [
    'https://i.pinimg.com/236x/d7/d0/4f/d7d04fb5e9fa8ee4d6e2ff5e43776eec.jpg'
    'https://i.pinimg.com/236x/11/a2/77/11a277cf98a331beff1532fc0d409b59.jpg',
    'https://i.pinimg.com/564x/6d/44/a3/6d44a3fff214e019353af783456923f4.jpg',
    "https://i.pinimg.com/236x/d9/f0/a7/d9f0a75fbbe70574da58f2781ff4dd70.jpg",
    "https://i.pinimg.com/236x/76/df/76/76df76fde12f42c61f39682aea25e48e.jpg",
    "https://i.pinimg.com/236x/2f/83/04/2f83040fbf54e283eef464927166a297.jpg",
    "https://i.pinimg.com/236x/26/10/17/261017e630da8e87710cb30e3b7b664c.jpg",
    "https://i.pinimg.com/236x/e9/3d/0a/e93d0ac8d57f99701580ae1a91268453.jpg",
    "https://i.pinimg.com/236x/24/7a/75/247a75a7125218d97cd9ad4357423b35.jpg",
    "https://i.pinimg.com/564x/d2/dc/13/d2dc13cba0b382145d6b41ba4e768a6b.jpg",
    "https://i.pinimg.com/236x/86/fc/32/86fc32f973bb2d7d654a45d91496dfa8.jpg",
    "https://i.pinimg.com/236x/e9/12/49/e91249eacd1230e12a834bdadfa55cdd.jpg",
    "https://i.pinimg.com/236x/db/ac/6a/dbac6a4ba8e27a76c44c4a31b8e43b41.jpg",
    "https://i.pinimg.com/236x/69/64/6d/69646d76b0d53bca551493cd1cc811e7.jpg"

  ];

  late String backgroundImage;

  @override
  void initState() {
    super.initState();
    backgroundImage = images[Random().nextInt(images.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            backgroundImage,
          ),
          fit: BoxFit.fitHeight,
        )
      ),

      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
              ),
              child: CustomTextField(
                labelText: 'Type any disease',
                prefixIcon: const Icon(
                  Icons.search
                ),
                suffixIconButton: IconButton(
                  onPressed: (){

                  },
                  icon: const Icon(
                    Icons.send,
                    color: Pallete.primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
