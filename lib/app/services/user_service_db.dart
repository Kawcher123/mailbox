import 'dart:convert';
import '../database/hive_service.dart';
import '../models/user_model.dart';

class UserServiceDB {
  static UserServiceDB? _userServiceDB;

  UserServiceDB._();

  static UserServiceDB get userServiceDB => _userServiceDB ??= UserServiceDB._();

  static const hiveBoxName = "userBox";
  final accessTokenKey = "accessToken";
  final refreshTokenKey = "refreshToken";
  final userDataKey = "userData";

  Future<void> initializeDB() async {
    await HiveService.hiveDbService.createBox(hiveBoxName);
  }


  Future<void> setUserToken(String token) async {
    HiveService.hiveDbService.addWithKey(accessTokenKey, token, hiveBoxName);
  }

  void setUserData(UserModel? userData) {
    HiveService.hiveDbService.addWithKey(userDataKey, jsonEncode(userData?.toJson()), hiveBoxName);
  }

  bool get isAuth => HiveService.hiveDbService.getByKey(accessTokenKey, hiveBoxName) == null ? false : true;
  String get getToken => HiveService.hiveDbService.getByKey(accessTokenKey, hiveBoxName) ?? '';
  UserModel getUserData() {
    UserModel userInfoModel = UserModel();
    var response = HiveService.hiveDbService.getByKey(userDataKey ?? '', hiveBoxName);

    if (response != null) {
      if (response.isNotEmpty) {
        Map<String, dynamic> resp = jsonDecode(response);
        userInfoModel = UserModel.fromJson(resp);
      }
    } else {
      userInfoModel = UserModel();
    }

    return userInfoModel;
  }

  removeData() {
    HiveService.hiveDbService.clear(hiveBoxName);
  }
}
