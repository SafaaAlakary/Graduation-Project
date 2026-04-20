import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  late var theOrder;
  late double lat ;
  late double lon;
  bool? pay;
  bool doneLocation =false;
  bool call = true;
  bool donePay = false;
  TextEditingController note = TextEditingController();
  TextEditingController phone = TextEditingController();
  /////////////////////////////////////////////location

  Future<List<double>?> getCurrentLocationAndUpload() async {
    bool serviceEnabled;
    LocationPermission permission;

    // تحقق من تفعيل GPS
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('خدمة الموقع غير مفعلة');
      return null;
    }

    // صلاحيات الوصول
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('تم رفض صلاحيات الموقع');
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('صلاحيات الموقع مرفوضة دائمًا');
      return null;
    }

    // الحصول على الموقع الحالي
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    double lat = position.latitude;
    double lon = position.longitude;

    print('Latitude: $lat, Longitude: $lon');
    return [lat, lon];
  }

  @override
  void onClose() {
    Get.delete<OrderController>();
    super.onClose();
  }
  void deleteItem({required id})async{
    await FirebaseFirestore.instance.collection("Carts").doc(id).delete();
    onInit();
  }
  //////////////////////////////////////////////////////add
  CollectionReference Orders = FirebaseFirestore.instance.collection('Orders');
  Future<void> addOrder() {
    // Call the user's CollectionReference to add a new Post
    return Orders
        .add({
        'customerId':FirebaseAuth.instance.currentUser!.uid,
        'productName': theOrder['productName'],
        'price':theOrder['price'],
        'numberOfProduct':theOrder['numberOfProduct'],
        'storeName':theOrder['storeName'],
        'lat':lat,
        'lon':lon,
        'state':0,
        'additions':note.text,
        'totalPrice':theOrder['total'],
        'url':theOrder['url'],
        'phoneNumber':phone.text,
        'book':false,
        'deliveryManId':'',
        'delivery':theOrder['delivery'],
        'deleted':false,
        'date':FieldValue.serverTimestamp()

    })
        .then((value) => print(" post Add =================="))
        .catchError((error) => print("Failed to add user: $error"));
  }
  void incrementOne() async {
    try {
      final productRef = FirebaseFirestore.instance
          .collection('Stores')
          .doc(theOrder['storeId'])
          .collection('Products')
          .doc(theOrder['productId']);

      await productRef.update({
        'ordersCount': FieldValue.increment(1),
      });

      print('✅ تم زيادة ordersCount للمنتجeId');
    } catch (e) {
      print('❌ حدث خطأ أثناء التحديث: $e');
    }
  }

}
