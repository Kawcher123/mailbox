import 'dart:async';
import 'package:get/get.dart';
import 'package:mailbox/app/services/user_service_db.dart';

import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    print('SplashController.onInit:${UserServiceDB.userServiceDB.isAuth}');
    Timer(
        const Duration(seconds: 4),
        () => Get.offNamed(
            UserServiceDB.userServiceDB.isAuth ?Routes.MESSAGE: Routes.HOME ));
    super.onInit();
  }
}
