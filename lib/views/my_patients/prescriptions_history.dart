import 'package:MediGuideAI/models/patient.dart';
import 'package:MediGuideAI/views/widgets/medicine_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../constant/colors.dart';
import '../../../models/prescriptions_model.dart';
import '../../../services/prescription_services/prescription.dart';
import '../../widgets/network_error.dart';

class PatientMedicalHistory extends StatefulWidget {
  final Patient patient;
  const PatientMedicalHistory({super.key, required this.patient});

  @override
  State<PatientMedicalHistory> createState() => _PatientMedicalHistoryState();
}

class _PatientMedicalHistoryState extends State<PatientMedicalHistory> with SingleTickerProviderStateMixin{

  final PagingController<int, Prescription> _prescriptionsHistoryPagingController = PagingController(firstPageKey: 1);
  final PagingController<int, Prescription> _prescriptionsPagingController = PagingController(firstPageKey: 1);
  late TabController _tabController;
  final user = FirebaseAuth.instance.currentUser;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _prescriptionsPagingController.addPageRequestListener((pageKey) {
      PrescriptionServices.getCurrentPrescriptionByPatientEmail(
          email: widget.patient.personalDetails!.email!,
          pageSize: 5,
          pageKey: pageKey,
          pagingController: _prescriptionsPagingController
      );
    });


    _prescriptionsHistoryPagingController.addPageRequestListener((pageKey) {
      PrescriptionServices.getPrescriptionHistoryByPatientEmail(
          email: widget.patient.personalDetails!.email!,
          pageSize: 5,
          pageKey: pageKey,
          pagingController: _prescriptionsHistoryPagingController
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Pallete.primaryColor,
        centerTitle: true,
        title: const Text(
            'Prescriptions'
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Container(
            color: Colors.white,
            child: Container(
              decoration: const BoxDecoration(
                  color: Pallete.primaryColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  TabBar(
                    controller: _tabController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Colors.white,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 6),
                    tabs: const [

                      Tab(
                        text: 'Ongoing',
                      ),
                      Tab(
                        text: 'History',
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topRight: Radius.circular(30))
        ),
        child: TabBarView(
          controller: _tabController,
          children:<Widget>[
            PagedListView<int,  Prescription>(
              pagingController: _prescriptionsPagingController,
              builderDelegate: PagedChildBuilderDelegate<Prescription>(
                itemBuilder: (context, prescription, index) {

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
                              style: TextStyle(
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
                          style: TextStyle(
                              color: Pallete.lightPrimaryTextColor
                          ),
                        ),
                      ],
                    ),
                  );
                },
                firstPageErrorIndicatorBuilder: (_) =>
                    NetworkError(onTap: () {}),
                animateTransitions: true,
              ),
            ),

            PagedListView<int,  Prescription>(
              pagingController: _prescriptionsHistoryPagingController,
              builderDelegate: PagedChildBuilderDelegate<Prescription>(
                itemBuilder: (context, prescription, index) {
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
                              prescription.prescriptionDate.toString(),
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
                          style: TextStyle(
                              color: Pallete.lightPrimaryTextColor
                          ),
                        ),
                      ],
                    ),
                  );
                },
                firstPageErrorIndicatorBuilder: (_) =>
                    NetworkError(onTap: () {}),
                animateTransitions: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
