import 'package:flutter/material.dart';
import 'package:on_the_way/constans/Color.dart';

class Store extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String city;
  final int deliveryCost;
  final bool active;

  const Store({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.active,
    required this.city,
    required this.deliveryCost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
        height: 140,
        decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2),blurRadius: 5,spreadRadius: 0)],
          border: Border.all(
              width: 0,color: Colors.black
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: [
            Expanded(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Image.network(imageUrl),
            )),
            Container(
              width: 1,
              height: 140,
              color: Colors.black,
            ),
            Expanded( flex:2,child:
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('$name',style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on_outlined,color: MyColors.primary,),
                      Text('$city',style: TextStyle(fontSize: 16),)
                    ],),
                  ///////////////////////////////////////////////////////////
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.delivery_dining_outlined,color: MyColors.primary,),
                      Text('Delivery: $deliveryCost S.P',style: TextStyle(fontSize: 16),)
                    ],),

                  active?
                  Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(width: 10,height: 10,decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)
                      ),),
                      // Icon(Icons.sports_volleyball_sharp,color: Colors.green,),
                      Text(' Open',style: TextStyle(fontSize: 16),)
                    ],
                  )
                      : Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(width: 10,height: 10,decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10)
                      ),),
                     // Icon(Icons.sports_volleyball_sharp,color: Colors.red,),
                      Text(' Close',style: TextStyle(fontSize: 16),)
                    ],
                  )],),
            )
            )
          ],

        )
    );
  }
}
