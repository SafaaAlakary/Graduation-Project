import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class StoriesController extends GetxController{
  final String catigory;
  bool loading = true;
  List stores = [] ;
  StoriesController(this.catigory);
  getdata() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("Stores")
          .where("type",isEqualTo: catigory)
          .get();
      stores.addAll(querySnapshot.docs);
    } catch (e) {
      print("$e========================================");
    }
  }
  @override
  void onInit() async {
    stores=[];
    await getdata();
    loading=false;
    Future.delayed(Duration(seconds: 1), () {
      update();
    });

    super.onInit();
  }
  @override
  void onClose() {
    Get.delete<StoriesController>();
    super.onClose();
  }

}