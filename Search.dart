import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_the_way/view/widget/MyLoading.dart';
import 'package:on_the_way/view/widget/PopularNow.dart';
import '../../constans/Color.dart';
import '../../controller/SearchController.dart';

class Search extends StatelessWidget {
  Search({super.key});

  final SearchControllerr controller = Get.put(SearchControllerr());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(30),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SearchBar(
                  controller: controller.search,
                  hintText: 'Enter key word',
                  leading: const Icon(Icons.search),
                  onChanged: (value) {
                    controller.searchProducts(value);
                  },
                ),
              ),
            ),
            flexibleSpace: const FlexibleSpaceBar(),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            expandedHeight: 80,
            backgroundColor: MyColors.primary,
            floating: true,
          ),

          /// محتوى الصفحة
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 1,
                  (context, index) {
                return GetBuilder<SearchControllerr>(
                  builder: (controller) {
                    if (controller.loading) {
                      return MyLoading();
                    }

                    /// ✅ حالة البحث: فيه نص مكتوب
                    if (controller.search.text.isNotEmpty) {
                      if (controller.data.isEmpty) {
                        // لو مافي نتائج
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(40.0),
                            child: Text(
                              "لا يوجد نتائج",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        );
                      }

                      // فيه نتائج
                      return GridView.builder(
                        padding: EdgeInsets.all(0),
                        itemCount: controller.data.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 1,
                          mainAxisSpacing: 1,
                          childAspectRatio: 3 / 4,
                        ),
                        itemBuilder: (context, index) => PopularNow(
                          url: controller.data[index]['url'],
                          productName: controller.data[index]['name'],
                          price: controller.data[index]['price'],
                        ),
                      );
                    }

                    /// ✅ حالة بدون كتابة → عرض Popular now
                    return Column(
                      children: [
                        const SizedBox(height: 20),
                        const Row(
                          children: [
                            Text(
                              '      Popular now :',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.local_fire_department,
                              color: Colors.red,
                              size: 30,
                            )
                          ],
                        ),

                        GridView.builder(
                          padding: EdgeInsets.all(0),
                          itemCount: controller.popular.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 1,
                            childAspectRatio: 3 / 4,
                          ),
                          itemBuilder: (context, index) => PopularNow(
                            url: controller.popular[index]['url'],
                            productName: controller.popular[index]['name'],
                            price: controller.popular[index]['price'],
                          ),
                        )
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
