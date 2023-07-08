import 'dart:convert';

import 'package:flutter/material.dart';

import '../api/api_manager.dart';
import '../api/api_url.dart';
import '../models/login_model.dart';
import '../models/sign_up_model.dart';

class AuthRepository {
  final APIManager _apiManager = APIManager();
  Future<SignUpModel?> signUp({required Map<String, String> signUpData}) async {
    try {
      SignUpModel signUpModel;
      var response = await _apiManager.postAPICallWithHeader(
        url: ApiUrl.signUpUrl,
        param: jsonEncode({"address": signUpData['address'], "password": signUpData['password']}),
        headerData: {'Accept': 'application/json', 'Content-Type': 'application/json'},
      );

      signUpModel = SignUpModel.fromJson(response);
      return signUpModel;
    } catch (e) {
      debugPrint('Error in signUp() of AuthRepository:$e');
      return null;
    }
  }

  Future<LoginModel?> login({required Map<String, String> loginData}) async {
    try {
      LoginModel loginModel;
      var response = await _apiManager.postAPICallWithHeader(
        url: ApiUrl.loginUrl,
        param: jsonEncode({"address": loginData['address'], "password": loginData['password']}),
        headerData: {'Accept': 'application/json', 'Content-Type': 'application/json'},
      );

      print('AuthRepository.login:$response');
      loginModel = LoginModel.fromJson(response);
      return loginModel;
    } catch (e) {
      debugPrint('Error in login() of AuthRepository:$e');
      return null;
    }
  }
}
