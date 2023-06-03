import 'package:flutter/material.dart';
import 'package:rental_owner/global/dimensions.dart';

class ProfileItem extends StatelessWidget {
  final Icon _icon;
  final String _title;
  ProfileItem(this._icon, this._title);

  final double height = Dimensions.screenHeight;
  final double width = Dimensions.screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      height: height / 15,
      padding: EdgeInsets.only(left: width / 80),
      child: Row(
        children: [
          _icon,
          SizedBox(
            width: width / 40,
          ),
          Text(
            _title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
