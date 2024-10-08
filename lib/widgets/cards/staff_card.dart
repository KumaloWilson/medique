import 'package:flutter/material.dart';
import '../../models/user_profile.dart';

class StaffCard extends StatelessWidget {
  final UserProfile user;
  const StaffCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //Get.toNamed(RoutesHelper.userProfileScreen, arguments: user.email);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey),
        ),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    user.email!,
                    style:const TextStyle(fontSize: 12),
                  ),
                  Text(
                    user.phoneNumber!,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
              subtitle: Text(
                user.post!,
                style: const TextStyle(fontSize: 12),
              ),
              trailing: PopupMenuButton<int>(
                itemBuilder: (BuildContext context) => [
                  buildPopUpOption(
                    title: 'View Profile',
                    icon: Icons.remove_red_eye_outlined,
                    value: 0,
                    onTap: () {
                      // Get.toNamed(RoutesHelper.userProfileScreen,
                      //     arguments: user.email);
                    },
                  ),
                ],
                icon: const Icon(Icons.more_vert),
              ),
            ),
          ],
        ),
      ),
    );
  }

  dynamic buildPopUpOption({
    required String title,
    required IconData icon,
    required int value,
    required void Function() onTap,
  }) {
    return PopupMenuItem<int>(
      onTap: onTap,
      value: value,
      child: Row(
        children: [
          Icon(icon, color: Colors.black54),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
