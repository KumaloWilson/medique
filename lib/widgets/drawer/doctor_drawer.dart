import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medique/core/constants/local_image_constants.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../core/constants/color_constants.dart';
import '../../services/auth_service.dart';
import '../circular_loader/circular_loader.dart';

class DoctorDrawer extends StatefulWidget {
  final User user; 
  const DoctorDrawer({super.key, required this.user});

  @override
  State<DoctorDrawer> createState() => _DoctorDrawerState();
}

class _DoctorDrawerState extends State<DoctorDrawer> {

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
                      child: CachedNetworkImage(
                        imageUrl: widget.user.photoURL ??
                            'https://cdn-icons-png.flaticon.com/128/3177/3177440.png',
                        width: MediaQuery.of(context).size.height * 0.18,
                        height: MediaQuery.of(context).size.height * 0.18,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Skeletonizer(
                          enabled: true,
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.45,
                            child: Image.asset(
                                LocalImageConstants.logo
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.user.displayName ?? 'username',
                          style: TextStyle(
                            fontSize: 16,
                            color: Pallete.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.user.email ?? 'example@email.com',
                          style: TextStyle(
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
          ListTile(
            //onTap: ()=> Helpers.temporaryNavigator(context, const TestResults()),
            leading: Icon(
              FontAwesomeIcons.file,
              color: Pallete.primaryColor,
            ),
            title: const Text('My Documents'),
            trailing: const Icon(Icons.navigate_next),
          ),

          ListTile(
            //onTap: ()=> Helpers.temporaryNavigator(context, const ViewPayments()),
            leading: Icon(
              FontAwesomeIcons.moneyBill,
              color: Pallete.primaryColor,
            ),
            title: const Text('My Schedule'),
            trailing: const Icon(Icons.navigate_next),
          ),
          ListTile(
            //onTap: ()=> Helpers.temporaryNavigator(context, const HospitalizationHistory()),
            leading: Icon(
              FontAwesomeIcons.hospital,
              color: Pallete.primaryColor,
            ),
            title: const Text('Patient History'),
            trailing: const Icon(Icons.navigate_next),
          ),

          ListTile(
            leading: Icon(
              FontAwesomeIcons.file,
              color: Pallete.primaryColor,
            ),
            title: const Text('AI Center'),
            trailing: const Icon(Icons.navigate_next),
          ),

          ListTile(
            leading: Icon(
              Icons.settings,
              color: Pallete.primaryColor,
            ),
            title: const Text('Settings'),
            trailing: const Icon(Icons.navigate_next),
          ),
          const Divider(
            color: Colors.grey,
          ),

          ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.redAccent,
              ),
              title: const Text(
                'Sign Out',
                style: TextStyle(color: Colors.redAccent),
              ),
              trailing: const Icon(Icons.navigate_next),
              onTap: () async {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return const CustomLoader(message: 'Signing Out');
                    });

                await AuthServices.signOut();

              }),
        ],
      ),
    );
  }
}
