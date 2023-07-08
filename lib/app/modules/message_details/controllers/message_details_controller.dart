import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/message_details_model.dart';
import '../../../repositories/my_mail_repository.dart';
import '../../../reusable_widgets/common_widgets.dart';
import '../../../routes/app_pages.dart';
import '../../message/controllers/message_controller.dart';

class MessageDetailsController extends GetxController {
  Rx<MessageDetailsModel> messageDetails = MessageDetailsModel().obs;
  RxBool messageDataLoading = false.obs;
  RxBool isExpanded = false.obs;
  RxString messageId = ''.obs;
final MyMailRepository _myMailRepository=MyMailRepository();
  @override
  void onInit() {
    super.onInit();
    messageId.value = Get.arguments;
    messageDetailsGetMethod(messageId: messageId.value);
  }

  void messageDetailsGetMethod({required String messageId}) {
    try {
      messageDataLoading.value = true;
      _myMailRepository
          .getMessageDetails(messageId: messageId)
          .then((MessageDetailsModel? responseData) {
        messageDetails.value = responseData!;
        messageDataLoading.value = false;
      });
    } catch (_) {
      debugPrint('Error in messageDetailsGetMethod in Message Detailes controller: $_');
    }
  }

  void deleteMessageMethod({required String messageId}) {
    try {
      Get.back();
      GlobalWidgets.customLoader();
      _myMailRepository.deleteMessage(messageId: messageId).then((bool value) {
        Get.back();
        if (value == true) {
          GlobalWidgets.showCustomSnackBar('This message has been deleted', isError: false);
          Get.find<MessageController>().messageGetMethod();
          Get.offNamed(Routes.MESSAGE);
        } else {
          GlobalWidgets.showCustomSnackBar('Failed to delete', isError: true);
        }
      });
    } catch (_) {
      GlobalWidgets.showCustomSnackBar('Failed to delete', isError: true);
      debugPrint('Error in deleteMessageMethod in Message Detailes controller: $_');
    }
  }
}
