import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../global/global.dart';
import '../../models/user_profile.dart';
import '../../state/authentication_provider.dart';
import '../../state/search_staff_notifier.dart';
import '../../state/staff_count_notifier.dart';
import '../../state/staff_notifier.dart';
import '../../state/user_provider.dart';


class ProviderUtils {
  static final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
    return UserNotifier();
  });

  static final userRoleProvider = StateProvider<UserRole?>((ref) {
    return null;
  });


  static final profileProvider = StateNotifierProvider.family<ProfileNotifier, AsyncValue<UserProfile>, String>((ref, profileEmail) {
    return ProfileNotifier(profileEmail: profileEmail);
  });

  static final staffCountProvider = StateNotifierProvider<StaffCountNotifier, AsyncValue<Map<String, int>>>(
          (ref) {
        return StaffCountNotifier();
      });

  static final searchProvider = StateNotifierProvider<SearchStaffNotifier, List<UserProfile>>((ref) {
    return SearchStaffNotifier();
  });

  static final staffProfilePicProvider = StateProvider<String?>((ref) => null);

  static final staffProvider = StateNotifierProvider<StaffNotifier, AsyncValue<List<UserProfile>>>(
          (ref) {
        return StaffNotifier();
      });
}
