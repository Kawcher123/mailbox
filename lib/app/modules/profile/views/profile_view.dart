import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/contants.dart';
import '../../../reusable_widgets/common_widgets.dart';
import '../../../reusable_widgets/bottom_nav_bar_widget.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalWidgets.defaultAppBar(title: 'Message'),
      backgroundColor: scaffoldBackGroundColor,
      body: const Center(
        child: Text(
          'ProfileView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(selectedIndex: 1),
    );
  }
}
