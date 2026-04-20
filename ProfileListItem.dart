import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileListItem extends StatelessWidget {
  ProfileListItem({super.key, required this.cchild});

  Widget? cchild;

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 50,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
              spreadRadius: 3)
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      width: 340,
      //height: 50,
      margin: EdgeInsets.all(5),
      //padding: EdgeInsets.all(10),
      child: Padding(padding: const EdgeInsets.all(15), child: cchild),
    );
  }
}
