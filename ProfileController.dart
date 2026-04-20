import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:on_the_way/view/page/LoginPage.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileController extends GetxController{
  logOut()async{
    await FirebaseAuth.instance.signOut();
    GoogleSignIn googleSignIn = GoogleSignIn();
    googleSignIn.disconnect();
    Get.offAll(LoginPage());
  }


  Future<void> openWhatsApp(String phoneNumber, String message) async {
    final Uri whatsappUri = Uri.parse(
      'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}',
    );

    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(
        whatsappUri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      print('Could not launch WhatsApp');
    }
  }

  @override
  void onClose() {
    Get.delete<ProfileController>();
    super.onClose();
  }
/////////////////////////////////////////////////////////
  var username = "".obs;
  Future<void> fetchUsername() async {
    try {
      final query = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (query.docs.isNotEmpty) {
        username.value = query.docs.first['username'];
      } else {
        username.value = "No user";
      }
    } catch (e) {
      username.value = "Error";
      print("Error fetching username: $e");
    }
  }
  @override
  void onInit() {
    // TODO: implement onInit
    fetchUsername();
    super.onInit();
  }
}