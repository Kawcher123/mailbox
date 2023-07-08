import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailbox/app/constants/contants.dart';

import '../routes/app_pages.dart';

class BottomNavBarWidget extends StatelessWidget {
  int selectedIndex = 0;

  BottomNavBarWidget({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BottomAppBar(
      color: primaryColor,
      child: SizedBox(
        height: width * 0.15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MaterialButton(
              minWidth: width * 0.1,
              onPressed: () {
                if (selectedIndex != 0) {
                  Get.offAllNamed(Routes.MESSAGE);
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    CupertinoIcons.mail,
                    color: selectedIndex == 0 ? Get.theme.primaryColor : backGroundColor,
                  ),
                  Text(
                    'Messages',
                    style: TextStyle(
                        color: selectedIndex == 0 ? Get.theme.primaryColor : backGroundColor),
                  ),
                  Container(
                      height: 2,
                      width: 50,
                      color: selectedIndex == 0 ? Get.theme.primaryColor : noColor)
                ],
              ),
            ),
            MaterialButton(
              minWidth: width * 0.1,
              onPressed: () {
                if (selectedIndex != 1) {
                  Get.offAllNamed(Routes.PROFILE);
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    CupertinoIcons.person,
                    color: selectedIndex == 1 ? Get.theme.primaryColor : backGroundColor,
                  ),
                  Text(
                    'Profile',
                    style: TextStyle(
                        color: selectedIndex == 1 ? Get.theme.primaryColor : backGroundColor),
                  ),
                  Container(
                      height: 2,
                      width: 50,
                      color: selectedIndex == 1 ? Get.theme.primaryColor : noColor)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
