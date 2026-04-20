import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:on_the_way/view/page/Cart.dart';
import 'package:on_the_way/view/page/Hhome.dart';
import 'package:on_the_way/view/page/Profile.dart';
import 'package:on_the_way/view/page/Search.dart';

import '../../constans/Color.dart';
import '../../controller/CartController.dart';
import '../../controller/SearchController.dart';

class HomePage extends StatefulWidget {
  int initialIndex ;
   HomePage({super.key,this.initialIndex = 0});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int selectedIndex ; // bottomNavigatorBar index
  Widget getPage(int index) {
    switch (index) {
      case 0:
        return Hhome();
      case 1:
        return Search();
      case 2:
        return Cart();
      case 3:
        return Profile();
      default:
        return Hhome();
    }
  }

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getPage(selectedIndex),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: GNav(
          textStyle: const TextStyle(fontSize: 1),
          tabBorderRadius: 100,
          gap: 10,
          iconSize: 25,
          tabActiveBorder: Border.all(color: MyColors.primary, width: 2),
          curve: Curves.easeInOutCubicEmphasized,
          activeColor: MyColors.primary,
          duration: const Duration(milliseconds: 800),
          backgroundColor: MyColors.primary,
          tabBackgroundColor: Colors.white,
          color: Colors.black,
          selectedIndex: selectedIndex,
          tabs: const [
            GButton(
              icon: Icons.home_outlined,
              iconColor: Colors.white,
              padding: EdgeInsets.all(20),
            ),
            GButton(
              icon: Icons.search,
              iconColor: Colors.white,
              padding: EdgeInsets.all(20),
            ),
            GButton(
              icon: Icons.shopping_cart_outlined,
              iconColor: Colors.white,
              padding: EdgeInsets.all(20),
            ),
            GButton(
              icon: Icons.person_2_outlined,
              iconColor: Colors.white,
              padding: EdgeInsets.all(20),
            ),
          ],
          onTabChange: (index) {
            setState(() {

              Get.delete<CartController>();
              Get.delete<SearchControllerr>();
              selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
