import 'dart:io';
import 'package:get/get.dart';

import '../../core/utils/logs.dart';
import 'package:path/path.dart' as path;

import '../../services/storage_services.dart';
import '../../widgets/circular_loader/circular_loader.dart';
import '../../widgets/snackbar/custom_snackbar.dart';

class StorageHelper {
  static Future<String?> triggerDocUpload({required String documentName, required dynamic selectedFile}) async {

    Get.log('File ${selectedFile['bytes']}');

    Get.log('Name ${selectedFile['name']}');

    if (selectedFile != null) {
      Get.dialog(
        const CustomLoader(
          message: 'Uploading Document',
        ),
        barrierDismissible: false,
      );

      final response = await StorageServices.uploadDocumentAsUint8List(
        location: 'documents',
        uploadfile: selectedFile['bytes'],
        fileName: selectedFile['name'],
      );

      if (response.success) {
        DevLogs.logSuccess("File uploaded successfully: ${response.data}");

        if (Get.isDialogOpen!) Get.back();

        CustomSnackBar.showSuccessSnackbar(
            message: 'Document uploaded Successfully');

        return response.data!;
      } else {
        DevLogs.logError("File upload failed: ${response.message}");
      }
    }
    return null;
  }
}
