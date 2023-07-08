import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../constants/contants.dart';
import '../controllers/message_details_controller.dart';
import '../widgets/details_body_widget.dart';

class MessageDetailsView extends GetView<MessageDetailsController> {
  const MessageDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackGroundColor,
      appBar: _appBarWidget(),
      body: Obx((){
        return controller.messageDataLoading.value == true
            ?const Center(child: CupertinoActivityIndicator())
            :DetailsBodyWidget(messageDetailsModel: controller.messageDetails.value);
      })
    );
  }
  AppBar _appBarWidget() {
    return AppBar(
      iconTheme: const IconThemeData(
        color: fontColor, //change your color here
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: backGroundColor,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: backGroundColor,
          systemNavigationBarIconBrightness: Brightness.dark),
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: backGroundColor,
      actions: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: (){
              Get.defaultDialog(
                titlePadding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
                contentPadding:
                const EdgeInsets.only(left: 10, right: 10, bottom: 30.0),
                title: 'Are you sure, you want to delete this message?',
                content: const Icon(
                  CupertinoIcons.delete_solid,
                  color: Colors.red,
                  size: 50,
                ),
                confirm: ElevatedButton(
                  onPressed: () {
                    controller.deleteMessageMethod(messageId: controller.messageId.value);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: noColor, elevation: 0.0),
                  child: const Text(
                    'Yes',
                    style: TextStyle(color: fontColor),
                  ),
                ),
                cancel: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    elevation: 0.0,
                  ),
                  child: const Text(
                    'No',
                    style: TextStyle(color: backGroundColor),
                  ),
                ),
              );
            },
            child: const CircleAvatar(
              backgroundColor: Colors.black12,
              child: Icon(CupertinoIcons.delete, color: fontColor, size: 18),
              ),
          ),
          ),
      ],
    );
  }
}
