import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medique/models/patient.dart';
import 'package:medique/widgets/custom_button/general_button.dart';
import '../../core/constants/color_constants.dart';
import '../../repository/helpers/vitals_helper.dart';
import '../../widgets/text_fields/custom_text_field.dart';


class AddVitalsScreen extends StatefulWidget {
  final User user;
  final Patient patient;
  const AddVitalsScreen({super.key, required this.user, required this.patient});

  @override
  State<AddVitalsScreen> createState() => _AddVitalsScreenState();
}

class _AddVitalsScreenState extends State<AddVitalsScreen> {
  final TextEditingController _diasBloodPressureController = TextEditingController();
  final TextEditingController _sysBloodPressureController = TextEditingController();
  final TextEditingController _heartRateController = TextEditingController();
  final TextEditingController _respiratoryRateController = TextEditingController();
  final TextEditingController _oxygenSaturationController = TextEditingController();
  final TextEditingController _temperatureController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _bmiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.primaryColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Add Vitals',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Icon(FontAwesomeIcons.stethoscope, color: Pallete.primaryColor, size: 100,),
            const SizedBox(height: 20),
            buildVitalsForm(),
            const SizedBox(height: 30),
            Center(
              child: GeneralButton(
                onTap: (){
                  VitalsHelper.validateAndAnalyze(
                    patient: widget.patient,
                    bloodPressure: "${_sysBloodPressureController.text}/${_diasBloodPressureController.text}",
                    heartRate: _heartRateController.text,
                    height: _heightController.text,
                    oxygenSaturation: _oxygenSaturationController.text,
                    respiratoryRate: _respiratoryRateController.text,
                    temperature: _temperatureController.text,
                    weight: _weightController.text,
                  );
                },
                width: 200,
                btnColor: Pallete.primaryColor,
                borderRadius: 10,
                child: const Text(
                  'Submit Vitals',
                  style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildVitalsForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: _sysBloodPressureController,
                labelText: "Systolic BP",
                prefixIcon: const Icon(FontAwesomeIcons.stethoscope, color: Colors.redAccent),
                keyBoardType: TextInputType.text,
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CustomTextField(
                controller: _diasBloodPressureController,
                labelText: "Diastolic BP",
                prefixIcon: const Icon(FontAwesomeIcons.stethoscope, color: Pallete.primaryColor),
                keyBoardType: TextInputType.text,
                fillColor: Colors.grey[200],
                filled: true
              ),
            ),
          ],
        ),

        const SizedBox(height: 15),
        CustomTextField(
          controller: _heartRateController,
          labelText: "Heart Rate (bpm)",
          prefixIcon: const Icon(Icons.favorite, color: Pallete.primaryColor),
          keyBoardType: TextInputType.number,
          fillColor: Colors.grey[200],
          filled: true,
        ),
        const SizedBox(height: 15),
        CustomTextField(
          controller: _respiratoryRateController,
          labelText: "Respiratory Rate (breaths/min)",
          prefixIcon: const Icon(Icons.air, color: Colors.blueAccent),
          keyBoardType: TextInputType.number,
          fillColor: Colors.grey[200],
          filled: true,
        ),
        const SizedBox(height: 15),
        CustomTextField(
          controller: _oxygenSaturationController,
          labelText: "Oxygen Saturation (%)",
          prefixIcon: const Icon(Icons.bubble_chart, color: Colors.blue),
          keyBoardType: TextInputType.number,
          fillColor: Colors.grey[200],
          filled: true,
        ),
        const SizedBox(height: 15),
        CustomTextField(
          controller: _temperatureController,
          labelText: "Temperature (°C)",
          prefixIcon: const Icon(Icons.thermostat, color: Colors.orangeAccent),
          keyBoardType: TextInputType.number,
          fillColor: Colors.grey[200],
          filled: true
        ),
        const SizedBox(height: 15),
        CustomTextField(
          controller: _weightController,
          labelText: "Weight (kg)",
          prefixIcon: const Icon(Icons.monitor_weight, color: Colors.green),
          keyBoardType: TextInputType.number,
          fillColor: Colors.grey[200],
          filled: true
        ),
        
        const SizedBox(height: 15),
        CustomTextField(
          controller: _heightController,
          labelText: "Height (cm)",
          prefixIcon: const Icon(Icons.height, color: Colors.purpleAccent),
          keyBoardType: TextInputType.number,
          fillColor: Colors.grey[200],
          filled: true
        ),
      ],
    );
  }
}
