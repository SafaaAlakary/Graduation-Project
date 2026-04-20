import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:on_the_way/constans/Color.dart';

class PopularNow extends StatelessWidget {
   PopularNow({super.key,required this.url,required this.productName,required this.price});
  String url;
  String productName;
  int price;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2),blurRadius: 5,spreadRadius: 0)],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 0,
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(flex: 1, child: Padding(
            padding: const EdgeInsets.all(5),
            child: Image.network(url),
          )),
          Text(productName,style: TextStyle(color: MyColors.primary,fontWeight: FontWeight.bold),),
          Text('$price'),
          SizedBox(height: 5,)
        ],
      ),
    );
  }
}
