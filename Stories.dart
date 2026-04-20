import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_the_way/constans/Color.dart';
import 'package:on_the_way/controller/StoriesController.dart';
import 'package:on_the_way/view/page/Products.dart';
import 'package:on_the_way/view/widget/Store.dart';

import '../widget/MyLoading.dart';

class Stories extends StatelessWidget {
  Stories({super.key, required this.category});

   String category;
   @override
  Widget build(BuildContext context) {
    final StoriesController controller = Get.put(StoriesController(category));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primary,
        title: Text('$category'),
      ),
      body: GetBuilder<StoriesController>(
        builder: (controller) => controller.loading
            ? MyLoading()
            : ListView.builder(
          itemCount: controller.stores.length,
          itemBuilder: (BuildContext context, int index) {
            final now = DateTime.now();

            // استخراج وقت الفتح والإغلاق من Firestore
            final DateTime openTime =
            controller.stores[index]['open_time'].toDate();
            final DateTime closeTime =
            controller.stores[index]['close_time'].toDate();

            // إنشاء وقت فتح وإغلاق بنفس تاريخ اليوم
            final todayOpen = DateTime(
                now.year, now.month, now.day, openTime.hour, openTime.minute);
            final todayClose = DateTime(
                now.year, now.month, now.day, closeTime.hour, closeTime.minute);

            // مقارنة الوقت الحالي مع أوقات العمل
            final isOpenNow =
                now.isAfter(todayOpen) && now.isBefore(todayClose);

            return InkWell(
              onTap: () {
                Get.to(Products(
                  storeId: controller.stores[index].id,
                  storeName: controller.stores[index]['name'],
                  delivery: controller.stores[index]['delivery'],
                ));
              },
              child: Store(
                imageUrl: controller.stores[index]['url'],
                name: controller.stores[index]['name'],
                active: isOpenNow,
                city: controller.stores[index]['city'],
                deliveryCost: controller.stores[index]['delivery'],
              ),
            );
          },
        ),
      ),
    );
  }
}
