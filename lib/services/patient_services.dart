import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/utils/api_response.dart';
import '../models/patient.dart';

class PatientServices {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to add a user to Firebase Firestore
  static Future<APIResponse<String?>> addPatientToFirebase({
    required Patient patient
  }) async {
    try {
      // Query Firestore to check if a user with the same email already exists
      final querySnapshot = await _firestore
          .collection('patients')
          .where('email', isEqualTo: patient.personalDetails!.email)
          .where('first-name', isEqualTo: patient.personalDetails!.firstName)
          .where('last-name', isEqualTo: patient.personalDetails!.lastName)
          .where('date-of-birth', isEqualTo: patient.personalDetails!.dateOfBirth)
          .get();


      if (querySnapshot.docs.isNotEmpty) {
        return APIResponse(
            success: false, message: 'Patient with the same email already exists');
      }

      final userData = patient.toJson();
      await _firestore.collection('patients').add(userData);

      return APIResponse(
          success: true, data: '', message: 'Patient added successfully');
    } catch (e) {
      return APIResponse(success: false, message: e.toString());
    }
  }

  static Stream<List<Patient>> streamAllUsers() {
    return _firestore.collection('patients').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Patient.fromJson(doc.data()))
          .toList();
    });
  }


// Method to search staff by name
//   static Future<APIResponse<List<UserProfile>>> searchStaffByName({ required String name,}) async {
//     try {
//       // Query Firestore to find users whose names contain the search string
//       final querySnapshot = await _firestore
//           .collection('users')
//           .where('name', isGreaterThanOrEqualTo: name)
//           .where('name', isLessThanOrEqualTo: '$name\uf8ff')
//           .get();
//
//       // Check if any documents are found
//       if (querySnapshot.docs.isNotEmpty) {
//         // Map the query results to UserProfile objects
//         final userList = querySnapshot.docs
//             .map((doc) => UserProfile.fromJson(doc.data()))
//             .toList();
//
//         return APIResponse(
//           success: true,
//           data: userList,
//           message: 'Users found successfully',
//         );
//       } else {
//         return APIResponse(
//           success: false,
//           message: 'No users found with the given name',
//         );
//       }
//     } catch (e) {
//       return APIResponse(success: false, message: e.toString());
//     }
//   }
//
//   static Future<APIResponse<UserProfile>> fetchUserProfile({required String profileEmail}) async {
//     final usersRef = FirebaseFirestore.instance.collection('users');
//
//     // Query the collection to find a user document with the specified email
//     final querySnapshot =
//     await usersRef.where('email', isEqualTo: profileEmail).get();
//
//     // Check if any documents are found
//     if (querySnapshot.docs.isNotEmpty) {
//       // Get the first document found (assuming email is unique)
//       final userDoc = querySnapshot.docs.first.data();
//
//       final userProfile = UserProfile.fromJson(userDoc);
//
//       return APIResponse(
//           success: true,
//           data: userProfile,
//           message: 'User fetched successfully');
//     } else {
//       return APIResponse(
//           success: false,
//           message:
//           'User fetching failed: no user found with the specified email');
//     }
//   }
//
// // Method to fetch all users from Firebase Firestore
//   // Method to count users based on posts
//   static Future<APIResponse<Map<String, int>>> countUsersByRole() async {
//     try {
//       final usersRef = _firestore.collection('users');
//
//       // Queries for each role
//       final careSupportWorkersCount =
//           (await usersRef.where('post', isEqualTo: 'Care/Support Worker').get())
//               .docs
//               .length;
//       final socialWorkersCount =
//           (await usersRef.where('post', isEqualTo: 'Social Worker').get())
//               .docs
//               .length;
//       final nursesCount =
//           (await usersRef.where('post', isEqualTo: 'Nurse').get()).docs.length;
//
//       return APIResponse(
//           success: true,
//           data: {
//             'Care and Support Workers': careSupportWorkersCount,
//             'Social Workers': socialWorkersCount,
//             'Nurses': nursesCount,
//           },
//           message: 'User counts retrieved successfully');
//     } catch (e) {
//       return APIResponse(success: false, message: e.toString());
//     }
//   }
//
//
//   // Method to update an existing user's profile
//   static Future<APIResponse<String>> updateUserProfile({required String email, required UserProfile updatedProfile, }) async {
//     try {
//       // Ensure the user exists by checking for their profile based on email
//       final querySnapshot = await _firestore
//           .collection('users')
//           .where('email', isEqualTo: email)
//           .get();
//
//       if (querySnapshot.docs.isEmpty) {
//         return APIResponse(
//             success: false, message: 'No user found with the specified email');
//       }
//
//       final docId = querySnapshot.docs.first.id;
//
//       final updatedData = updatedProfile.toJson();
//
//       await _firestore.collection('users').doc(docId).update(updatedData);
//
//       // Return a success response
//       return APIResponse(
//           success: true, data: '', message: 'User profile updated successfully');
//     } catch (e) {
//       // Log the error and return a failure response with the exception message
//       DevLogs.logError('UserProfile Update Error: $e');
//       return APIResponse(success: false, message: 'Profile update failed: $e');
//     }
//   }
}
