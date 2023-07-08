import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/contants.dart';
import '../../../models/message_model.dart';
import '../../../routes/app_pages.dart';
import '../controllers/message_controller.dart';

class MessageWidget extends GetWidget<MessageController> {
  MessageModel messageModel;
  MessageWidget({Key? key, required this.messageModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: ListTile(
        onTap: (){

          Get.toNamed(Routes.MESSAGE_DETAILS, arguments: messageModel.id);
        },
        leading: CircleAvatar(
          backgroundColor: fontColor,
          child: Text(
            '${messageModel.from?.name?.substring(0, 1)}',
            style: const TextStyle(color: backGroundColor, fontWeight: FontWeight.bold),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: width * 0.01),
          child: Text(messageModel.from?.name ?? '',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: messageModel.seen == true ? hintColor : fontColor),
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              messageModel.subject ?? 'No subject',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: messageModel.seen == true ? hintColor : fontColor,
                  fontSize: 13),
            ),
            SizedBox(height: width * 0.01),
            Text(
              messageModel.intro ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12),
            )
          ],
        ),
        trailing: Text(
            DateFormat.jm().format(DateTime.parse(messageModel.createdAt ?? '').toLocal()),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: messageModel.seen == true ? hintColor : fontColor)),
      ),
    );
  }
}
