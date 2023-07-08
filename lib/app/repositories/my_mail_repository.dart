import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mailbox/app/api/api_url.dart';
import 'package:mailbox/app/services/user_service_db.dart';

import '../api/api_manager.dart';
import '../models/domain_model.dart';
import '../models/message_details_model.dart';
import '../models/message_model.dart';

class MyMailRepository {
  final APIManager _apiManager = APIManager();
  Future<List<DomainModel>> getDomains() async {
    try {
      List<DomainModel> domainList = <DomainModel>[];
      var response = await _apiManager.getWithHeader(
        url: ApiUrl.domainsUrl,
        headerData: {
          'Accept': 'application/json',
        },
      );

      for (var domain in response) {
        domainList.add(DomainModel.fromJson(domain));
      }
      return domainList;
    } catch (e) {
      debugPrint('Error in getDomains() of MyMailRepository:$e');
      return [];
    }
  }

  Future<List<MessageModel>> getMessage() async {
    try {
      List<MessageModel> messageList = <MessageModel>[];
      var response = await _apiManager.getWithHeader(
        url: ApiUrl.messageUrl,
        headerData: {'Authorization': 'Bearer ${UserServiceDB.userServiceDB.getToken}', 'Accept': 'application/json'},
      );

      for (var message in response) {
        messageList.add(MessageModel.fromJson(message));
      }
      return messageList;
    } catch (e) {
      debugPrint('Error in getMessage() of MyMailRepository:$e');
      return [];
    }
  }

  Future<MessageDetailsModel?> getMessageDetails({required String messageId}) async {
    try {
      MessageDetailsModel messageDetailsModel;
      var response = await _apiManager.getWithHeader(
        url: '${ApiUrl.messageUrl}/$messageId',
        headerData: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${UserServiceDB.userServiceDB.getToken}',
        },
      );

      messageDetailsModel = MessageDetailsModel.fromJson(response);
      return messageDetailsModel;
    } catch (e) {
      debugPrint('Error in getMessageDetails() of MyMailRepository:$e');
      return null;
    }
  }

  Future<bool> deleteMessage({required String messageId}) async {
    try {
      var response = await _apiManager.delete(
        url: '${ApiUrl.messageUrl}/$messageId',
        headerData: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${UserServiceDB.userServiceDB.getToken}',
        },
      );

      print('MyMailRepository.deleteMessage:$response');

      if (response == 200 || response == 201 || response == 204) {

        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('Error in deleteMessage() of MyMailRepository:$e');
      return false;
    }
  }

  Future<bool> updateMessage({required String messageId}) async {
    try {
      var response = await _apiManager.patch(
        url: '${ApiUrl.messageUrl}/$messageId',
        param: jsonEncode({"seen": true}),
        headerData: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${UserServiceDB.userServiceDB.getToken}',
        },
      );

      if (response == 200 || response == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('Error in updateMessage() of MyMailRepository:$e');
      return false;
    }
  }
}
