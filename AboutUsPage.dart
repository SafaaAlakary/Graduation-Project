import 'package:flutter/material.dart';
import 'package:on_the_way/constans/Color.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        centerTitle: true,
        backgroundColor: MyColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo or Icon
            Center(
              child: Icon(
                Icons.local_shipping_rounded,
                size: 80,
                color: MyColors.primary,
              ),
            ),
            const SizedBox(height: 20),

            // App name
            Center(
              child: Text(
                'On The Way',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: MyColors.primary,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Short description
            Center(
              child: Text(
                'Fast & Reliable Delivery Service',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            ),
            const SizedBox(height: 30),

            // About text
            Text(
              'Welcome to On The Way!\n',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(
              'On The Way is a modern delivery app designed to bring your favorite products right to your doorstep — fast, simple, and reliable. Whether you’re ordering food, groceries, or other essentials, we make sure everything gets to you on time and with care.',
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
            const SizedBox(height: 20),

            // Founder info
            Text(
              'Developed with ❤️ by Ameer & Dalaa',
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
