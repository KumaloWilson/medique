import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/color_constants.dart';
import '../../core/constants/local_image_constants.dart';
import '../../core/utils/routes.dart';
import '../../core/utils/shared_pref.dart';
import '../../services/auth_service.dart';

class UserDrawer extends StatefulWidget {
  final User user;
  const UserDrawer({super.key, required this.user});

  @override
  State<UserDrawer> createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.32,
              child: DrawerHeader(
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.height * 0.18,
                      height: MediaQuery.of(context).size.height * 0.18,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors
                                .grey.shade300, // Light color for top shadow
                            offset: const Offset(-5, -5),
                            blurRadius: 15,
                          ),
                          BoxShadow(
                            color: Colors
                                .grey.shade500, // Dark color for bottom shadow
                            offset: const Offset(5, 5),
                            blurRadius: 15,
                          ),
                        ],
                      ),
                      child: ClipOval(
                          child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.45,
                        child: Image.asset(LocalImageConstants.logo),
                      )),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.user.displayName ?? 'username',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Pallete.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.user.email ?? 'example@email.com',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Pallete.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const ListTile(
              leading: Icon(
                Icons.home,
                color: Pallete.primaryColor,
              ),
              title: Text(
                'Home',
                style: TextStyle(fontSize: 16),
              ),
              trailing: Icon(Icons.navigate_next),
            ),
            ListTile(
              leading: const Icon(
                Icons.person,
                color: Pallete.primaryColor,
              ),
              title: const Text(
                'Manage Profile',
                style: TextStyle(fontSize: 16),
              ),
              trailing: const Icon(Icons.navigate_next),
              onTap: () {
                // Get.toNamed(RoutesHelper.userProfileScreen,
                //     arguments: widget.user.email);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.auto_graph,
                color: Pallete.primaryColor,
              ),
              title: const Text(
                'Shift Statistics',
                style: TextStyle(fontSize: 16),
              ),
              trailing: const Icon(Icons.navigate_next),
              onTap: () {
                // Get.toNamed(RoutesHelper.userShiftStatsScreen,
                //     arguments: widget.user.email);
              },
            ),
            ListTile(
              onTap: () async {
                await CacheUtils.clearUserRoleFromCache().then((_) async {
                  await AuthServices.signOut();
                });
              },
              leading: const Icon(
                Icons.logout,
                color: Colors.redAccent,
              ),
              title: const Text(
                'Sign Out',
                style: TextStyle(color: Colors.redAccent, fontSize: 16),
              ),
            ),
          ],
        ));
  }
}
