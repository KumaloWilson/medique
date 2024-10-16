import 'medicine.dart';

class Prescription {
  String prescriptionId;
  List<Medicine> medicines;
  String notes;
  String prescriptionDate;
  String nurseEmail;
  String patientEmail;

  Prescription({
    required this.prescriptionId,
    required this.medicines,
    required this.notes,
    required this.prescriptionDate,
    required this.nurseEmail,
    required this.patientEmail,
  });

  factory Prescription.fromJson(Map<String, dynamic> json) {
    return Prescription(
      prescriptionId: json['prescriptionId'],
      medicines: List<Medicine>.from(json['medicines'].map((x) => Medicine.fromJson(x))),
      notes: json['notes'],
      prescriptionDate: json['prescriptionDate'],
      nurseEmail: json['doctorEmail'],
      patientEmail: json['patientEmail'],
    );
  }

  // Method to convert a Prescription object to JSON
  Map<String, dynamic> toJson() {
    return {
      'prescriptionId': prescriptionId,
      'medicines': List<dynamic>.from(medicines.map((x) => x.toJson())),
      'notes': notes,
      'prescriptionDate': prescriptionDate,
      'doctorEmail': nurseEmail,
      'patientEmail': patientEmail,
    };
  }
}

