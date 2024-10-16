import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:medique/models/patient.dart';
import 'package:medique/models/patient_personal_details.dart';
import 'package:medique/views/my_patients/add_patient.dart';
import 'package:medique/views/my_patients/add_vitals.dart';
import 'package:medique/views/my_patients/next_of_kin_form.dart';
import 'package:medique/views/my_patients/patient_details.dart';
import 'package:medique/views/my_patients/patients_screen.dart';
import 'package:medique/views/my_patients/prescribe_medicine.dart';
import 'package:medique/views/my_patients/prescriptions_history.dart';
import 'package:medique/views/my_patients/vitalHistory.dart';
import 'package:medique/views/tabs/home_tab/ai_hub/xray_scanner.dart';
import 'package:medique/views/workers/pages/add_user.dart';
import '../../views/ai_screens/chat_bot_screen.dart';
import '../../views/ai_screens/symptom_checker_screen.dart';
import '../../views/auth/email_verification.dart';
import '../../views/auth/email_verification_success.dart';
import '../../views/auth/forgot_password.dart';
import '../../views/auth/login_page.dart';
import '../../views/auth/resend_reset_email_screen.dart';
import '../../views/splash/splash.dart';

class RoutesHelper {
  static String welcomeScreen = '/welcome';
  static String initialScreen = "/";
  static String splashScreen = "/splash";
  static String emailVerificationScreen = "/verifyEmail";
  static String successfulVerificationScreen = "/verified";
  static String loginScreen = '/login';
  static String signUpScreen = '/signUp';
  static String forgotPasswordScreen = '/forgotPassword';
  static String resendVerificationEmailScreen = '/resendVerificationEmail';
  static String adminHomeScreen = '/adminHome';
  static String userHomeScreen = '/userHome';
  static String addVitalsScreen = '/addVitals';
  static String viewPatientVitalsHistory = '/viewPatientVitals';
  static String nurseAddPatientScreen = '/addPatient';
  static String viewPatientScreen = '/viewPatient';
  static String symptomCheckerScreen = '/askMediguideAI';
  static String updateShiftScreen = '/updateShift';
  static String nextOfKinDetailsScreen = '/addNextOfKin';
  static String viewAllPatientsScreen = '/viewPatients';
  static String tbScanner = '/tbScanner';
  static String adminAddUserScreen = '/adminAddStaff';
  static String chatBotScreen = '/chatBotScreen';
  static String prescribeMedicineScreen = '/prescribeMedication';
  static String viewPatientMedicalHistory = '/viewPatientHistory';

  static List<GetPage> routes = [
    GetPage(
        name: emailVerificationScreen,
        page: () {
          final user = Get.arguments as User;

          return EmailVerificationScreen(user: user);
        }),
    GetPage(
        name: resendVerificationEmailScreen,
        page: () {
          final String email = Get.arguments as String;

          return ResendResetEmailScreen(email: email);
        }),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(
        name: successfulVerificationScreen,
        page: () => const AccountVerificationSuccessful()),
    GetPage(name: forgotPasswordScreen, page: () => ForgotPasswordScreen()),
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: adminAddUserScreen, page: () => const AdminAddUser()),
    GetPage(
        name: nurseAddPatientScreen,
        page: () {
          final user = Get.arguments as User;
          return AddPatient(user: user);
        }
    ),
    GetPage(
        name: nextOfKinDetailsScreen,
        page: () {
          final args = Get.arguments as List;
          final user = args[0] as User;
          final PatientPersonalDetails patientPersonalDetails = args[1] as PatientPersonalDetails;

          return AddNextOfKin(user: user, patientPersonalDetails: patientPersonalDetails);
        }
    ),
    GetPage(name: viewAllPatientsScreen, page: () => const PatientsScreen()),

    GetPage(
        name: viewPatientScreen,
        page: () {
          final patient = Get.arguments as Patient;
          return PatientDetailsScreen(patient: patient,);
        }
    ),

    GetPage(
        name: addVitalsScreen,
        page: () {
          final args = Get.arguments as List;
          final user = args[0] as User;
          final Patient patient = args[1] as Patient;

          return AddVitalsScreen(user: user, patient: patient);
        }
    ),

    GetPage(
        name: viewPatientVitalsHistory,
        page: () {
          final patient = Get.arguments as Patient;
          return ViewPatientVitalsHistory(patient: patient,);
        }
    ),
    GetPage(name: tbScanner, page: () => const XrayScanner()),

    GetPage(name: symptomCheckerScreen, page: () => SymptomCheckerScreen()),
    GetPage(
        name: chatBotScreen,
        page: () {
          final disease = Get.arguments as String;
          return ChatBotScreen(disease: disease);
        }),

    GetPage(
        name: prescribeMedicineScreen,
        page: () {
          final patient = Get.arguments as Patient;
          return PrescribeMedicineScreen(patient: patient,);
        }),

    GetPage(
        name: viewPatientMedicalHistory,
        page: () {
          final patient = Get.arguments as Patient;
          return PatientMedicalHistory(patient: patient,);
        }),
  ];
}

