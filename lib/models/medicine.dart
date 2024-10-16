class Medicine {
  String duration;
  String dosage;
  String name;
  String frequency;

  Medicine({
    required this.duration,
    required this.dosage,
    required this.name,
    required this.frequency,
  });

  // Factory constructor to create a Medicine object from JSON
  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      duration: json['duration'],
      dosage: json['dosage'],
      name: json['name'],
      frequency: json['frequency'],
    );
  }

  // Method to convert a Medicine object to JSON
  Map<String, dynamic> toJson() {
    return {
      'duration': duration,
      'dosage': dosage,
      'name': name,
      'frequency': frequency,
    };
  }
}