import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/sign_up_model.dart';
import '../../../repositories/auth_repository.dart';
import '../../../reusable_widgets/common_widgets.dart';
import '../../../routes/app_pages.dart';

class SignUpController extends GetxController {
  RxBool obscureText = true.obs;
  IconData icon = Icons.visibility;
  final AuthRepository _authRepository = AuthRepository();
  void signUpMethod(Map<String, String> signUpData) {
    try {
      GlobalWidgets.customLoader();
      _authRepository.signUp(signUpData: signUpData).then((SignUpModel? responseData) {
        Get.back();
        if (responseData?.id != null) {
          GlobalWidgets.showCustomSnackBar('Registration has successfully been completed',
              isError: false, duration: 3);
          Get.toNamed(Routes.LOGIN);
        } else {
          GlobalWidgets.showCustomSnackBar('Registration failed', isError: true, duration: 3);
        }
      });
    } catch (e) {
      GlobalWidgets.showCustomSnackBar('Registration failed', isError: true);
      debugPrint('Error in signUpMethod() of SignUpController:$e');
    }
  }
}
