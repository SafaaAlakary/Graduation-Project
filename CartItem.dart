import 'package:flutter/material.dart';
import 'package:on_the_way/constans/Color.dart';

class CartItem extends StatelessWidget {
  final String storeName ;
  final String nameOfProduct;
  final int price;
  final int delivery;
  final int numberOfProduct;
  Function()? onPressed;
   CartItem({
    Key? key, required this.storeName, required this.nameOfProduct, required this.price, required this.delivery, required this.numberOfProduct,required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      padding: EdgeInsets.all(10),
    margin: EdgeInsets.all(8),
    decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2),blurRadius: 5,spreadRadius: 0)],
      borderRadius: BorderRadius.circular(20),
      border: Border.all(width: 0,color: Colors.black)
      
    ),
      child: Column( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(children: [Icon(Icons.store_rounded,color: MyColors.primary,size: 30,),Text(' $storeName',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),],
          ),
          Row(children: [Text('The order :',style: TextStyle(color: MyColors.primary,fontSize: 16),),Text('$numberOfProduct $nameOfProduct ',style: TextStyle(fontSize: 16),),],),
          Row(children: [Text('The Price :',style: TextStyle(color: MyColors.primary,fontSize: 16),),Text(' $price SP',style: TextStyle(fontSize: 16),),],),
          Row(children: [Text('Delivery :',style: TextStyle(color: MyColors.primary,fontSize: 16),),Text(' $delivery SP',style: TextStyle(fontSize: 16),),],),
          Row(children: [Text('Total :',style: TextStyle(color: MyColors.primary,fontSize: 16),),Text(' ${price+delivery} SP',style: TextStyle(fontSize: 16),),],),
          Divider(color: MyColors.primary,thickness: 3,indent: 20,endIndent: 20,),
         Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: [
             Text('Continue ! ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
             IconButton(onPressed: onPressed, icon: Icon(Icons.delete_outline_outlined,color: MyColors.primary,size: 30,))
           ],
         )
        ],
      )
    );
  }
}
