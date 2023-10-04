import 'package:flutter/foundation.dart';
import 'package:rental_owner/global/current_owner_data.dart';
// import 'package:rental_owner/data_models/profile_data_model.dart';
// import 'package:rental_owner/global/current_Owner_data.dart';
// import 'package:rental_owner/global/global.dart';

class ProfileProvider extends ChangeNotifier {
  String _profileImageURL = OwnerData.profileImageURL;
  String _name = OwnerData.name;
  String _email = OwnerData.email;

  String get profileImageURL => _profileImageURL;
  String get name => _name;
  String get email => _email;

  ProfileProvider() {
    _profileImageURL = OwnerData.profileImageURL;
    _name = OwnerData.name;
    _email = OwnerData.email;
  }

  void updateData() {
    _profileImageURL = OwnerData.profileImageURL;
    _name = OwnerData.name;
    _email = OwnerData.email;
    notifyListeners();
  }
}
