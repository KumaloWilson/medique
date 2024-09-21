import 'package:medique/models/patient_personal_details.dart';

import 'next_of_kin.dart';

class Patient {
  String? id;
  PatientPersonalDetails? personalDetails;
  NextOfKinDetails? nextOfKinDetails;
  String? status;

  Patient({
    this.id,
    this.personalDetails,
    this.nextOfKinDetails,
    this.status
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      status: json['status'],
      personalDetails: json['personal-details'] != null
          ? PatientPersonalDetails.fromJson(json['personal-details'])
          : null,
      nextOfKinDetails: json['next-of-kin-details'] != null
          ? NextOfKinDetails.fromJson(json['next-of-kin-details'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'personal-details': personalDetails?.toJson(),
      'next-of-kin-details': nextOfKinDetails?.toJson(),
    };
  }
}
