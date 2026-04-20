import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchControllerr extends GetxController {
  bool loading = true;
  TextEditingController search = TextEditingController();

  List<Map<String, dynamic>> data = [];     // نتائج البحث
  List<Map<String, dynamic>> popular = [];  // المنتجات الأكثر شهرة

  /// البحث عن منتجات بالاسم
  Future<void> searchProducts(String keyword) async {
    if (keyword.isEmpty) {
      data = [];
      update();
      return;
    }

    loading = true;
    update();

    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collectionGroup("Products")
          //.orderBy('name')
          .where('name',isEqualTo: keyword)
          // .startAt([keyword])
          // .endAt([keyword + '\uf8ff'])
          .get();

      data = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print("❌ Error while searching: $e");
    }

    loading = false;
    update();
  }


  /// جلب المنتجات الأكثر شهرة (مثلاً top 6)
  Future<void> getPopular() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collectionGroup("Products")
          //.orderBy('ordersCount', descending: true) // يعتمد على الحقل اللي عندك
          .limit(6)
          .get();

      popular = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print("❌ Error popular: $e");
    }
    update();
  }

  @override
  void onInit() async {
    await getPopular(); // حمّل المنتجات المشهورة عند البداية
    loading = false;
    super.onInit();
  }
}
