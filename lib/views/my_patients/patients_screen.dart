// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../../../models/patient.dart';
// import '../../core/constants/color_constants.dart';
//
// class PatientsScreen extends StatefulWidget {
//   const PatientsScreen({super.key});
//
//   @override
//   State<PatientsScreen> createState() => _PatientsScreenState();
// }
//
// class _PatientsScreenState extends State<PatientsScreen> {
//   final user = FirebaseAuth.instance.currentUser;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Pallete.primaryColor,
//         appBar: AppBar(
//           elevation: 0.0,
//           backgroundColor: Pallete.primaryColor,
//           centerTitle: true,
//           title: const Text('My Patients'),
//           bottom: PreferredSize(
//             preferredSize: const Size.fromHeight(100),
//             child: Container(
//               color: Colors.white,
//               child: Container(
//                 decoration: const BoxDecoration(
//                     color: Pallete.primaryColor,
//                     borderRadius:
//                         BorderRadius.only(bottomLeft: Radius.circular(40))),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: SizedBox(
//                         width: 270,
//                         child: TextField(
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: Colors.white,
//                             contentPadding: const EdgeInsets.symmetric(
//                                 horizontal: 16, vertical: 12),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30.0),
//                               borderSide: const BorderSide(color: Colors.white),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30.0),
//                               borderSide:
//                                   const BorderSide(color: Pallete.primaryColor),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30.0),
//                               borderSide: const BorderSide(color: Colors.white),
//                             ),
//                             labelText: 'Search ',
//                             labelStyle: const TextStyle(color: Colors.grey),
//                             prefixIcon: const Icon(
//                               Icons.search,
//                               color: Colors.grey,
//                               size: 30,
//                             ),
//                           ),
//                           style: const TextStyle(color: Pallete.primaryColor),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//         body: Container(
//           decoration: const BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(topRight: Radius.circular(30))),
//           padding: const EdgeInsets.all(16.0),
//           child: ListView(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   const Text(
//                     'All Patients',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       // Helpers.temporaryNavigator(
//                       //     context, const ViewAllPatients(category: 'all'));
//                     },
//                     child: const Text(
//                       'See all',
//                       style: TextStyle(
//                           color: Pallete.primaryColor,
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   )
//                 ],
//               ),
//               const SizedBox(
//                 height: 12,
//               ),
//               SizedBox(
//                 height: 210,
//                 width: MediaQuery.sizeOf(context).width,
//                 child: PagedListView<int, Patient>(
//                   scrollDirection: Axis.horizontal,
//                   pagingController: _patientsPagingController,
//                   builderDelegate: PagedChildBuilderDelegate<Patient>(
//                     itemBuilder: (context, patient, index) {
//                       return PatientCard(patient: patient);
//                     },
//                     firstPageErrorIndicatorBuilder: (_) =>
//                         NetworkError(onTap: () {}),
//                     animateTransitions: true,
//                   ),
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const Text(
//                     'Admitted',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       // Helpers.temporaryNavigator(
//                       //     context, const ViewAllPatients(category: 'admitted'));
//                     },
//                     child: const Text(
//                       'See all',
//                       style: TextStyle(
//                           color: Pallete.primaryColor,
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   )
//                 ],
//               ),
//               const SizedBox(
//                 height: 12,
//               ),
//               SizedBox(
//                 height: 210,
//                 width: MediaQuery.sizeOf(context).width,
//                 child: PagedListView<int, Patient>(
//                   scrollDirection: Axis.horizontal,
//                   pagingController: _patientsPagingController,
//                   builderDelegate: PagedChildBuilderDelegate<Patient>(
//                     itemBuilder: (context, patient, index) {
//                       return PatientCard(patient: patient);
//                     },
//                     firstPageErrorIndicatorBuilder: (_) =>
//                         NetworkError(onTap: () {}),
//                     animateTransitions: true,
//                   ),
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   const Text(
//                     'Discharged',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       // Helpers.temporaryNavigator(
//                       //     context, const ViewAllPatients(category: 'active'));
//                     },
//                     child: const Text(
//                       'See all',
//                       style: TextStyle(
//                           color: Pallete.primaryColor,
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   )
//                 ],
//               ),
//               const SizedBox(
//                 height: 12,
//               ),
//               SizedBox(
//                 height: 210,
//                 width: MediaQuery.sizeOf(context).width,
//                 child: PagedListView<int, Patient>(
//                   scrollDirection: Axis.horizontal,
//                   pagingController: _patientsPagingController,
//                   builderDelegate: PagedChildBuilderDelegate<Patient>(
//                     itemBuilder: (context, patient, index) {
//                       return PatientCard(patient: patient);
//                     },
//                     firstPageErrorIndicatorBuilder: (_) =>
//                         NetworkError(onTap: () {}),
//                     animateTransitions: true,
//                   ),
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   const Text(
//                     'Deceased',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       // Helpers.temporaryNavigator(
//                       //     context, const ViewAllPatients(category: 'deceased'));
//                     },
//                     child: const Text(
//                       'See all',
//                       style: TextStyle(
//                           color: Pallete.primaryColor,
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   )
//                 ],
//               ),
//               const SizedBox(
//                 height: 12,
//               ),
//               SizedBox(
//                 height: 210,
//                 width: MediaQuery.sizeOf(context).width,
//                 child: PagedListView<int, Patient>(
//                   scrollDirection: Axis.horizontal,
//                   pagingController: _patientsPagingController,
//                   builderDelegate: PagedChildBuilderDelegate<Patient>(
//                     itemBuilder: (context, patient, index) {
//                       return PatientCard(patient: patient);
//                     },
//                     firstPageErrorIndicatorBuilder: (_) =>
//                         NetworkError(onTap: () {}),
//                     animateTransitions: true,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
// }
