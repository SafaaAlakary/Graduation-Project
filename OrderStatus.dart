import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:on_the_way/constans/Color.dart';
import 'package:on_the_way/view/page/HomePage.dart'; // 👈 مهم
import 'package:on_the_way/view/page/Notification.dart';
import 'package:on_the_way/view/widget/MyLoading.dart';
import 'package:timeline_tile/timeline_tile.dart';

class OrderStatus extends StatefulWidget {
  const OrderStatus({super.key});

  @override
  _OrderStatusState createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
  final List<String> orderStages = [
    "Accept the order ",
    "Preparation",
    "Out for Delivery",
    "Delivered",
  ];

  // 🔁 Stream لجلب البيانات باستمرار عند أي تحديث
  Stream<QuerySnapshot> getOrderStream() {
    return FirebaseFirestore.instance
        .collection("Orders")
        .where('customerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy('date', descending: true) // 👈 رتب حسب الوقت
        .limit(1) // 👈 فقط آخر طلب
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(() => HomePage()); // ← لما يضغط زر الرجوع يرجع للـ Home
        return false; // منع الرجوع للصفحة السابقة
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.primary,
          title: Row(
            children: const [
              Text('On the way '),
              Icon(Icons.emoji_emotions_rounded),
            ],
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.offAll(() => HomePage()); // ← حتى السهم يرجع Home
            },
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: getOrderStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: MyLoading());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No orders now"));
            }

            var orders = snapshot.data!.docs;
            var order = orders.first;
            int currentStageIndex = order['state'];

            return order['state'] >= 0
                ? Column(
                    children: [
                      const SizedBox(height: 20),
                      ...List.generate(orderStages.length, (index) {
                        Color indicatorColor;
                        IconData icon;

                        if (index < currentStageIndex) {
                          indicatorColor = Colors.green;
                          icon = Icons.check;
                        } else if (index == currentStageIndex) {
                          indicatorColor = Colors.lightGreen;
                          icon = Icons.timelapse;
                        } else {
                          indicatorColor = Colors.grey;
                          icon = Icons.radio_button_unchecked;
                        }

                        return buildTile(
                          isFirst: index == 0,
                          isLast: index == orderStages.length - 1,
                          indicatorColor: indicatorColor,
                          icon: icon,
                          title: orderStages[index],
                          subtitle: index < currentStageIndex
                              ? "Done"
                              : (index == currentStageIndex
                                  ? "implementation"
                                  : "Waiting "),
                        );
                      }),
                      Expanded(child: Lottie.asset('asset/waiting.json')),
                    ],
                  )
                : Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(flex: 2,
                        child: Lottie.asset('asset/Rejected.json',height: 100),
                      ),
                      const Text(
                        'The order rejected',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),

                    ],
                  );
          },
        ),
      ),
    );
  }

  Widget buildTile({
    bool isFirst = false,
    bool isLast = false,
    required Color indicatorColor,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: TimelineTile(
        alignment: TimelineAlign.start,
        isFirst: isFirst,
        isLast: isLast,
        indicatorStyle: IndicatorStyle(
          width: 40,
          color: indicatorColor,
          iconStyle: IconStyle(
            iconData: icon,
            color: Colors.white,
          ),
        ),
        beforeLineStyle: const LineStyle(color: Colors.grey, thickness: 2),
        endChild: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text(subtitle, style: TextStyle(color: Colors.grey[600])),
            ],
          ),
        ),
      ),
    );
  }
}
