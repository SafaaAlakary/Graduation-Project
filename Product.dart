import 'package:flutter/material.dart';
import 'package:on_the_way/constans/Color.dart';

class Product extends StatelessWidget {
  final String imageUrl;
  final String name;
  final int price;

  const Product({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      height: 250,
      decoration: BoxDecoration(
        border: Border.all(width: 0, color: Colors.black),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          // ✅ صورة محسّنة بالشكل
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: 175,
                  height: 175,
                ),
              ),
            ),
          ),

          Divider(
            color: MyColors.primary,
            thickness: 3,
            indent: 20,
            endIndent: 20,
          ),

          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.money, color: MyColors.primary),
                    Text(
                      "  Price : $price SP ",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.info_outline,
                        color: MyColors.primary,
                        size: 30,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
