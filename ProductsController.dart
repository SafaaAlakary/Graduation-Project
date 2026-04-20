import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  int number = 1;
  bool loading = true;
  List products = [];
  final String storeId;

  ProductsController(this.storeId);

  getdata() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("Stores")
          .doc('$storeId')
          .collection('Products')
          .get();
      products.addAll(querySnapshot.docs);
    } catch (e) {
      print("$e========================================");
    }
  }

  //////////////////////////////////////////add
  CollectionReference Carts = FirebaseFirestore.instance.collection('Carts');

  Future<void> addPost(
      {required String productName,
      required int price,
      required String storeName,
      required int delivery,
      required String url,
      required String productId}) {
    // Call the user's CollectionReference to add a new Post
    return Carts.add({
      'customerId': FirebaseAuth.instance.currentUser!.uid,
      'productName': productName,
      'price': number * price,
      'numberOfProduct': number,
      'delivery': delivery,
      'total': price + delivery,
      'storeName': storeName,
      'url':url,
      'productId':productId,
      'storeId':storeId
    })
        .then((value) => print(" post Add =================="))
        .catchError((error) => print("Failed to add user: $error"));
  }

  /////////////////////////////////////////
  @override
  void onInit() async {
    products = [];
    await getdata();
    loading = false;
    Future.delayed(Duration(seconds: 1), () {
      update();
    });

    super.onInit();
  }

  @override
  void onClose() {
    Get.delete<ProductsController>();
    super.onClose();
  }
}
