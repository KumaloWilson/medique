import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medique/core/utils/api_response.dart';

import '../core/constants/url_config.dart';

class SymptomsServices {
  static Future<APIResponse<String>> submitSymptoms({required String inputText}) async {
    try {
      final response = await http.post(
        Uri.parse('${UrlConfig.symptomCheckerUrl}/generate'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'input_text': inputText}),
      );

      // Check the response status code
      if (response.statusCode == 200) {
        // Ensure response body is in the expected format
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('generated_output')) {
          return APIResponse<String>(
            success: true,
            data: data['generated_output'],
          );
        } else {
          return APIResponse<String>(
            success: false,
            message: 'Unexpected response format.',
          );
        }
      } else {
        // Handle non-200 responses
        return APIResponse<String>(
          success: false,
          message: 'Error: ${response.statusCode} - ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      // Handle exceptions (e.g., network issues)
      return APIResponse<String>(
        success: false,
        message: 'An error occurred: $e',
      );
    }
  }
}
