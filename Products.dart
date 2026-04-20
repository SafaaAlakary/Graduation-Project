import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:on_the_way/constans/Color.dart';
import 'package:on_the_way/controller/ProductsController.dart';
import 'package:on_the_way/view/page/HomePage.dart';
import 'package:on_the_way/view/widget/MyLoading.dart';
import 'package:on_the_way/view/widget/Product.dart';

class Products extends StatelessWidget {
  Products(
      {super.key,
      required this.storeId,
      required this.storeName,
      required this.delivery});

  String storeId;
  int delivery;
  String storeName;

  @override
  Widget build(BuildContext context) {
    ProductsController controller = Get.put(ProductsController(storeId));
    return Scaffold(
      appBar: AppBar(
          backgroundColor: MyColors.primary,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.store,
                size: 30,
              ),
              Text('$storeName'),
            ],
          )),
      body: GetBuilder<ProductsController>(
        builder: (controller) => controller.loading
            ? MyLoading()
            : ListView.builder(
                itemCount: controller.products.length,
                itemBuilder: (BuildContext context, int index) => InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 16,
                                backgroundColor: Colors.white.withOpacity(0.9),
                                child: Container(
                                  height: 520,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Lottie.asset(
                                          'asset/Animation - 1750931098097 (1).json'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      // Divider(color: MyColors.primary,thickness: 3,indent: 20,endIndent: 20,),
                                      Container(
                                        child: Text(
                                          '${controller.products[index]['name']}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ),
                                      Divider(
                                        color: MyColors.primary,
                                        thickness: 3,
                                        indent: 20,
                                        endIndent: 20,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "description : ",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: MyColors.primary,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Text(
                                              '${controller.products[index]['des']}')),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    if (controller.number ==
                                                        1) {
                                                      return;
                                                    }
                                                    controller.number--;
                                                    controller.update();
                                                  },
                                                  icon: Icon(Icons.minimize)),
                                              SizedBox(
                                                height: 15,
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          GetBuilder<ProductsController>(
                                              builder: (controller) =>
                                                  Container(
                                                    child: Text(
                                                      '${controller.number}',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  )),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                controller.number++;
                                                controller.update();
                                              },
                                              icon: Icon(Icons.add)),
                                        ],
                                      ),
                                      Container(
                                        width: 200,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: MyColors.primary,
                                                width: 2)),
                                        child: MaterialButton(
                                          onPressed: () {
                                            controller.addPost(
                                                productName: controller
                                                    .products[index]['name'],
                                                price: controller
                                                    .products[index]['price'],
                                                storeName: storeName,
                                                delivery: delivery,
                                                url: controller.products[index]
                                                    ['url'],
                                                productId: controller.products[index].id);
                                            Get.back();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text('done !')));
                                          },
                                          child: Text(
                                            'Add to cart',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: 200,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: MyColors.primary,
                                                width: 2)),
                                        child: MaterialButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ));
                    },
                    child: Product(
                      imageUrl: controller.products[index]['url'],
                      name: controller.products[index]['name'],
                      price: controller.products[index]['price'],
                    )),
              ),
      ),
      ////////////////////////////////////////////////////////////
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Get.offAll(HomePage(
                  initialIndex: 2,
                ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("Go to cart"),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
