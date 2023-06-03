import 'package:flutter/material.dart';
import 'package:rental_owner/global/current_owner_data.dart';
import 'package:rental_owner/global/dimensions.dart';

class ProfileHeader extends StatelessWidget {
  ProfileHeader();
  final double height = Dimensions.screenHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: height / 40),
      height: height / 4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              OwnerData.profileImageURL,
              height: height / 8,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                OwnerData.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: height / 45,
                ),
              ),
              Text(
                OwnerData.email,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: height / 55,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
