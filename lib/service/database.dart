import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserDetail(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userInfoMap);
  }

  Future addUserReceipt(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Receipt")
        .add(userInfoMap);
  }

  Future addUserMonth(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Spending")
        .add(userInfoMap);
  }


  Future updateSpend(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .update(userInfoMap);
  }



  Future addBarcodeDetail(
      Map<String, dynamic> userInfoMap, String addId) async {
    return await FirebaseFirestore.instance
        .collection("barcode")
        .doc(addId)
        .collection(addId)
        .add(userInfoMap);
  }

  Future<QuerySnapshot> getUserInfo(String id) async {
    return await FirebaseFirestore.instance
        .collection("barcode")
        .where("Id", isEqualTo: id)
        .get();
  }

  Future<QuerySnapshot> getUserSpend(String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("Id", isEqualTo: id)
        .get();
  }

  Future<Stream<QuerySnapshot>> gettheItems(String id) async {
    return FirebaseFirestore.instance
        .collection("barcode")
        .doc(id)
        .collection(id)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> gettheReceipt(String id) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Receipt")
        .snapshots();
  }

  Future addReceiptname(Map<String, dynamic> userInfoMap, String addId) async {
    return await FirebaseFirestore.instance
        .collection("barcode")
        .doc(addId)
        .set(userInfoMap);
  }

  Future<QuerySnapshot> Search(String date, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Receipt")
        .where("Key", isEqualTo: date.substring(0, 1).toUpperCase())
        .get();
  }
}
