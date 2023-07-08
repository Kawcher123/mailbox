import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/domain_model.dart';
import '../../../repositories/my_mail_repository.dart';

class HomeController extends GetxController {
  RxList<DomainModel> domainList = <DomainModel>[].obs;
  RxBool domainDataLoaded = false.obs;
  final MyMailRepository _myMailRepository=MyMailRepository();
  @override
  void onInit() {
    domainGetMethod();
    super.onInit();
  }

  void domainGetMethod() {
    try {
      _myMailRepository.getDomains().then((List<DomainModel> responseData) {
        domainList.value = responseData;
        domainDataLoaded.value = true;
      });
    } catch (e) {
      domainDataLoaded.value = true;
      debugPrint('Error in domainGetMethod() of HomeController:$e');
    }
  }
}
