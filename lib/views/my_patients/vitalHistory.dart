import 'package:MediGuideAI/models/patient.dart';
import 'package:MediGuideAI/services/vitals/vital_services.dart';
import 'package:MediGuideAI/views/widgets/vitals_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import '../../../constant/colors.dart';
import '../../../models/vitals.dart';
import '../../widgets/network_error.dart';

class ViewPatientVitalsHistory extends StatefulWidget {
  final Patient patient;
  const ViewPatientVitalsHistory({super.key, required this.patient});

  State<ViewPatientVitalsHistory> createState() => _ViewAppointmentsState();
}

class _ViewAppointmentsState extends State<ViewPatientVitalsHistory> with SingleTickerProviderStateMixin {


  final PagingController<int, Vitals> _vitalsPagingController = PagingController(firstPageKey: 1);


  @override
  void initState() {
    super.initState();
    _vitalsPagingController.addPageRequestListener((pageKey) {
      VitalServices.getVitalsByPatientEmail(
          email: widget.patient.personalDetails!.email!,
          pageSize: 5,
          pageKey: pageKey,
          pagingController: _vitalsPagingController
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
        title: Text(
            '${widget.patient.personalDetails!.firstName.toString()}`s Vitals'
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
                  SizedBox(
                    height: 16,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(30))
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: PagedListView<int,   Vitals>(
              pagingController: _vitalsPagingController,
              builderDelegate: PagedChildBuilderDelegate<Vitals>(
                itemBuilder: (context, vitals, index) {
                  return VitalsCard(vitals: vitals);
                },
                firstPageErrorIndicatorBuilder: (_) =>
                    NetworkError(onTap: () {}),
                animateTransitions: true,
              ),
            ),
          )
      ),
    );
  }
}
