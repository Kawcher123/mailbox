import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/message_model.dart';
import '../../../repositories/my_mail_repository.dart';
import '../../../reusable_widgets/common_widgets.dart';
import '../../../routes/app_pages.dart';

class MessageController extends GetxController {
  RxList<MessageModel> messageList = <MessageModel>[].obs;
  RxList<MessageModel> searchMessageList = <MessageModel>[].obs;
  RxBool messageDataLoaded = false.obs;
  final MyMailRepository _myMailRepository=MyMailRepository();
  @override
  void onInit() {
    messageGetMethod();
    super.onInit();
  }

  void messageGetMethod() {
    try {
      _myMailRepository.getMessage().then((List<MessageModel> responseData) {
        messageList.value = responseData;
        messageDataLoaded.value = true;
      });
    } catch (e) {

    }
  }

  List<MessageModel> messageSearchList({required String searchQuery}) {
    if (searchQuery.isEmpty) {
      searchMessageList.clear();
      messageGetMethod();
      return messageList;
    } else {
      searchMessageList.value = messageList
          .where((element) => element.subject!.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
      return searchMessageList;
    }
  }



  void updateMessageMethod({required String messageId}) {
    try {
      GlobalWidgets.customLoader();
      _myMailRepository.updateMessage(messageId: messageId).then((bool value) {
        Get.back();
        if (value == true) {
        messageGetMethod();
        }
        Get.toNamed(Routes.MESSAGE_DETAILS, arguments: messageId);
      });
    } catch (_) {
      debugPrint('Error in deleteMessageMethod in Message Detailes controller: $_');
    }
  }
}
