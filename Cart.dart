import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:on_the_way/controller/CartController.dart';
import 'package:on_the_way/controller/ProfileController.dart';
import 'package:on_the_way/view/page/Order.dart';
import 'package:on_the_way/view/widget/CartItem.dart';
import 'package:on_the_way/view/widget/MyLoading.dart';
import '../../constans/Color.dart';

class Cart extends StatelessWidget {
  Cart({super.key});

  final CartController controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [

            ],
            title: const Text(
              "My cart",
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
      GetBuilder<CartController>(
        builder: (controller)=> controller.loading?
        SliverToBoxAdapter(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: MyLoading(),
            ),
          ),
        ):SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: controller.carts.length,
              (context, index) {
                return
                  InkWell(
                    onTap: () {
                      Get.to(Order(theOrder: controller.carts[index],));
                    },
                    child: CartItem(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  elevation: 16,
                                  backgroundColor:
                                      Colors.white.withOpacity(0.9),
                                  child: Container(
                                    height: 350,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Lottie.asset('asset/Delete.json',
                                            width: 200, height: 200),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Are you sure ?',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                Get.back();
                                                controller.deleteItem(id: controller.carts[index].id);},
                                              child: Text(
                                                'Yes',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20),
                                              ),
                                              style: TextButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                      side: BorderSide(
                                                        color: MyColors.primary,
                                                        width: 2,
                                                      ))),
                                            ),
                                            TextButton(
                                              onPressed: () {Get.back();},
                                              child: Text(
                                                'No',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20),
                                              ),
                                              style: TextButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                      side: BorderSide(
                                                        color: MyColors.primary,
                                                        width: 2,
                                                      ))),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ));
                      },
                      storeName: controller.carts[index]['storeName'],
                      nameOfProduct: controller.carts[index]['productName'],
                      price:controller.carts[index]['price'] ,
                      delivery: controller.carts[index]['delivery'],
                      numberOfProduct: controller.carts[index]['numberOfProduct'],
                    ));
              },
            ),
          ),),
        ],
      ),
    );
  }
}
