import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mailbox/app/repositories/auth_repository.dart';
import 'package:mailbox/app/services/user_service_db.dart';

import '../../../models/login_model.dart';
import '../../../models/user_model.dart';
import '../../../repositories/my_mail_repository.dart';
import '../../../reusable_widgets/common_widgets.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  RxBool obscureText = true.obs;
  IconData icon = Icons.visibility;
  final AuthRepository _authRepository = AuthRepository();
  void loginPostMethod({required Map<String, String> loginData}) {
    try {
      GlobalWidgets.customLoader();
      _authRepository.login(loginData: loginData).then((LoginModel? responseData) {
        Get.back();
        if (responseData?.id != null) {
          Map<String, dynamic> userData = JwtDecoder.decode(responseData?.token ?? '');
          saveDataToDb(userToken: responseData?.token ?? '', userData: userData);
        } else {
          GlobalWidgets.showCustomSnackBar('Failed to login', isError: true, duration: 3);
        }
      });
    } catch (e) {
      GlobalWidgets.showCustomSnackBar('Failed to login', isError: true);
      debugPrint('Error in loginPostMethod() of LoginController:$e');
    }
  }

  void saveDataToDb({required String userToken, required Map<String, dynamic> userData}) async {
    String token = userToken.replaceAll('"', '');
    UserModel user = UserModel.fromJson(userData);
    UserServiceDB.userServiceDB.setUserToken(token);
    UserServiceDB.userServiceDB.setUserData(user);
    Get.offAllNamed(Routes.MESSAGE);
    GlobalWidgets.showCustomSnackBar('You are successfully logged in', isError: false, duration: 3);
  }
}
