import 'package:flutter/material.dart';
import 'package:medique/core/utils/api_response.dart';

import '../../services/symptoms_services.dart';

class AskMediguideScreen extends StatefulWidget {
  const AskMediguideScreen({super.key});

  @override
  State<AskMediguideScreen> createState() => _AskMediguideScreenState();
}

class _AskMediguideScreenState extends State<AskMediguideScreen> {
  final TextEditingController _symptomsController = TextEditingController();
  String? _response;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ask Mediguide'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSymptomsInput(),
            const SizedBox(height: 20),
            _buildSubmitButton(),
            const SizedBox(height: 20),
            _isLoading ? _buildLoadingIndicator() : _buildResponseText(),
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
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      maxLines: 3,
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _submitSymptoms,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15),
      ),
      child: const Text(
        'Submit Symptoms',
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const CircularProgressIndicator();
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

