import 'package:feedback_app/features/feedback/feedback_screen.dart';
import 'package:feedback_app/features/auth/auth_service.dart';
import 'package:feedback_app/utils/service_locator.dart';
import 'package:feedback_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var secretController = TextEditingController();
  FirebaseAuth auth;
  @override
  void initState() {
    initializeFirebase();
    auth = FirebaseAuth.instance;
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    secretController.dispose();
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
                      'Sign Up', Colors.black, 20, FontWeight.bold, null)),
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
                height: 10,
              ),
              customText('Secret', Colors.black54, 14, FontWeight.normal, null),
              SizedBox(
                height: 10,
              ),
              customTextBox('', secretController, TextInputType.text),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.center,
                child: customButton(
                    context, MediaQuery.of(context).size.width, 'Sign Up', () {
                  signUpUser(emailController.text, passwordController.text,
                      secretController.text);
                }),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.center,
                child: customText(
                    'By clicking on "Sign Up" button, you are creating an account, and you agree to the terms of use.',
                    Colors.black38,
                    13,
                    FontWeight.normal,
                    null),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customText('Already have an account?', Colors.black, 15,
                  FontWeight.normal, null),
              SizedBox(
                width: 4,
              ),
              customText('Sign in', Colors.blue, 15, FontWeight.normal, null),
            ],
          ),
        ),
      ),
    );
  }

  void signUpUser(String email, String password, String secretcode) async {
    var res =
        await getIt.get<AuthService>().signUpUser(email, password, secretcode);
    if (res == '' || res == null) {
      EasyLoading.dismiss();
      sendToScreenTwo(context, FeedbackScreen());
    } else {
      showToast(res);
    }
  }
}
