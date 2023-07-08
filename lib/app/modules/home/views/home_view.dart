import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import '../../../constants/contants.dart';
import '../../../reusable_widgets/common_widgets.dart';
import '../controllers/home_controller.dart';
import '../widgets/domain_widget.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalWidgets.defaultAppBar(title: 'Domains'),
      backgroundColor: scaffoldBackGroundColor,
      body: Obx(() {
        if (controller.domainDataLoaded.value == false) {
          return GlobalWidgets.shimmerForVerticalElement(
              h: MediaQuery.of(context).size.width * 0.2);
        } else if (controller.domainDataLoaded.value == true && controller.domainList.isEmpty) {
          return const Center(child: Text('No domain found'));
        } else {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: AnimationLimiter(
              child: ListView.builder(
                  itemCount: controller.domainList.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                            horizontalOffset: 50.0,
                            child: FadeInAnimation(child: DomainWidget(domainModel: controller.domainList[index]))));
                  }),
            ),
          );
        }
      }),
    );
  }
}
