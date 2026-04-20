import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:on_the_way/controller/StoriesController.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../constans/Color.dart';
import 'Notification.dart';
import 'OrderStatus.dart';
import '../page/Stories.dart';

class Hhome extends StatefulWidget {
  const Hhome({super.key});

  @override
  State<Hhome> createState() => _HhomeState();
}

class _HhomeState extends State<Hhome> {
  Stream<int> getNotificationCount() {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('Notification')
        .where('uid', isEqualTo: uid)
        .where('isRead',isEqualTo: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  int currentIndex = 0;
  late PageController pageController;

  final List<String> images = ['1.jpg', '2.png', '3.jpg', '4.jpg'];

  final List<String> categories = [
    'images/food.png',
    'images/cart.png',
    'images/clothes.png',
    'images/fruits.png',
    'images/gift.png',
    'images/mobile.png',
    'images/toys.png',
  ];

  final List<String> titles = [
    'Food',
    'Grocery',
    'Clothes',
    'F & V',
    'Gifts',
    'Electronics',
    'Toys',
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.87);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      autoPageSwitch();
    });
  }

  void autoPageSwitch() {
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      if (pageController.hasClients) {
        setState(() {
          currentIndex = (currentIndex + 1) % images.length;
        });
        pageController.animateToPage(
          currentIndex,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
      autoPageSwitch();
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [
              IconButton(
                onPressed: () {
                  Get.to(OrderStatus());
                },
                icon: const Icon(Icons.delivery_dining_outlined, size: 30),
              ),
              StreamBuilder<int>(
                stream: getNotificationCount(),
                builder: (context, snapshot) {
                  int count = snapshot.data ?? 0;

                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      IconButton(
                        onPressed: () {
                          // يفتح صفحة الإشعارات
                          Get.to(const NotificationsPage());
                        },
                        icon: const Icon(Icons.notifications_none_sharp, size: 30),
                      ),
                      if (count > 0)
                        Positioned(
                          right: 6,
                          top: 6,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 20,
                              minHeight: 20,
                            ),
                            child: Text(
                              '$count',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),

              const SizedBox(width: 20),
            ],
            title: const Text(
              "Home Page",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            flexibleSpace: const FlexibleSpaceBar(),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            expandedHeight: 60,
            backgroundColor: MyColors.primary,
            floating: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 1,
              (context, index) {
                return Column(
                  children: [
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 200,
                      child: PageView.builder(
                        controller: pageController,
                        itemCount: images.length,
                        onPageChanged: (index) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return AnimatedBuilder(
                            animation: pageController,
                            builder: (context, child) {
                              double value = 1.0;
                              if (pageController.position.haveDimensions) {
                                value = pageController.page! - index;
                                value =
                                    (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                              }
                              return Center(
                                child: SizedBox(
                                  height: Curves.easeOut.transform(value) * 250,
                                  width: Curves.easeOut.transform(value) * 350,
                                  child: child,
                                ),
                              );
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(
                                  'images/${images[index]}',
                                  fit: BoxFit.fill,
                                  width:
                                      MediaQuery.of(context).size.width * 0.75,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    SmoothPageIndicator(
                      controller: pageController,
                      count: images.length,
                      effect: ScrollingDotsEffect(
                        activeDotColor: MyColors.primary,
                        dotColor: Colors.grey,
                        dotHeight: 10,
                        dotWidth: 10,
                        spacing: 8,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Divider(
                      color: MyColors.primary,
                      thickness: 3,
                      indent: 20,
                      endIndent: 20,
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      children: [
                        Text(
                          '      Categories :',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 0),
                      child: GridView.count(
                        padding: EdgeInsets.only(top: 20),
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 3 / 4,
                        children: List.generate(7, (index) {
                          return InkWell(
                            onTap: () {
                              Get.delete<StoriesController>();
                              Get.to(Stories(category: titles[index]));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        blurRadius: 5,
                                        spreadRadius: 0)
                                  ],
                                  border: Border.all(width: 0),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(0),
                                      child: Image.asset(
                                        categories[index],
                                        fit: BoxFit.contain,
                                        width: 80,
                                        height: 80,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    titles[index],
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(height: 5)
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
