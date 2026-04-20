import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:on_the_way/view/page/Cart.dart';
import 'package:on_the_way/view/page/FirstSplashScreen.dart';
import 'package:on_the_way/view/page/Hhome.dart';
import 'package:on_the_way/view/page/HomePage.dart';
import 'package:on_the_way/view/page/LoginPage.dart';
import 'package:on_the_way/view/page/Profile.dart';
import 'package:on_the_way/view/page/Search.dart';
import 'package:on_the_way/view/page/SignUpPage.dart';
import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp ());
}
class MyApp  extends StatelessWidget{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:(FirebaseAuth.instance.currentUser == null)?const FirstSplashScreen():HomePage(),
       getPages: [
        GetPage(name: "/login", page: () => const LoginPage()),
        GetPage(name: "/signup", page: () => SignUpPage()),
        GetPage(name: "/home", page:()=> HomePage()),
        GetPage(name:'/hhome', page: ()=>Hhome(), ),
         GetPage(name:'/search', page: ()=>Search(), ),
         GetPage(name:'/cart', page: ()=>Cart(), ),
         GetPage(name:'/profile', page: ()=>Profile(), ),
      ],
    );
  }
}

