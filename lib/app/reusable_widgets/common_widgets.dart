import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/contants.dart';

class GlobalWidgets {
  static AppBar defaultAppBar({String? title}) {
    return AppBar(
      title: Text(title ?? '', style: const TextStyle(color: fontColor)),
      iconTheme: const IconThemeData(
        color: fontColor, //change your color here
      ),
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: backGroundColor,
    );
  }

  static ClipRRect buttonWidget({required String? text, VoidCallback? press, Color? color}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: color ?? primaryColor),
        child: TextButton(
          onPressed: press,
          child: Text(
            text ?? '',
            style:
                const TextStyle(color: backGroundColor, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  static void showCustomSnackBar(String message, {@required bool? isError, int? duration}) {
    Get.showSnackbar(GetSnackBar(
      title: isError == true ? 'Warning' : 'Success',
      backgroundColor: fontColor,
      message: message,
      icon: CircleAvatar(
        radius: 10.0,
        backgroundColor: isError == true ? Colors.red : Colors.green,
        child: Icon(
          isError == true ? CupertinoIcons.clear_thick : CupertinoIcons.checkmark_alt,
          color: isError == true ? backGroundColor : fontColor,
          size: 10,
        ),
      ),
      maxWidth: double.infinity,
      duration: Duration(seconds: duration ?? 1),
      snackStyle: SnackStyle.FLOATING,
      margin: const EdgeInsets.all(10.0),
      borderRadius: 10.0,
      isDismissible: true,
      snackPosition: SnackPosition.TOP,
      dismissDirection: DismissDirection.horizontal,
    ));
  }

  static Widget customLoadingWidget() {
    return SpinKitThreeBounce(
      color: Get.theme.primaryColor,
      size: 40,
    );
  }

  static Future customLoader() {
    return Get.dialog(
      const SpinKitThreeBounce(
        color: backGroundColor,
        size: 40,
      ),
    );
  }

  static Widget shimmerForVerticalElement({double w = 0.0, double h = 0.0}) {
    return SingleChildScrollView(
        child: ListView.builder(
            itemCount: 10,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(
                    top: 5.0, bottom: 5.0, right: 8.0, left: 8.0),
                child: Shimmer.fromColors(
                  baseColor: shimmerColor,
                  highlightColor: Colors.white,
                  child: Container(
                    width: w == 0.0 ? Get.size.width : w,
                    height: h == 0.0 ? Get.size.width * 0.2 : h,
                    decoration: BoxDecoration(
                        color: shimmerColor,
                        borderRadius: BorderRadius.circular(3)),
                  ),
                ),
              );
            }));
  }
}
