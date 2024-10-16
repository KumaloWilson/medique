import 'package:get/get.dart';
import '../../models/prescription.dart';
import '../../services/prescription_services.dart';
import '../../widgets/circular_loader/circular_loader.dart';
import '../../widgets/snackbar/custom_snackbar.dart';

class PrescriptionHelpers{

  static void validateAndSubmitForm({required Prescription prescription, required String dosage, required String duration, required String medication }) async {
    if (dosage.isEmpty && prescription.medicines.isEmpty) {
      CustomSnackBar.showErrorSnackbar(message: 'Please input Dosage.');
      return;
    }

    if (duration.isEmpty && prescription.medicines.isEmpty) {
      CustomSnackBar.showErrorSnackbar(message: 'Please enter Duration');
      return;
    }

    if (medication.length < 8 && prescription.medicines.isEmpty) {
      CustomSnackBar.showErrorSnackbar(message: 'Please input medication');
      return;
    }


    Get.dialog(
      const CustomLoader(
        message: 'Prescribing medication',
      ),
      barrierDismissible: false,
    );


    await PrescriptionServices.addPrescription(prescription: prescription)
        .then((response) {
      if (!response.success) {
        if (!Get.isSnackbarOpen) Get.back();
        CustomSnackBar.showErrorSnackbar(message: response.message ?? 'Something went wrong');
      } else {
        CustomSnackBar.showSuccessSnackbar(message: 'Prescription added successfully');
        CustomSnackBar.showSuccessSnackbar(message: 'Prescription added successfully');
        if (Get.isDialogOpen!) Get.back(closeOverlays: true);
      }
    });
  }
}