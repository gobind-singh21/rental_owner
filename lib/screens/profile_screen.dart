import 'package:flutter/material.dart';
import 'package:rental_owner/app_widgets/profile_widgets/profile_header.dart';
import 'package:rental_owner/app_widgets/profile_widgets/profile_items.dart';
import 'package:rental_owner/utils/auth.dart';
import 'package:rental_owner/screens/login_screen.dart';
import 'package:rental_owner/screens/profile_screens/edit_profile_screen.dart';
import 'package:rental_owner/screens/profile_screens/settings_screen.dart';
import 'package:rental_owner/global/current_Owner_data.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final String name = OwnerData.name;
  final String email = OwnerData.email;
  final String number = OwnerData.number;
  final String profileImageURL = OwnerData.profileImageURL;

  Future<void> signOut(BuildContext context) async {
    await Auth().signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        ModalRoute.withName('/always'));
    // Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileHeader(),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditProfileScreen(),
                  ),
                );
              },
              child: ProfileItem(
                const Icon(Icons.person_outline),
                'Account',
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SettingsScreen()),
                );
              },
              child: ProfileItem(
                const Icon(Icons.settings_outlined),
                'Settings',
              ),
            ),
            InkWell(
              onTap: () {
                signOut(context);
              },
              child: ProfileItem(const Icon(Icons.logout_outlined), 'Log out'),
            ),
          ],
        ),
      ),
    );
  }
}
