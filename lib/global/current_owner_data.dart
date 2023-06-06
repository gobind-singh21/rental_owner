import 'package:rental_owner/global/global.dart';

class OwnerData {
  static String name = "";
  static String email = "";
  static String number = "";
  static String profileImageURL = "";
  static List<dynamic> productUID = [];
  static bool ownerDataSet = false;

  static setOwnerData() async {
    final docRef = db.collection('owners').doc(currentFirebaseUser!.uid);
    final doc = await docRef.get();
    final data = doc.data() as Map<String, dynamic>;
    name = data['name'];
    email = data['email'];
    number = data['number'];
    profileImageURL = data['profileImageURL'];
    productUID = data['productUIDs'];
    ownerDataSet = true;
  }
}
