import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class MyLoading extends StatelessWidget {
  const MyLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Lottie.asset("asset/loading.json"),) ;
  }
}
