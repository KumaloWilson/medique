import 'package:MediGuideAI/helpers/helpers/genenal_helpers.dart';
import 'package:MediGuideAI/models/patient.dart';
import 'package:MediGuideAI/services/prescription_services/prescription.dart';
import 'package:MediGuideAI/views/doctor_module/tabs/home_tab/ai_hub/symptom_checker.dart';
import 'package:MediGuideAI/views/doctor_module/tabs/home_tab/ai_hub/xray_scanner.dart';
import 'package:MediGuideAI/views/universal_screens/medical_chatbot/medical_chatbot.dart';
import 'package:MediGuideAI/views/widgets/custom_dropdown.dart';
import 'package:MediGuideAI/views/widgets/custom_loader.dart';
import 'package:MediGuideAI/views/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../constant/colors.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/custome_button2.dart';
import '../../widgets/dialogs/error_dialog.dart';

class PrescribeMedicine extends StatefulWidget {
  final Patient patient;
  const PrescribeMedicine({super.key, required this.patient});

  @override
  State<PrescribeMedicine> createState() => _PrescribeMedicineState();
}

class _PrescribeMedicineState extends State<PrescribeMedicine> {
  List<Map<String, String>> medicines = [];
  List<String> dosageUnits = ['mg', 'g', 'ml', 'units'];
  String selectedDosageUnit = 'mg';
  List<String> frequencies = ['Once daily', 'Twice Daily', '3 times a day', ' 4 times a day' ];
  String selectedFrequency = '3 times a day';

  final TextEditingController _medicationController = TextEditingController();
  final TextEditingController _dosageController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;

  Future<List<String>> _getMedicationSuggestions(String query) async {
    try {
      final response = await http.get(Uri.parse('https://api.fda.gov/drug/drugsfda.json?search=$query'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('results')) {
          final List<dynamic> results = data['results'];
          return results
              .where((item) => item['openfda'] != null && item['openfda'].containsKey('brand_name'))
              .map((item) => item['openfda']['brand_name'][0].toString())
              .toList();
        }
      }
    } catch (e) {
      print('Error fetching medication suggestions: $e');
    }
    return [];
  }


  void _addMedicine() {
    setState(() {
      medicines.add({
        'name': _medicationController.text,
        'dosage': "${_dosageController.text} $selectedDosageUnit",
        'frequency': selectedFrequency,
        'duration': "${_durationController.text} days",
      });
      _medicationController.clear();
      _dosageController.clear();
      _durationController.clear();
      _notesController.clear();

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
        title: const Text('Prescribe Medicine'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Container(
            color: Colors.white,
            child: Container(
              decoration: const BoxDecoration(
                color: Pallete.primaryColor,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: 270,
                      child: TypeAheadField(
                        controller: _medicationController,
                        decorationBuilder: (context, child) => DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Pallete.primaryColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: child,
                        ),
                        suggestionsCallback: (pattern) async {
                          return await _getMedicationSuggestions(pattern);
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Text(suggestion),
                          );
                        },
                        onSelected: (suggestion) {
                          _medicationController.text = suggestion;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          PopupMenuButton<int>(
            onSelected: (value) {
              switch (value) {
                case 0:
                  Helpers.temporaryNavigator(context, const AskMediGuideScreen());
                  break;
                case 1:
                // Perform action for option 1
                  Helpers.temporaryNavigator(context, const XrayScanner());
                  break;

                case 2:
                // Perform action for option 1
                  Helpers.temporaryNavigator(context, const SymptomChecker());
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 0,
                child: Text('Ask MediGuide'),
              ),

              const PopupMenuItem(
                value: 1,
                child: Text('Check Xray'),
              ),

              const PopupMenuItem(
                value: 2,
                child: Text('Check Symptoms'),
              ),

            ],
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topRight: Radius.circular(30))),
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            CustomDropdownWidget(
              items: frequencies,
              selectedValue: selectedFrequency,
              onChanged: (value) {
                setState(() {
                  selectedFrequency = value!;
                });
              },
            ),
            
            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: CustomTextField(
                    labelText: 'Dosage',
                    prefixIcon: const Icon(Icons.scale),
                    controller: _dosageController,
                    keyBoardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: CustomDropdownWidget(
                    items: dosageUnits,
                    selectedValue: selectedDosageUnit,
                    onChanged: (value) {
                      setState(() {
                        selectedDosageUnit = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 10),
            CustomTextField(
              labelText: 'Duration in (Days)',
              prefixIcon: const Icon(
                  Icons.calendar_month
              ),
              controller: _durationController,
              keyBoardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 60
              ),
              child: CustomButton(
                onTap: _addMedicine,
                btnColor: Pallete.primaryColor,
                height: 40,
                width: 60,
                borderRadius: 10,
                child: const Text(
                  'Add Medicine',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            const SizedBox(height: 20),
            const Text(
              'Added Medicines',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...medicines.map((medicine) {
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.red,
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                onDismissed: (direction) {
                  medicines.remove(medicine);
                },
                child: ListTile(
                  title: Text(
                    medicine['name']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Pallete.primaryColor
                    ),
                  ),
                  subtitle: Text(
                      'Dosage: ${medicine['dosage']} - Frequency: ${medicine['frequency']} - Duration: ${medicine['duration']}'
                  ),
                ),
              );
            }).toList(),

            const SizedBox(height: 20),
            const Text(
              'Patient Notes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: _notesController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                labelText: 'Additional Notes',
                border: const OutlineInputBorder(),
                labelStyle: GoogleFonts.poppins(
                  color: Colors.grey,
                  fontSize: 12,
                ),
                prefixIcon: const Icon(Icons.notes),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Pallete.primaryColor
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: CustomButton(
          btnColor: Pallete.primaryColor,
          borderRadius: 10,
          width: MediaQuery.sizeOf(context).width,
          onTap: (){
            validateAndSubmitForm();
          },
          child: const Text(
            'Prescribe Medicine',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          ),
        ),
      ),
    );
  }


  void showErrorDialog(String errorMessage) {
    showDialog(
        context: context,
        builder: (context) => ErrorDialog(
          errorMessage: errorMessage,
        )
    );
  }

  void validateAndSubmitForm() async {
    if (_dosageController.text.isEmpty && medicines.isEmpty) {
      showErrorDialog('Please input Dosage.');
      return;
    }

    if (_durationController.text.isEmpty && medicines.isEmpty) {
      showErrorDialog('Please enter Duration');
      return;
    }

    if (_medicationController.text.length < 8 && medicines.isEmpty) {
      showErrorDialog('Please input medication');
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const CustomLoader(message: 'Prescribing');
      }
    );

    await PrescriptionServices.sendPrescription(
        patientEmail: widget.patient.personalDetails!.email!,
        doctorEmail: user!.email!,
        medicines: medicines,
        notes: _notesController.text
    ).then((status){
      if(status == 200 || status == 201) {
        Helpers.back(context);
        Helpers.back(context);
        ScaffoldMessenger.of(context).showSnackBar(MySnackBars.prescriptionSnackBar);
      }else{
        Helpers.back(context);
        showErrorDialog('Unknown Error Please Try again');
      }
    });

  }
}
