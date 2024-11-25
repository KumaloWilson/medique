import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medique/core/constants/local_image_constants.dart';
import 'package:medique/core/utils/api_response.dart';
import 'package:medique/core/utils/routes.dart';
import 'package:medique/widgets/custom_button/general_button.dart';
import '../../core/constants/color_constants.dart';
import '../../services/symptoms_services.dart';
import '../../widgets/circular_loader/circular_loader.dart';
import '../../widgets/snackbar/custom_snackbar.dart';

class SymptomCheckerScreen extends StatefulWidget {
  const SymptomCheckerScreen({super.key});

  @override
  State<SymptomCheckerScreen> createState() => _SymptomCheckerScreenState();
}

class _SymptomCheckerScreenState extends State<SymptomCheckerScreen> {
  final TextEditingController _symptomsController = TextEditingController();
  String? _response;
  bool _isLoading = false;

  Future<void> _submitSymptoms() async {
    if (_symptomsController.text.isEmpty) {
      CustomSnackBar.showErrorSnackbar(message: 'Please enter your symptoms.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Show loader dialog
    Get.dialog(
      const CustomLoader(message: 'Checking symptoms'),
      barrierDismissible: false,
    );

    final APIResponse<String> response = await SymptomsServices.submitSymptoms(
      inputText: _symptomsController.text,
    );

    // Hide the loader
    Get.back();

    if (response.success && response.data != null) {
      final pipeIndex = response.data!.indexOf('|');
      if (pipeIndex != -1) {
        // Extract everything after the pipe
        _response = response.data!.substring(pipeIndex + 1).trim();

        setState(() {});
      } else {
        // If no pipe found, allow user to retry
        CustomSnackBar.showErrorSnackbar(
            message: 'Invalid response. Please try again.');
      }
    } else {
      CustomSnackBar.showErrorSnackbar(
          message: response.message ?? 'An error occurred. Please try again.');
    }

    setState(() {
      _isLoading = false;
    });
  }

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
            _buildResponseText(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: _isLoading
            ? const SizedBox.shrink() // No buttons when loading
            : _response == null
                ? GeneralButton(
                    borderRadius: 10,
                    btnColor: Pallete.primaryColor,
                    width: 200,
                    onTap: _submitSymptoms,
                    child: const Text(
                      'Submit Symptoms',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                : Row(
                    children: [
                      Expanded(
                        child: GeneralButton(
                          borderRadius: 10,
                          btnColor: Pallete.primaryColor,
                          width: 200,
                          onTap: _submitSymptoms, // Retry button
                          child: const Text(
                            'Recheck',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: GeneralButton(
                          borderRadius: 10,
                          btnColor: Pallete.primaryColor,
                          width: 200,
                          onTap: () {
                            Get.toNamed(
                              RoutesHelper.chatBotScreen,
                              arguments: _response ?? '',
                            );
                          },
                          child: const Text(
                            'Next',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
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
        ? Row(
      crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: AssetImage(
                  LocalImageConstants.chatBot
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20)
                  ),
                  color: Pallete.whiteColor,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, -5),
                      blurRadius: 10,
                    ),
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(5, 5),
                      blurRadius: 10,
                    ),
                  ],
                ),
                  child: Text(
                    _formatResponse(_response!),
                    style: const TextStyle(fontSize: 14, color: Colors.black,),
                    textAlign: TextAlign.start,
                  ),
                ),
            ),
          ],
        )
        : const SizedBox.shrink();
  }

  List<String> responseTemplates = [
    "Hey there! Based on the symptoms you shared, it might be {}.",
    "From the description, the patient could possibly be dealing with {}. Please consult a medical professional for confirmation.",
    "Hmm, these symptoms often indicate {}. I'd recommend verifying this with a healthcare provider.",
    "Got it! Based on what you've mentioned, {} could be the issue. Do check with a doctor to confirm.",
    "Interesting! These symptoms might point towards {}. Make sure to consult with a professional.",
    "Considering the symptoms provided, it’s possible that the patient is experiencing {}.",
    "Based on the details shared, {} could be a potential diagnosis. Please consult further.",
    "From these observations, it seems the patient might be showing signs of {}.",
    "Given these symptoms, {} is a likely condition to consider.",
    "Based on the reported symptoms, {} could be a probable cause.",
    "This presentation of symptoms aligns with {}. It’s best to confirm this with further evaluation.",
    "The symptoms provided might suggest {}. Please explore this possibility further.",
    "These signs seem consistent with {}. Further diagnostic steps are advised.",
    "Based on the provided details, the patient might be dealing with {}.",
    "Given these clinical observations, {} appears to be a plausible diagnosis.",
    "It looks like the symptoms may be indicative of {}. Please proceed with caution.",
    "These symptoms often correlate with {}. I recommend confirming this with more detailed testing.",
    "From the input provided, {} could be a likely explanation.",
    "Looking at the symptoms described, {} might be a potential issue.",
    "Based on your notes, the symptoms align with {}. Ensure further examination is conducted.",
    "These clinical signs might be connected to {}. Please consider this during your evaluation.",
    "The provided symptoms appear to match the profile of {}.",
    "In light of these symptoms, {} could be an important differential to consider.",
    "Given this description, {} may be the underlying cause.",
    "These observations suggest {}. However, further confirmation is essential.",
    "From this symptom set, the diagnosis could potentially be {}.",
    "Based on the reported signs, the patient might be suffering from {}.",
    "Given the described presentation, {} could be a possible condition.",
    "These symptoms seem aligned with {}. Be sure to investigate further.",
    "The symptom pattern provided suggests a possible case of {}.",
    "This combination of symptoms may indicate {}. Additional analysis is recommended.",
    "Given the clinical picture, {} seems to be a likely candidate.",
    "The symptoms reported may point towards {}. Further tests are advised.",
    "Based on the details shared, {} might be affecting the patient.",
    "It appears that the symptoms fit the profile of {}.",
    "From these observations, the diagnosis could involve {}.",
    "This presentation could potentially signify {}. Please confirm with a detailed assessment.",
    "Given this clinical context, {} might be a relevant consideration.",
    "The reported signs are consistent with {}. Further exploration is suggested.",
    "Based on the symptoms outlined, {} could be a reasonable hypothesis.",
    "These symptoms might be indicative of {}. Further validation is required.",
    "Considering these signs, {} might be a contributing factor.",
    "The described presentation seems to correspond to {}.",
    "This symptom pattern may suggest {}. Ensure a thorough follow-up.",
    "The patient’s symptoms might be pointing towards {}. Consider additional diagnostic measures.",
    "From this symptom profile, {} could be a likely cause.",
    "These clinical features may indicate {} as a potential diagnosis.",
    "Looking at the case details, {} seems plausible. Verification is needed.",
    "With these symptoms, {} should be a condition to rule out.",
    "This cluster of symptoms might suggest {}. Detailed testing is encouraged.",
    "The clinical presentation here aligns with {}. Ensure this is checked further.",
    "Given this symptomology, {} could be an underlying issue.",
    "The signs and symptoms point towards {}. Please verify through additional means.",
    "Based on this set of symptoms, {} may be affecting the patient.",
    "From these observations, a likely cause could be {}.",
    "This clinical description appears consistent with {}.",
    "The described symptoms may correspond to {}. A deeper look is recommended.",
    "Given these findings, {} might be the condition at play.",
    "This set of symptoms could indicate {}. Please consider this possibility.",
    "From the description, the signs may suggest {}.",
    "The observed presentation suggests {}. Further checks are needed.",
    "Given the symptom profile, {} could be a diagnosis to explore.",
    "The symptoms appear to indicate {}. I’d advise additional exploration.",
    "The patient may be showing signs consistent with {}. Further review is required.",
    "This presentation seems to match {}. Please confirm with thorough analysis.",
    "The described signs and symptoms may point to {}.",
    "Considering the details provided, {} could be the issue. Investigate further.",
    "From the clinical notes, {} might be a reasonable differential.",
    "The presented symptoms may be indicative of {}.",
    "The observations shared suggest {}. Please delve deeper into this.",
    "These findings might align with {}. Additional validation is necessary.",
    "Based on these clinical signs, {} could be a possible concern.",
    "The details provided suggest {}. I recommend exploring this in more depth.",
    "This symptom combination might indicate {}. Ensure follow-up actions.",
    "From the information shared, {} could be part of the differential diagnosis.",
    "The patient might be experiencing {} based on these signs. Validate further.",
    "These features are often associated with {}. Further assessment is warranted.",
    "From the description, {} might be affecting the patient. Check further.",
    "This clinical scenario suggests {} as a potential diagnosis.",
    "The described symptoms align with {}. A professional opinion is essential.",
    "Given the symptom set, {} could be a likely condition.",
    "These clinical signs suggest {} as a probable diagnosis.",
    "From the shared notes, {} could be an explanation. Proceed with evaluation.",
    "The described features indicate {} as a potential issue. Confirm with testing.",
    "These symptoms may align with {}. Further steps are recommended.",
    "The given clinical picture points to {}. Verify with diagnostics.",
    "The observations shared could signify {}. Follow up with care.",
    "These details suggest {} as a possible concern. Ensure further review.",
    "The noted symptoms might indicate {}. Proceed with diagnostic measures."
  ];

  String _formatResponse(String diagnosis) {
    final randomIndex = Random().nextInt(responseTemplates.length);
    return responseTemplates[randomIndex].replaceAll('{}', diagnosis);
  }
}
