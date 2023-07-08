import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/contants.dart';
import '../../../reusable_widgets/common_widgets.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final FocusNode _emailNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, String> _loginData = {};
  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: GlobalWidgets.defaultAppBar(),
      backgroundColor: scaffoldBackGroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                const Text(
                  'Welcome Back to MailBox',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: width * 0.05),
                const Text('Login with your credentials'),
                SizedBox(height: width * 0.1),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0, left: 15.0, right: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _subHeadWidget('Email'),
                      SizedBox(
                        height: width * 0.02,
                      ),
                      _emailFieldWidget(),
                      SizedBox(
                        height: width * 0.05,
                      ),
                      _subHeadWidget('Password'),
                      SizedBox(
                        height: width * 0.02,
                      ),
                      _passwordFieldWidget(),
                      SizedBox(
                        height: width * 0.1,
                      ),
                      GlobalWidgets.buttonWidget(
                          text: 'Login',
                          press: () {
                            _submitDataMethod(context);
                          }),
                      SizedBox(
                        height: width * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(color: hintColor),
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(Routes.SIGNUP);
                            },
                            child: const Text(
                              'Sign up',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _subHeadWidget(String title) {
    return Text(title);
  }

  Container _emailFieldWidget() {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: TextFormField(
          style: const TextStyle(color: fontColor),
          cursorColor: primaryColor,
          focusNode: _emailNode,
          onFieldSubmitted: (value) {
            _emailNode.unfocus();
            _passwordNode.requestFocus();
          },
          decoration: InputDecoration(
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(5.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(5.0),
            ),
            filled: true,
            fillColor: backGroundColor,
            contentPadding: const EdgeInsets.all(15.0),
            border: InputBorder.none,
            hintText: 'example@gmail.com',
            hintStyle: TextStyle(color: hintColor, fontSize: 15),
          ),
          validator: (String? value) {
            if (value == "") {
              return "Field is required";
            } else if (!GetUtils.isEmail(value!)) {
              return 'Please enter a valid email';
            } else {
              return null;
            }
          },
          onChanged: (String value) {
            _loginData.addAll({'address': value});
          },
        ),
      ),
    );
  }

  Widget _passwordFieldWidget() {
    return Obx(() {
      return Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: TextFormField(
            style: const TextStyle(color: fontColor),
            cursorColor: primaryColor,
            focusNode: _passwordNode,
            onFieldSubmitted: (value) {
              _passwordNode.unfocus();
            },
            decoration: InputDecoration(
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(5.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(5.0),
              ),
              filled: true,
              fillColor: backGroundColor,
              contentPadding: const EdgeInsets.all(15),
              border: InputBorder.none,
              hintText: '********',
              hintStyle: TextStyle(color: hintColor, fontSize: 15),
              suffixIcon: InkWell(
                child: Icon(
                  controller.icon,
                  color: hintColor,
                ),
                onTap: () {
                  if (controller.obscureText.value) {
                    controller.obscureText.value = false;
                    controller.icon = Icons.visibility_off;
                  } else {
                    controller.obscureText.value = true;
                    controller.icon = Icons.visibility;
                  }
                },
              ),
            ),
            keyboardType: TextInputType.visiblePassword,
            obscureText: controller.obscureText.value,
            validator: (String? value) {
              if (value == "") {
                return "Password is required";
              } else {
                return null;
              }
            },
            onChanged: (String? value) {
              _loginData.addAll({'password': value.toString()});
            },
          ),
        ),
      );
    });
  }

  void _submitDataMethod(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      controller.loginPostMethod(loginData: _loginData);
    }
  }
}
