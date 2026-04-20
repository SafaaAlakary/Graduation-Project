import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CartController extends GetxController{
  bool loading =true;
  List carts =[];
  getdata() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("Carts")
          .get();
      carts.addAll(querySnapshot.docs);
    } catch (e) {
      print("$e========================================");
    }
  }
  void deleteItem({required id})async{
    await FirebaseFirestore.instance.collection("Carts").doc(id).delete();
    Get.back();
    onInit();
  }

  @override
  void onInit() async {
    loading=true;
    update();
    carts=[];
    await getdata();
    loading=false;
    Future.delayed(Duration(seconds: 1), () {
      update();
    });

    super.onInit();
  }

  @override
  void onClose() {
    Get.delete<CartController>();
    super.onClose();
  }

}