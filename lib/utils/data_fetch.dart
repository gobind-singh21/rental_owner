import 'package:rental_owner/global/current_Owner_data.dart';
import 'package:rental_owner/global/global.dart';

class GetData {
  static Future<Map<String, dynamic>> fetchProduct(dynamic productID) async {
    final productDocRef = db.collection('products').doc(productID);
    final productDoc = await productDocRef.get();
    final Map<String, dynamic> productData =
        productDoc.data() as Map<String, dynamic>;
    return productData;
  }

  static Future<Map<String, dynamic>> fetchOrderInfo(dynamic orderID) async {
    final orderDocRef = db.collection('orders').doc(orderID);
    final orderDoc = await orderDocRef.get();
    final Map<String, dynamic> orderData =
        orderDoc.data() as Map<String, dynamic>;
    return orderData;
  }

  static Future<Map<String, dynamic>> fetchOwnerInfo() async {
    final ownerDocRef = db.collection('owners').doc(currentFirebaseUser!.uid);
    final ownerDoc = await ownerDocRef.get();
    final Map<String, dynamic> ownerData =
        ownerDoc.data() as Map<String, dynamic>;
    return ownerData;
  }

  static Future<List<dynamic>> fetchAllOrders() async {
    List<dynamic> orders = [];
    for (var prod in OwnerData.productUID) {
      orders.addAll((await fetchProduct(prod))['history']);
    }
    orders.sort();
    return orders;
  }
}
