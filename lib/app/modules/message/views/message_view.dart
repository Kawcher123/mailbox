import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:mailbox/app/services/user_service_db.dart';
import '../../../constants/contants.dart';
import '../../../reusable_widgets/common_widgets.dart';
import '../../../routes/app_pages.dart';
import '../controllers/message_controller.dart';
import '../widgets/message_widget.dart';

class MessageView extends GetView<MessageController> {
  const MessageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return RefreshIndicator(
      displacement: 250,
      backgroundColor: primaryColor,
      color: backGroundColor,
      strokeWidth: 3,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 1500));
        controller.messageGetMethod();
        GlobalWidgets.showCustomSnackBar('Page refreshed', isError: false, duration: 2);
      },
      child: Scaffold(
        backgroundColor: scaffoldBackGroundColor,
        appBar: _appBarWidget(width: width),
        body: Obx(() {
          if (controller.messageDataLoaded.value == false) {
            return GlobalWidgets.shimmerForVerticalElement();
          } else if (controller.messageDataLoaded.value == true && controller.messageList.isEmpty) {
            return const Center(child: Text('No message found'));
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  searchFieldWidget,
                  SizedBox(height: width * 0.05),
                  AnimationLimiter(
                    child: ListView.builder(
                        primary: false,
                        itemCount: controller.searchMessageList.isEmpty
                            ? controller.messageList.length
                            : controller.searchMessageList.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                              horizontalOffset: 50.0,
                              child: FadeInAnimation(
                                child: MessageWidget(
                                    messageModel: controller.searchMessageList.isEmpty
                                        ? controller.messageList[index]
                                        : controller.searchMessageList[index]),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            );
          }
        }),
      ),
    );
  }

  AppBar _appBarWidget({required double width}) {
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
      title: const Text('Messages', style: TextStyle(color: fontColor)),
      backgroundColor: backGroundColor,
      automaticallyImplyLeading: false,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: InkWell(
            onTap: () {
              _showDialogue(width: width);
            },
            child: const CircleAvatar(
              radius: 17,
              backgroundColor: fontColor,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: backGroundColor,
                backgroundImage: AssetImage('assets/sender.png'),
              ),
            ),
          ),
        )
      ],
    );
  }

  void _showDialogue({required double width}) {
    Get.dialog(
        Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        //insetPadding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Stack(
          children: [
            Container(
              width: Get.size.width,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 32,
                        backgroundColor: fontColor,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: backGroundColor,
                          backgroundImage: AssetImage('assets/sender.png'),
                        ),
                      ),
                      SizedBox(height: width * 0.02),

                      Text(UserServiceDB.userServiceDB.getUserData().username??''),
                      SizedBox(height: width * 0.1),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0.0,
                          backgroundColor: primaryColor
                        ),
                          onPressed: (){
                        Get.defaultDialog(
                          titlePadding:
                          const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
                          contentPadding:
                          const EdgeInsets.only(left: 10, right: 10, bottom: 30.0),
                          title: 'Are you sure, you want to log out?',
                          content: const Icon(
                            Icons.logout,
                            color: Colors.red,
                            size: 50,
                          ),
                          confirm: ElevatedButton(
                            onPressed: () {
                              UserServiceDB.userServiceDB.removeData();
                              Get.offAllNamed(Routes.HOME);
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
                      }, child: const Text('Log out'))
                    ],
                  ),
                ),
              ),
            ),
            Positioned.fill(
                child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Icon(CupertinoIcons.clear, color: backGroundColor, size: 10),
                  ),
                ),
              ),
            ))
          ],
        )));
  }

  Widget get searchFieldWidget => Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SizedBox(
            height: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: TextFormField(
                style: const TextStyle(color: fontColor),
                cursorColor: primaryColor,
                decoration: InputDecoration(
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  filled: true,
                  fillColor: Colors.black12,
                  contentPadding: const EdgeInsets.all(15.0),
                  border: InputBorder.none,
                  hintText: 'Search by subject in mail',
                  hintStyle: TextStyle(color: hintColor, fontSize: 15),
                ),
                onChanged: (String value) {
                  controller.messageSearchList(searchQuery: value);
                },
              ),
            ),
          ),
        ),
      );
}
