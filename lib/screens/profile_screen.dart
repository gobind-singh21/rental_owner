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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left_rounded,
            size: 35,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      // backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              ProfileHeader(),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const EditProfileScreen(),
                    ),
                  );
                },
                child: ProfileItem(
                  const Icon(
                    Icons.person_outline,
                  ),
                  'Account',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SettingsScreen()),
                  );
                },
                child: ProfileItem(
                  const Icon(
                    Icons.settings_outlined,
                    // color: Colors.black,
                  ),
                  'Settings',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  signOut(context);
                },
                child: ProfileItem(
                    const Icon(
                      Icons.logout_outlined,
                      // color: Colors.black,
                    ),
                    'Log out'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
