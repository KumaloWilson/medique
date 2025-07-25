import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/api_response.dart';
import '../models/user_profile.dart';
import '../services/profile_services.dart';

class ProfileNotifier extends StateNotifier<AsyncValue<UserProfile>> {
  final String profileEmail;

  ProfileNotifier({required this.profileEmail})
      : super(const AsyncValue.loading()) {
    fetchUser(profileEmail: profileEmail);
  }

  Future<void> fetchUser({required String profileEmail}) async {
    // Set loading state
    state = const AsyncValue.loading();

    try {
      // Fetch user profile from the service
      final APIResponse<UserProfile> response = await StaffServices.fetchUserProfile(profileEmail: profileEmail);

      if (response.success) {
        state = AsyncValue.data(response.data!);
      } else {
        state = AsyncValue.error(
            response.message ?? 'Failed to fetch user', StackTrace.current
        );
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error('An unexpected error occurred: $e', stackTrace);
    }
  }

  // Update the state with a new profile
  void updateProfile(UserProfile updatedProfile) {
    state = AsyncValue.data(updatedProfile);
  }

}
