  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:get/get_core/src/get_main.dart';
  import 'package:lottie/lottie.dart';
  import 'package:on_the_way/constans/Color.dart';
  import 'package:on_the_way/controller/OrderController.dart';
  import 'package:on_the_way/view/page/HomePage.dart';
  import 'package:on_the_way/view/page/MapPage.dart';
  import 'package:on_the_way/view/page/OrderStatus.dart';
  import 'package:on_the_way/view/widget/NumberTextForm.dart';
  import 'package:on_the_way/view/widget/TextForm.dart';

  import '../widget/CartItemInOrder.dart';

  class Order extends StatelessWidget {
    Order({super.key, required this.theOrder});

    var theOrder;
    OrderController controller = Get.put(OrderController());

    @override
    Widget build(BuildContext context) {
      controller.theOrder = theOrder;
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: MyColors.primary,
          elevation: 2,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              size: 30,
            ),
          ),
          title: Row(
            children: [
              Text(
                'The order   ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Lottie.asset('asset/AnimationDeliveryonaBike.json',
                  height: 80, width: 80),
            ],
          ),
        ),
        body: GetBuilder<OrderController>(
          builder: (controller) => ListView(
            padding: EdgeInsets.all(0),
            children: [
              CartItemInOrder(
                  storeName: theOrder['storeName'],
                  nameOfProduct: theOrder['productName'],
                  price: theOrder['price'],
                  delivery: theOrder['delivery'],
                  numberOfProduct: theOrder['numberOfProduct']),
              SizedBox(
                height: 5,
              ),
              MyTestForm(
                  hint: 'Enter your additions',
                  icon: Icon(Icons.add_circle),
                  label: 'Additions',
                  mycontroller: controller.note),
              SizedBox(
                height: 5,
              ),
              Text(
                '   Location :',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () async {
                  showDialog(
                      context: (context),
                      builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            content: Container(
                              height: 250,
                              child: Column(
                                children: [
                                  Lottie.asset('asset/search.json'),
                                  SizedBox(height: 20),
                                  Text(
                                    "Please wait ! ",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: MyColors.primary),
                                  )
                                ],
                              ),
                            ),
                          ));
                  List<double>? p =
                      await controller.getCurrentLocationAndUpload();
                  Get.back();
                  if (p != null) {
                    double lat = p[0];
                    double lon = p[1];
                    controller.lat = lat;
                    controller.lon = lon;
                    Get.to(MapPage(latitude: lat, longitude: lon));
                    controller.doneLocation = true;
                    controller.update();
                  } else {
                    print('لم يتم الحصول على الموقع');
                  }
                },
                child: Card(
                  //height: 50,
                  margin: EdgeInsets.all(15),
                  //padding: EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 15, left: 14),
                    child: Row(
                      children: [
                        Text(
                          'Select your location',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        controller.doneLocation
                            ? Icon(
                                Icons.check_box,
                                color: Colors.green,
                              )
                            : Container()
                      ],
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
              ),
              Card(
                  shape: const RoundedRectangleBorder(
                      side: BorderSide(width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  margin: const EdgeInsets.all(15),
                  child: CheckboxListTile(
                    activeColor: MyColors.primary,
                    onChanged: (val) {
                      controller.call = val!;
                      controller.update();
                    },
                    value: controller.call,
                    title: Text('Call me when arrive !'),
                  )),
              SizedBox(
                height: 5,
              ),
              controller.call
                  ? MyNumberTestForm(
                      hint: 'Enter your number',
                      icon: Icon(Icons.phone),
                      label: 'Phone number',
                      mycontroller: controller.phone)
                  : Container(),
              SizedBox(
                height: 5,
              ),
              Text(
                '   Pay method :',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              RadioListTile(
                  activeColor: MyColors.primary,
                  title: Text('Cash'),
                  value: true,
                  groupValue: controller.pay,
                  onChanged: (value) {
                    controller.pay = value;
                    controller.donePay = true;
                    controller.update();
                  }),
              RadioListTile(
                  activeColor: MyColors.primary,
                  title: Text('SyriaTel Cash'),
                  value: false,
                  groupValue: controller.pay,
                  onChanged: (value) {
                    controller.pay = value;
                    controller.donePay = false;
                    controller.update();
                  }),
              SizedBox(
                height: 5,
              ),
              controller.pay ?? true
                  ? Container()
                  : Card(
                      //height: 50,
                      margin: EdgeInsets.all(8),
                      //padding: EdgeInsets.all(10),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 15, bottom: 15, left: 14),
                        child: Text(
                          'Pay Here !',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(width: 0),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
            ],
          ),
        ),
        floatingActionButton: GetBuilder<OrderController>(
          builder: (controller) => controller.donePay
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                            await controller.addOrder();
                            controller.incrementOne();
                            controller.deleteItem(
                                id: theOrder.id); // انتبه: إذا theOrder Map استخدم ['id']
                            await Future.delayed(Duration(milliseconds: 500));

                            Get
                                .off(() =>  OrderStatus()); // ← هنا صار يروح للصفحة الجديدة


                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text("Continue !"),
                      ),
                    ),
                  ),
                )
              : Container(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
    }
  }
