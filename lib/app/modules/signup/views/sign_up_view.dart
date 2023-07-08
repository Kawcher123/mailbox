import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/contants.dart';
import '../../../reusable_widgets/common_widgets.dart';
import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  SignUpView({Key? key}) : super(key: key);

  final FocusNode _emailNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, String> _signUpData = {};

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
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        'Welcome Back to MailBox',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: width * 0.05),
                    const Text('Sign up with your valid mail'),
                    SizedBox(height: width * 0.2),
                    emailFieldWidget,
                    SizedBox(height: width * 0.05),
                    passwordFieldWidget,
                    SizedBox(height: width * 0.1),
                    GlobalWidgets.buttonWidget(
                        text: 'Signup',
                        press: () {
                          _submitData();
                        })
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Container get emailFieldWidget => Container(
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
              hintStyle:  TextStyle(color: hintColor, fontSize: 15),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (String? value) {
              if (value == "") {
                return "Email is required";
              } else if (!GetUtils.isEmail(value!)) {
                return 'Please enter a valid email';
              }
              return null;
            },
            onChanged: (String value) {
              _signUpData.addAll({'address': value});
            },
          ),
        ),
      );

  Obx get passwordFieldWidget => Obx(() {
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
                hintStyle:  TextStyle(color: hintColor, fontSize: 15),
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
                } else if (value!.length < 6) {
                  return "Password must be at least 6 characters";
                } else {
                  return null;
                }
              },
              onChanged: (String? value) {
                _signUpData.addAll({'password': value.toString()});
              },
            ),
          ),
        );
      });

  void _submitData() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      controller.signUpMethod(_signUpData);
    }
  }
}
