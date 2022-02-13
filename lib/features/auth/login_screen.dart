import 'package:feedback_app/features/auth/auth_service.dart';
import 'package:feedback_app/features/feedback/feedback_screen.dart';
import 'package:feedback_app/features/forgotpassword/forgot_password_screen.dart';
import 'package:feedback_app/features/auth/signup_screen.dart';
import 'package:feedback_app/utils/service_locator.dart';
import 'package:feedback_app/utils/utils.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void initState() {
    initializeFirebase();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 130,
              ),
              Align(
                  alignment: Alignment.center,
                  child: customText(
                      'Sign In', Colors.black, 20, FontWeight.bold, null)),
              SizedBox(
                height: 50,
              ),
              customText('Email', Colors.black54, 14, FontWeight.normal, null),
              SizedBox(
                height: 10,
              ),
              customTextBox('', emailController, TextInputType.emailAddress),
              SizedBox(
                height: 20,
              ),
              customText(
                  'Password', Colors.black54, 14, FontWeight.normal, null),
              SizedBox(
                height: 10,
              ),
              customTextBox('', passwordController, TextInputType.text),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  sendToScreen(context, ForgotPasswordScreen());
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: customText('Forgot your Password?', Colors.black54, 14,
                      FontWeight.normal, null),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.center,
                child: customButton(
                    context, MediaQuery.of(context).size.width, 'Sign In', () {
                  loginUser(emailController.text, passwordController.text);
                }),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          sendToScreen(context, SignupScreen());
        },
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customText('Dont have an account?', Colors.black, 15,
                  FontWeight.normal, null),
              SizedBox(
                width: 4,
              ),
              customText('Sign up', Colors.blue, 15, FontWeight.normal, null),
            ],
          ),
        ),
      ),
    );
  }

  void loginUser(String email, String password) async {
    var res = await getIt.get<AuthService>().loginUser(email, password);
    if (res == '') {
      sendToScreenTwo(context, FeedbackScreen());
    } else {
      showToast(res);
    }
  }
}
