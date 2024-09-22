class PatientPersonalDetails {
  String? displayPicture;
  String? occupation;
  String? address;
  String? registrationDate;
  String? gender;
  String? patientId;
  String? title;
  String? firstName;
  String? nationalId;
  String? phoneNumber;
  String? dateOfBirth;
  String? maritalStatus;
  String? email;
  String? lastName;

  PatientPersonalDetails({
    this.displayPicture,
    this.occupation,
    this.address,
    this.registrationDate,
    this.gender,
    this.patientId,
    this.title,
    this.firstName,
    this.nationalId,
    this.phoneNumber,
    this.dateOfBirth,
    this.maritalStatus,
    this.email,
    this.lastName,
  });

  factory PatientPersonalDetails.fromJson(Map<String, dynamic> json) {
    return PatientPersonalDetails(
      displayPicture: json['displayPicture'],
      occupation: json['occupation'],
      address: json['address'],
      registrationDate: json['registration-date'],
      gender: json['gender'],
      patientId: json['patientID'],
      title: json['title'],
      firstName: json['first-name'],
      nationalId: json['national-id'],
      phoneNumber: json['phoneNumber'],
      dateOfBirth: json['date-of-birth'],
      maritalStatus: json['marital-status'],
      email: json['email'],
      lastName: json['last-name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'displayPicture': displayPicture,
      'occupation': occupation,
      'address': address,
      'registration-date': registrationDate,
      'gender': gender,
      'patientID': patientId,
      'title': title,
      'first-name': firstName,
      'national-id': nationalId,
      'phoneNumber': phoneNumber,
      'date-of-birth': dateOfBirth,
      'marital-status': maritalStatus,
      'email': email,
      'last-name': lastName,
    };
  }

  // copyWith method to create a copy with optional new values for some fields
  PatientPersonalDetails copyWith({
    String? displayPicture,
    String? occupation,
    String? address,
    String? registrationDate,
    String? gender,
    String? patientId,
    String? title,
    String? firstName,
    String? nationalId,
    String? phoneNumber,
    String? dateOfBirth,
    String? maritalStatus,
    String? email,
    String? lastName,
  }) {
    return PatientPersonalDetails(
      displayPicture: displayPicture ?? this.displayPicture,
      occupation: occupation ?? this.occupation,
      address: address ?? this.address,
      registrationDate: registrationDate ?? this.registrationDate,
      gender: gender ?? this.gender,
      patientId: patientId ?? this.patientId,
      title: title ?? this.title,
      firstName: firstName ?? this.firstName,
      nationalId: nationalId ?? this.nationalId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      email: email ?? this.email,
      lastName: lastName ?? this.lastName,
    );
  }
}
