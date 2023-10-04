import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:rental_owner/global/current_owner_data.dart';
import 'package:rental_owner/global/dimensions.dart';
import 'package:rental_owner/prvoider_classes/profile_provider.dart';

class ProfileHeader extends StatelessWidget {
  ProfileHeader({super.key});
  final double height = Dimensions.screenHeight;

  @override
  Widget build(BuildContext context) {
    ProfileProvider profileProvider = Provider.of<ProfileProvider>(context);
    // print(profileProvider.profileImageURL);
    // print(OwnerData.profileImageURL);
    // return Consumer<ProfileProvider>(
    //   builder: (context, profileProvider, _) {
    return Container(
      padding: EdgeInsets.only(top: height / 40),
      height: height / 3.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(height),
            child: Image.network(
              profileProvider.profileImageURL,
              height: height / 8,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            profileProvider.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: height / 45,
              color: Theme.of(context).textTheme.bodyLarge!.color,
              // color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            profileProvider.email,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: height / 55,
              color: Theme.of(context).textTheme.bodyMedium!.color,
              // color: Colors.grey,
            ),
          )
        ],
      ),
    );
    //   },
    // );
  }
}
