import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mailbox/app/api/customExceptions.dart';

class APIManager {
  Future<dynamic> postAPICallWithHeader({String? url, var param, Map<String, String>? headerData}) async {
    print("Calling API: $url");
    print("Calling parameters: ${param}");
    print("Calling parameters: ${headerData}");

    var responseJson;
    try {
      final response = await http.post(Uri.parse(url!), body: param, headers: headerData ?? {});
      print('APIManager.getWithHeader:${response.body}');
      responseJson = apiResponse(response);

    } on SocketException catch (e) {
      print('APIManager.postAPICallWithHeader: $e');

      throw FetchDataException('Socket Exception in postAPICallWithHeader :${e.toString()}');
    } catch (e) {
      debugPrint('Exception in postAPICallWithHeader :${e.toString()}');
      throw ('Exception in postAPICallWithHeader :${e.toString()}');
    }
    return responseJson;
  }


  Future<dynamic> getWithHeader({String? url, Map<String, String>? headerData}) async {
    print("Calling API: $url");
    print("Calling API header: $headerData");
    var responseJson;
    try {
      final response = await http.get(Uri.parse(url!), headers: headerData ?? {});

      print('APIManager.getWithHeader:$response');
      responseJson = apiResponse(response);
    } on SocketException catch (e) {
      throw FetchDataException('Socket Exception in getWithHeader :${e.toString()}');
    } catch (e) {
      throw ('Exception in getWithHeader :${e.toString()}');
    }
    return responseJson;
  }


  Future<dynamic> delete({String? url, Map<String, String>? headerData}) async {
    print("Calling API: $url");
    print("Calling API header: $headerData");
    var responseJson;
    try {
      final response =await http.delete(Uri.parse(url!), headers: headerData);
      print('APIManager.delete"${response.body}');
      responseJson = response.statusCode;

    } on SocketException catch (e) {
      throw FetchDataException('Socket Exception in delete :${e.toString()}');
    } catch (e) {
      throw ('Exception in delete :${e.toString()}');
    }
    return responseJson;
  }


  Future<dynamic> patch({String? url, var param, Map<String, String>? headerData}) async {
    print("Calling API: $url");
    print("Calling API header: $headerData");
    var responseJson;
    try {
      final response =await http.patch(Uri.parse(url!), headers: headerData,body:param);
      responseJson = response.statusCode;
    } on SocketException catch (e) {
      throw FetchDataException('Socket Exception in delete :${e.toString()}');
    } catch (e) {
      throw ('Exception in patch :${e.toString()}');
    }
    return responseJson;
  }




  dynamic apiResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 204:
        var responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
      case 422:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(response.body.toString());
    }
  }
}
