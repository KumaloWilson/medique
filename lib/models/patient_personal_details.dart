
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
}
