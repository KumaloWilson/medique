import 'dart:math';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class PatientDetailsScreen extends StatefulWidget {
  final Patient patient;
  const PatientDetailsScreen({super.key, required this.patient});

  @override
  State<PatientDetailsScreen> createState() => _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends State<PatientDetailsScreen> {

  final user = FirebaseAuth.instance.currentUser;
  late UserProfileProvider userProfileProvider;
  late DoctorUserProfile? _userProfile;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userProfileProvider = Provider.of<UserProfileProvider>(context, listen: false);
    _loadUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          PopupMenuButton<int>(
            onSelected: (value) {
              switch (value) {
                case 0:
                  Helpers.temporaryNavigator(context, PrescribeMedicine(patient: widget.patient,));
                  break;
                case 1:
                // Perform action for option 1
                  print('Option 1 selected');
                  break;

                case 2:
                // Perform action for option 1
                  Helpers.temporaryNavigator(context, ViewPatientVitalsHistory(patient: widget.patient,));
                  break;

                case 3:
                // Perform action for option 1
                  Helpers.temporaryNavigator(context, PatientMedicalHistory(patient: widget.patient,));
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 0,
                child: Text('Prescribe Medicine'),
              ),

              const PopupMenuItem(
                value: 1,
                child: Text('Book Appointment'),
              ),

              const PopupMenuItem(
                value: 2,
                child: Text('Vitals History'),
              ),

              const PopupMenuItem(
                value: 3,
                child: Text('Medical History'),
              ),

            ],
          ),
        ],

      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  color: Colors.white,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 24),
                    height: 350,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(40)
                        ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                              ),
                              decoration: const BoxDecoration(
                                  color: Pallete.primaryColor,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                  )
                              ),
                              child: Text(
                                widget.patient.personalDetails!.gender ?? '',
                                style: GoogleFonts.akayaKanadaka(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
                              ),
                            ).animate().slideY(
                                begin: -10,
                                duration: const Duration(seconds: 2))
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          "${widget.patient.personalDetails!.firstName} ${widget.patient.personalDetails!.lastName}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          widget.patient.personalDetails!.gender!,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  //TODO : //IMPLEMENT A FUNCTION TO CREATE A CHAT USING THE DOCTORS EMAIL. PLEASE REFER TO THE CODE ON THE CHAT SCREEN AND SEE HOW THE CHAT IS CREATED, USE A SIMILAR METHOD BY PARSING THE DOCTOR'S EMAIL ADDRESS. PLEASE TAKE NOTE THAT THIS WILL ONLY APPLY TO DOCTOR'S EMAIL THAT ARE REGISTER ON FIREBASE ONLY OTHERWISE THE CODE WILL PRODUCE AN ERROR
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                      color: Pallete.primaryColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        FontAwesomeIcons.message,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        'Chat',
                                        style: GoogleFonts.roboto(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ).animate().slideX(
                                    begin: -10,
                                    duration: const Duration(seconds: 2))),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.only(topRight: Radius.circular(40))),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'About',
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey,
                            )
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Contact Details',
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,

                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Email",
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  widget.patient.personalDetails!.email ?? '',
                                  style: TextStyle(
                                      color: Colors.grey.shade600
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 8,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Phone Number",
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  widget.patient.personalDetails!.phoneNumber ?? '',
                                  style: TextStyle(
                                      color: Colors.grey.shade600
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 8,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Address",
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  widget.patient.personalDetails!.address ?? '',
                                  style: TextStyle(
                                      color: Colors.grey.shade600
                                  ),
                                ),
                              ],
                            ),



                            const SizedBox(
                              height: 8,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "City",
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  widget.patient.personalDetails!.email ?? '',
                                  style: TextStyle(
                                      color: Colors.grey.shade600
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey,
                            )
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Next of Kin',
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,

                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Name",
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  widget.patient.nextOfKinDetails != null
                                      ? "${widget.patient.nextOfKinDetails!.firstName.toString()} ${widget.patient.nextOfKinDetails!.lastName.toString()}"
                                      : '',
                                  style: TextStyle(
                                      color: Colors.grey.shade600
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 8,
                            ),


                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Email",
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  widget.patient.nextOfKinDetails != null
                                    ? widget.patient.nextOfKinDetails!.email.toString()
                                    : '',
                                  style: TextStyle(
                                      color: Colors.grey.shade600
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 8,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Phone Number",
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  widget.patient.nextOfKinDetails != null
                                      ? widget.patient.nextOfKinDetails!.phoneNumber.toString()
                                      : '',
                                  style: TextStyle(
                                      color: Colors.grey.shade600
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 8,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Address",
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  widget.patient.nextOfKinDetails != null
                                      ? widget.patient.nextOfKinDetails!.address.toString()
                                      : '',
                                  style: TextStyle(
                                      color: Colors.grey.shade600
                                  ),
                                ),
                              ],
                            ),



                            const SizedBox(
                              height: 8,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "City",
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  widget.patient.nextOfKinDetails != null
                                      ? widget.patient.nextOfKinDetails!.nationality.toString()  : '',
                                  style: TextStyle(
                                      color: Colors.grey.shade600
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey,
                          )
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Questions',
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,

                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),

                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // PatientDetailsVitalsCard(
                      //     vitals: vitals
                      // )

                      Container()
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              right: 16,
              top: 60,
              child: CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(
                  widget.patient.personalDetails!.displayPicture ?? MyNetworkImageAssets.defaultProfilePic,
                )
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          _showDateTimePicker();
        },
        child: Container(
          color: Colors.white,
          child: Container(
            height: 50,
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Pallete.primaryColor,
              borderRadius: BorderRadius.circular(10)
            ),
            child: const Text(
              'Book Appointment',
              style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _loadUserProfile() async {
    await userProfileProvider.fetchDoctorUserProfile(emailAddress: user!.email!,);

    setState(() {
      _userProfile = userProfileProvider.doctorUserProfile;
    });
  }

  void _submitForm() async {
    if (_userProfile == null) {
      Logger().e('UserProfile is null. Cannot submit form.');
      return;
    }

    showDialog(
        context: context,
        builder: (context){
          return const CustomLoader(message: 'Booking appointment');
        }
    );

    Map<String, dynamic> bookingDetails = {

      "phone_number": widget.patient.personalDetails!.phoneNumber,
      "email": widget.patient.personalDetails!.email,
      "patient_id": widget.patient.personalDetails!.patientId,
      "first_name": widget.patient.personalDetails!.firstName,
      "last_name": widget.patient.personalDetails!.lastName,
      "date_of_birth": widget.patient.personalDetails!.dateOfBirth,
      "national_id": widget.patient.personalDetails!.nationalId,
      "applied_service": "",
      "department": "Neurology",
      "outcome": [],
      "category": "Personal",
      "procedure": "Headache Evaluation and Treatment",
      "preferred_appointment_date": DateFormat('yyyy-MM-dd').format(_selectedDate),
      "preferred_appointment_time": _selectedTime.format(context),
      "appointmentid": generateAppointmentId(),
      "preferredDoctor": _userProfile!.personalDetails.doctorId,
      "doctorEmail": _userProfile!.personalDetails!.email,
      "doctorName": "${_userProfile!.personalDetails!.firstName} ${_userProfile!.personalDetails!.lastName}",
      "doctorid": _userProfile!.personalDetails!.doctorId,
      "service_provider": "Solusi Medical Centre",
      "status": "Pending",
      "casenumber": generateCaseNumber(),
      "id": generateCaseNumber(),
      "referenceNumber": generateRefNumber(),
      "langauge": "No",
      "diability": "No",
      "other_services": "",
      "communication": "No",
      "sensory_processing": "No",
      "cognitive_disability": "No",
      "street_address": _userProfile!.personalDetails.address,
      "siteid": "214377834989",
      "gender": _userProfile!.personalDetails.gender,
      'medical_centre': 'Solusi Medical Centre',
      'backup_date': DateFormat('yyyy-MM-dd').format(_selectedDate),
      'backup_time': _selectedTime.format(context),
      'cancellation_reason': '',
      'details': '',
      'street_address_line2': '',
      'location': '',
      'prevAppointmentSchedule': {},
    };

    // Log the booking details before sending
    final Logger logger = Logger();
    logger.i('Booking Details: $bookingDetails');

    await NewAptServices.bookAppointment(appointmentData: bookingDetails,).then((statusCode) {
      if(statusCode == 200 || statusCode == 201){
        Helpers.back(context);
        Helpers.back(context);

        ScaffoldMessenger.of(context).showSnackBar(MySnackBars.appointmentBookingSnackBar);

      }else{
        Helpers.back(context);
        Helpers.back(context);

        ScaffoldMessenger.of(context).showSnackBar(MySnackBars.failureSnackBar);
      }
    }).catchError((error) {
      logger.e('Exception occurred while creating appointment: $error');
      Helpers.back(context);
      Helpers.back(context);

      ScaffoldMessenger.of(context).showSnackBar(MySnackBars.failureSnackBar);
    });
  }

  String generateAppointmentId() {
    final random = Random();
    final numbers = List.generate(7, (index) => random.nextInt(10)).join();
    return 'APP$numbers';
  }

  String generateCaseNumber() {
    final random = Random();
    final randomNumbers = List.generate(7, (_) => random.nextInt(10));
    return 'CSE${randomNumbers.join()}';
  }

  String generateRefNumber() {
    final random = Random();
    final randomNumbers = List.generate(7, (_) => random.nextInt(10));
    return 'REF${randomNumbers.join()}';
  }

  String createdAtDate() {
    final now = DateTime.now();
    final formattedDate = "${now.year}-${_addLeadingZero(now.month)}-${_addLeadingZero(now.day)}";
    final formattedTime = "${_addLeadingZero(now.hour)}:${_addLeadingZero(now.minute)}:${_addLeadingZero(now.second)}";
    return "$formattedDate $formattedTime";
  }

  String _addLeadingZero(int number) {
    return number.toString().padLeft(2, '0');
  }

  String updatedAtDate() {
    final now = DateTime.now();
    final formattedDate = "${now.year}-${_addLeadingZero(now.month)}-${_addLeadingZero(now.day)}";
    final formattedTime = "${_addLeadingZero(now.hour)}:${_addLeadingZero(now.minute)}:${_addLeadingZero(now.second)}";
    return "$formattedDate $formattedTime";
  }


  TimeOfDay _selectedTime = TimeOfDay.now();
  DateTime _selectedDate = DateTime.now();


  Future<void> _showDateTimePicker() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (pickedDate != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDate = pickedDate;
          _selectedTime = pickedTime;
        });
        _submitForm();
      }
    }
  }

}



