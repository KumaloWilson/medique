import 'package:MediGuideAI/helpers/helpers/genenal_helpers.dart';
import 'package:MediGuideAI/views/widgets/PatientCard.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import '../../../constant/colors.dart';
import '../../../models/patient.dart';
import '../../../services/patient/get_my_patient_services.dart';
import '../../widgets/network_error.dart';

class ViewAllPatients extends StatefulWidget {
  final String category;
  const ViewAllPatients({super.key, required this.category});

  @override
  State<ViewAllPatients> createState() => _ViewAllPatientsState();
}

class _ViewAllPatientsState extends State<ViewAllPatients> {

  static const pageSize = 5;
  final PagingController<int, Patient> _patientsPagingController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _patientsPagingController.addPageRequestListener((pageKey) {
      GetMyPatient.fetchMyPatients(
          pageKey: pageKey,
          pageSize: pageSize,
          pagingController: _patientsPagingController,
          docEmail: 'DOC1711097743506'
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
                '${Helpers.capitalizeFirstLetter(widget.category)} Patients'
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
        child:PagedGridView<int, Patient>(
          pagingController: _patientsPagingController,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            mainAxisExtent: 210,
          ),
          builderDelegate: PagedChildBuilderDelegate<Patient>(
            itemBuilder: (context, patient, index) {
              return PatientCard(
                marginRight: 0,
                patient: patient,
              );
            },
            firstPageErrorIndicatorBuilder: (_) => NetworkError(
              onTap: () => (),
            ),
            animateTransitions: true,
          ),
        ),
      )
    );
  }
}
