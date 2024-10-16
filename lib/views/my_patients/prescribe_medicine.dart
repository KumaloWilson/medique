import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:medique/models/medicine.dart';
import 'package:medique/models/prescription.dart';
import 'package:medique/services/prescription_services.dart';
import 'package:medique/widgets/custom_button/general_button.dart';
import 'package:medique/widgets/custom_dropdown.dart';
import '../../core/constants/color_constants.dart';
import '../../core/helpers/prescription_helpers.dart';
import '../../models/patient.dart';
import '../../widgets/text_fields/custom_text_field.dart';

class PrescribeMedicineScreen extends StatefulWidget {
  final Patient patient;
  const PrescribeMedicineScreen({super.key, required this.patient});

  @override
  State<PrescribeMedicineScreen> createState() => _PrescribeMedicineScreenState();
}

class _PrescribeMedicineScreenState extends State<PrescribeMedicineScreen> {
  List<Medicine> medicines = [];
  List<String> dosageUnits = ['mg', 'g', 'ml', 'units'];
  String selectedDosageUnit = 'mg';
  List<String> frequencies = ['Once daily', 'Twice Daily', '3 times a day', ' 4 times a day' ];
  String selectedFrequency = '3 times a day';

  final TextEditingController _medicationController = TextEditingController();
  final TextEditingController _dosageController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;


  void _addMedicine() {
    setState(() {
      medicines.add(
        Medicine(
          name: _medicationController.text,
          dosage: "${_dosageController.text} $selectedDosageUnit",
          frequency: selectedFrequency,
          duration: "${_durationController.text} days",
        )
      );
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
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0.0,
        backgroundColor: Pallete.primaryColor,
        centerTitle: true,
        title: const Text('Prescribe Medicine', style: TextStyle(color: Colors.white),),
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
                          final response = await PrescriptionServices.getMedicationSuggestions(pattern);

                          if(response.success){
                            return response.data;
                          }else{
                            return [];
                          }
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
                  //Helpers.temporaryNavigator(context, const AskMediGuideScreen());
                  break;
                case 1:
                // Perform action for option 1
                  //Helpers.temporaryNavigator(context, const XrayScanner());
                  break;

                case 2:
                // Perform action for option 1
                  //Helpers.temporaryNavigator(context, const SymptomChecker());
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
            CustomDropDown(
              items: frequencies,
              selectedValue: selectedFrequency,
              onChanged: (value) {
                setState(() {
                  selectedFrequency = value!;
                });
              },
              isEnabled: true,
              prefixIcon: Icons.numbers,
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
                  child: CustomDropDown(
                    isEnabled: true,
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
              child: GeneralButton(
                onTap: _addMedicine,
                btnColor: Colors.white,
                height: 40,
                width: 60,
                boxBorder: Border.all(
                  color: Pallete.primaryColor
                ),
                borderRadius: 10,
                child: const Text(
                  'Add Medicine',
                  style: TextStyle(
                    color: Pallete.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            const SizedBox(height: 20),
            const Text(
              'Added Medicines',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                child: Card(
                  child: ListTile(
                    title: Text(
                      medicine.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Pallete.primaryColor
                      ),
                    ),
                    subtitle: Text(
                        'Dosage: ${medicine.dosage}\nFrequency: ${medicine.frequency}\nDuration: ${medicine.duration}',
                      style: const TextStyle(
                        fontSize: 12
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),

            const SizedBox(height: 20),
            const Text(
              'Patient Notes',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: _notesController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                labelText: 'Additional Notes',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
                prefixIcon: Icon(Icons.notes),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              style: const TextStyle(
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
        child: GeneralButton(
          btnColor: Pallete.primaryColor,
          borderRadius: 10,
          width: MediaQuery.sizeOf(context).width,
          onTap: (){
            final prescription = Prescription(
              nurseEmail: user!.email!,
              medicines: medicines,
              notes: _notesController.text,
              patientEmail: widget.patient.personalDetails!.email!,
              prescriptionDate: DateTime.now().toString(),
              prescriptionId: '00'
            );

            PrescriptionHelpers.validateAndSubmitForm(prescription: prescription, dosage: _dosageController.text, duration: _durationController.text, medication: _medicationController.text);
          },
          child: const Text(
            'Prescribe Medicine',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.white
            ),
          ),
        ),
      ),
    );
  }

}
