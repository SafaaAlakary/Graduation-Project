import 'package:flutter/material.dart';
import 'package:on_the_way/constans/Color.dart';

class CartItemInOrder extends StatelessWidget {
  final String storeName ;
  final String nameOfProduct;
  final int price;
  final int delivery;
  final int numberOfProduct;
  const CartItemInOrder({
    Key? key, required this.storeName, required this.nameOfProduct, required this.price, required this.delivery, required this.numberOfProduct,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 180,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1,color: Colors.black)

        ),
        child: Column( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(children: [Text('From : $storeName',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16),),],
            ),
            Row(children: [Text('The order :',style: TextStyle(color: MyColors.primary,fontSize: 16),),Text('$numberOfProduct $nameOfProduct ',style: TextStyle(fontSize: 16),),],),
            Row(children: [Text('The Price :',style: TextStyle(color: MyColors.primary,fontSize: 16),),Text(' $price SP',style: TextStyle(fontSize: 16),),],),
            Row(children: [Text('Delivery :',style: TextStyle(color: MyColors.primary,fontSize: 16),),Text(' $delivery SP',style: TextStyle(fontSize: 16),),],),
            Row(children: [Text('Total :',style: TextStyle(color: MyColors.primary,fontSize: 16),),Text(' ${price+delivery} SP',style: TextStyle(fontSize: 16),),],),
          ],
        )
    );
  }
}
