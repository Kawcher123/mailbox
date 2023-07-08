import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'app/database/hive_service.dart';
import 'app/routes/app_pages.dart';
import 'app/services/user_service_db.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.hiveDbService.init();
  await UserServiceDB.userServiceDB.initializeDB();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "MailBox",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
