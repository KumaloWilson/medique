import 'dart:convert';

class Vitals {
  String id;
  String email;
  String bloodPressure;
  DateTime createdAt;
  int heartRate;
  int respiratoryRate;
  String patientId;
  int oxygenSaturation;
  double temperature;
  double weight;
  double height;
  double bmi;

  Vitals({
    required this.id,
    required this.email,
    required this.bloodPressure,
    required this.createdAt,
    required this.heartRate,
    required this.respiratoryRate,
    required this.patientId,
    required this.oxygenSaturation,
    required this.temperature,
    required this.weight,
    required this.height,
    required this.bmi,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bloodPressure': bloodPressure,
      'createdAt': createdAt.toIso8601String(),
      'heartRate': heartRate,
      'respiratoryRate': respiratoryRate,
      'patientId': patientId,
      'oxygenSaturation': oxygenSaturation,
      'temperature': temperature,
      'weight': weight,
      'height': height,
      'bmi': bmi,
      'patientEmail': email,
    };
  }

  factory Vitals.fromJson(Map<String, dynamic> json) {
    return Vitals(
      id: json['id'],
      email: json['patientEmail'],
      bloodPressure: json['bloodPressure'],
      createdAt: DateTime.parse(json['createdAt']),
      heartRate: json['heartRate'],
      respiratoryRate: json['respiratoryRate'],
      patientId: json['patientId'],
      oxygenSaturation: json['oxygenSaturation'],
      temperature: json['temperature'],
      weight: json['weight'],
      height: json['height'],
      bmi: json['bmi'],
    );
  }
}
