
class NextOfKinDetails {
  String? nationalId;
  String? occupation;
  String? address;
  String? phoneNumber;
  String? gender;
  String? nationality;
  String? dateOfBirth;
  String? title;
  String? relationship;
  String? firstName;
  String? email;
  String? lastName;

  NextOfKinDetails({
    this.nationalId,
    this.occupation,
    this.address,
    this.phoneNumber,
    this.gender,
    this.nationality,
    this.dateOfBirth,
    this.title,
    this.relationship,
    this.firstName,
    this.email,
    this.lastName,
  });

  factory NextOfKinDetails.fromJson(Map<String, dynamic> json) {
    return NextOfKinDetails(
      nationalId: json['national-id'],
      occupation: json['occupation'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      gender: json['gender'],
      nationality: json['nationality'],
      dateOfBirth: json['date-of-birth'],
      title: json['title'],
      relationship: json['relationship'],
      firstName: json['first-name'],
      email: json['email'],
      lastName: json['last-name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'national-id': nationalId,
      'occupation': occupation,
      'address': address,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'nationality': nationality,
      'date-of-birth': dateOfBirth,
      'title': title,
      'relationship': relationship,
      'first-name': firstName,
      'email': email,
      'last-name': lastName,
    };
  }
}
