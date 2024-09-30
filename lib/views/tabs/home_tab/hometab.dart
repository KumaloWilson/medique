import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medique/core/constants/local_image_constants.dart';
import 'package:medique/core/utils/routes.dart';
import '../../../animations/leftbounce_animation.dart';
import '../../../animations/rightbounce_animation.dart';
import '../../../core/constants/color_constants.dart';
import '../../../widgets/drawer/doctor_drawer.dart';
import 'ai_hub/ai_hub.dart';

class NurseHomeScreen extends StatefulWidget {
  const NurseHomeScreen({super.key});

  @override
  _NurseHomeScreenState createState() => _NurseHomeScreenState();
}

class _NurseHomeScreenState extends State<NurseHomeScreen> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DoctorDrawer(
        user: user!,
      ),
      backgroundColor: Pallete.primaryColor,
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Pallete.primaryColor,
          automaticallyImplyLeading: false,
          leading: Builder(builder: (context) {
            return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(
                  Icons.menu_sharp,
                  color: Colors.white,
                ));
          }),
          title: ListTile(
            contentPadding: EdgeInsets.zero,
            subtitle: Text(
              user!.displayName ?? 'username',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.white),
            ),
            title: const Text(
              'Good Morning!',
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
            trailing: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
              child: const CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?q=80&w=1727&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
              ),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Container(
              color: Colors.white,
              child: Container(
                decoration: const BoxDecoration(
                    color: Pallete.primaryColor,
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(40))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        width: 270,
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
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
          )
      ),
      body: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topRight: Radius.circular(30))),
        padding: const EdgeInsets.all(16.0),
        child: ListView(children: [
          Row(
            children: [
              Expanded(
                child: BounceFromLeftAnimation(
                  delay: 1.5,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(RoutesHelper.nurseAddPatientScreen,
                          arguments: user);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Pallete.primaryColor)),
                      child: Column(
                        children: [
                          Image.asset(
                            LocalImageConstants.addPatients,
                            height: 120,
                          ),
                          const Text(
                            'Add Patient',
                            style: TextStyle(
                              color: Pallete.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: BounceFromRightAnimation(
                  delay: 1.5,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(RoutesHelper.viewAllPatientsScreen);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Pallete.primaryColor)),
                      child: Column(
                        children: [
                          Image.asset(
                            LocalImageConstants.patientBed,
                            height: 120,
                          ),
                          const Text(
                            'View Patients',
                            style: TextStyle(
                              color: Pallete.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Expanded(
                child: BounceFromRightAnimation(
                  delay: 1.5,
                  child: GestureDetector(
                    onTap: () {

                      Get.toNamed(RoutesHelper.tbScanner);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Pallete.primaryColor)),
                      child: Column(
                        children: [
                          Image.asset(
                            LocalImageConstants.xRayScanner,
                            height: 120,
                          ),
                          Text(
                            'TB Scanner',
                            style: TextStyle(
                              color: Pallete.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: BounceFromLeftAnimation(
                  delay: 1.5,
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => const PatientsScreen(),
                      //   ),
                      // );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Pallete.primaryColor)),
                      child: Column(
                        children: [
                          Image.asset(
                            LocalImageConstants.patientBed,
                            height: 120,
                          ),
                          const Text(
                            'Staff',
                            style: TextStyle(
                              color: Pallete.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Expanded(
                child: BounceFromRightAnimation(
                  delay: 2,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Pallete.primaryColor)),
                      child: Column(
                        children: [
                          Image.asset(
                            LocalImageConstants.labTest,
                            height: 120,
                          ),
                          const Text(
                            'Lab Tests',
                            style: TextStyle(
                              color: Pallete.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: BounceFromLeftAnimation(
                  delay: 2,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Pallete.primaryColor)),
                    child: Column(
                      children: [
                        Image.asset(
                          LocalImageConstants.patientChart,
                          height: 120,
                        ),
                        const Text(
                          'Patient Charts',
                          style: TextStyle(
                            color: Pallete.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
