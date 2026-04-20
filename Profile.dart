import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:lottie/lottie.dart';
import 'package:on_the_way/controller/ProfileController.dart';
import 'package:on_the_way/view/page/AboutUsPage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../constans/Color.dart';
import '../widget/ProfileListItem.dart';
import 'MyArchive.dart';

class Profile extends StatelessWidget {
  Profile({super.key});
  ProfileController controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(30),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(80),
                      child: Image.asset(
                        'images/ameer.jpg',
                        width: 120,
                        height: 120,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(() => Text(
                          controller.username.value,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        )),

                        Icon(
                          Icons.verified,
                          color: Colors.blue,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            flexibleSpace: const FlexibleSpaceBar(),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(40),
                bottomLeft: Radius.circular(40),
              ),
            ),
            expandedHeight: 200,
            backgroundColor: MyColors.primary,
            floating: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 1,
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 20),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1,color: Colors.black38),
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 3,
                    child: Column(
                      children: [
                        ///////////////////////////////////////////////////////////////////////// allthing
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 20,
                            ),

                            Container(
                              child: Row(
                                children: [
                                  Text('15 Points'),
                                  Icon(
                                    Icons.star_sharp,
                                    color: Colors.amber,
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        blurRadius: 5,
                                        spreadRadius: 0)
                                  ],
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    width: 0,
                                  )),
                              padding: EdgeInsets.all(10),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(height: 5,color: MyColors.primary,),
                        InkWell(onTap: (){Get.to(ArchivePage());},
                            child: ProfileListItem(cchild: Text("My archive"),)),
                        SizedBox(height: 5,),
                        Divider(height: 5,color: MyColors.primary,),
                        ProfileListItem(cchild: Text("Invate friends !"),),
                        SizedBox(height: 5,),
                        Divider(height: 5,color: MyColors.primary,),
                        InkWell(
                        onTap:(){
                          Get.to(AboutUsPage());
                        },    child: ProfileListItem(cchild:Text("Aboute us "))

                        ),
                        SizedBox(height: 5,),
                        SizedBox(height: 5,),
                         Divider(height: 5,color: MyColors.primary,),
                        InkWell(onTap:(){
                          controller.openWhatsApp('963945871217', 'مرحبًا، أحتاج مساعدة في التطبيق.');
                        },
                            child: ProfileListItem(cchild:Text("Support & complaints"))),
                        SizedBox(height: 5,),
                        Divider(height: 5,color: MyColors.primary,),
                        InkWell(onTap: (){
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 16,
                                backgroundColor:
                                Colors.white.withOpacity(0.9),
                                child: Container(
                                  height: 350,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Lottie.asset('asset/logout.json',
                                          width: 200, height: 200),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Are you sure ?',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              controller.logOut();
                                              },
                                            child: Text(
                                              'Yes',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20),
                                            ),
                                            style: TextButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            10)),
                                                    side: BorderSide(
                                                      color: MyColors.primary,
                                                      width: 2,
                                                    ))),
                                          ),
                                          TextButton(
                                            onPressed: () {Get.back();},
                                            child: Text(
                                              'No',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20),
                                            ),
                                            style: TextButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            10)),
                                                    side: BorderSide(
                                                      color: MyColors.primary,
                                                      width: 2,
                                                    ))),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ));
                        },
                            child: ProfileListItem(cchild: Row(children: [Text("Log out  "),Icon(Icons.logout,color: MyColors.primary,)],),)),

                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
