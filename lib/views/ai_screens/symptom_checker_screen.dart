import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medique/core/utils/api_response.dart';
import 'package:medique/core/utils/routes.dart';
import 'package:medique/widgets/custom_button/general_button.dart';

import '../../core/constants/color_constants.dart';
import '../../services/symptoms_services.dart';

class SymptomCheckerScreen extends StatefulWidget {
  const SymptomCheckerScreen({super.key});

  @override
  State<SymptomCheckerScreen> createState() => _SymptomCheckerScreenState();
}

class _SymptomCheckerScreenState extends State<SymptomCheckerScreen> {
  final TextEditingController _symptomsController = TextEditingController();
  String? _response;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.primaryColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Symptom Checker',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSymptomsInput(),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8
        ),
        child: _response != null
            ? GeneralButton(
          borderRadius: 10,
          btnColor: Pallete.primaryColor,
          width: 200,
          onTap: (){

          },
          child: const Text(
            'Submit Symptoms',
            style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold
            ),
          ),
        )
            : Row(
          children: [
            Expanded(
              child: GeneralButton(
                borderRadius: 10,
                btnColor: Pallete.primaryColor,
                width: 200,
                onTap: (){

                },
                child: const Text(
                  'Recheck',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: GeneralButton(
                borderRadius: 10,
                btnColor: Pallete.primaryColor,
                width: 200,
                onTap: (){
                  Get.toNamed(RoutesHelper.chatBotScreen, arguments: _response ?? '');
                },
                child: const Text(
                  'Next',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            )
          ],
        )
      ),
    );
  }

  Widget _buildSymptomsInput() {
    return TextField(
      controller: _symptomsController,
      decoration: InputDecoration(
        labelText: 'Enter your symptoms',
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      maxLines: 3,
    );
  }



  Widget _buildResponseText() {
    return _response != null
        ? Text(
      _response!,
      style: const TextStyle(fontSize: 16, color: Colors.black54),
      textAlign: TextAlign.center,
    )
        : const SizedBox.shrink();
  }

  Future<void> _submitSymptoms() async {
    setState(() {
      _isLoading = true;
      _response = null;
    });

    final APIResponse<String> apiResponse = await SymptomsServices.submitSymptoms(
      inputText: _symptomsController.text,
    );

    setState(() {
      _isLoading = false;
      _response = apiResponse.success ? apiResponse.data : apiResponse.message;
    });
  }
}

