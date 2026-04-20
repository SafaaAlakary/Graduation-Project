import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../constans/Color.dart';
import '../../controller/SignUpController.dart';
import '../widget/MyButton.dart';
import '../widget/TextForm.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final SignUpController controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          children: [
            const Text(
              "Sign",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Text(
              "Up",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: MyColors.primary),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          const SizedBox(
            height: 20,
          ),
          MyTestForm(
              hint: "Enter your username",
              icon: const Icon(Icons.text_snippet_outlined),
              label: "Username",
              mycontroller: controller.usrename),

          const SizedBox(
            height: 30,
          ),
          MyTestForm(
              hint: "Enter your E_mail",
              icon: const Icon(Icons.email_outlined),
              label: "E_mail",
              mycontroller: controller.email),
          const SizedBox(
            height: 30,
          ),
          MyTestForm(
              hint: "Enter your password",
              icon: const Icon(Icons.lock_outline),
              label: "Password",
              mycontroller: controller.password),
          const SizedBox(
            height: 30,
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
          //   child: AppTextField(
          //     cities: [
          //       SelectedListItem(name: 'As-Sweida'),
          //       SelectedListItem(name: 'Lattakia'),
          //       SelectedListItem(name: 'Damascus'),
          //       SelectedListItem(name: 'Tartous'),
          //       SelectedListItem(name: 'Rural Damascus'),
          //       SelectedListItem(name: 'Al-Hasakeh'),
          //       SelectedListItem(name: "Dar'a"),
          //       SelectedListItem(name: 'Quneitra'),
          //       SelectedListItem(name: 'Ar-Raqqa'),
          //       SelectedListItem(name: 'Idleb'),
          //       SelectedListItem(name: 'Aleppo'),
          //       SelectedListItem(name: 'Homs'),
          //       SelectedListItem(name: 'Hama'),
          //
          //     ],
          //     textEditingController: controller.city,
          //     title: "Select city",
          //     hint: "Cities",
          //     isCitySelected: true, Option: 'Cities',),
          //
          // ),
          const SizedBox(height: 30,),
          MyButton(
              text: "Sign Up",
              onPressed: () async {
               await controller.signup();
              }),
          const SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () {
              Get.offAllNamed("/login");
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  " have an account ?  ",
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  "Log In",
                  style: TextStyle(
                      color: MyColors.primary, fontWeight: FontWeight.bold),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
