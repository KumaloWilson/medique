import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:medique/views/bottom_navbar/bottomnavigationbar.dart';
import '../../core/utils/providers.dart';
import '../../global/global.dart';
import '../../repository/helpers/auth_helpers.dart';
import 'login_page.dart';

class AuthHandler extends ConsumerWidget {
  const AuthHandler({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasData) {
          final user = snapshot.data!;

          return FutureBuilder<UserRole?>(
            future: AuthHelpers.getUserRole(user),
            builder: (context, roleSnapshot) {
              if (roleSnapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  body: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              final userRole = roleSnapshot.data;

              // Handle email verification
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                ref.read(ProviderUtils.userProvider.notifier).updateUser(user);

                if (user.providerData.any((info) => info.providerId == 'phone')) {
                  // Phone authenticated user, handle accordingly
                  Get.snackbar(
                    'Welcome',
                    'Logged in with phone number successfully.',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                } else if (!user.emailVerified) {
                  // Handle email verification
                  AuthHelpers.handleEmailVerification(user: user);
                }
              });

              return const NurseMainScreen();

            },
          );
        } else {
          return const LoginScreen();
        }
      },
    );

  }
}
