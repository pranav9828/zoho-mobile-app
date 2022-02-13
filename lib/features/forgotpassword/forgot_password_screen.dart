import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedback_app/utils/service_locator.dart';
import 'package:feedback_app/utils/shared_preference_utils.dart';
import 'package:feedback_app/utils/utils.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  var emailController = TextEditingController();
  var secretController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  void dispose() {
    emailController.dispose();
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
                  child: customText('Forgot Password', Colors.black, 20,
                      FontWeight.bold, null)),
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
                child: customButton(context, MediaQuery.of(context).size.width,
                    'Forgot Password', () {
                  setState(() {
                    isPasswordVisible = true;
                  });
                }),
              ),
              SizedBox(
                height: 50,
              ),
              FutureBuilder<String>(
                future: getIt.get<SharedPreferenceUtils>().getDocumentId(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Container();
                  } else {
                    if (snapshot.hasData) {
                      return Visibility(
                        visible: isPasswordVisible ? true : false,
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .doc(snapshot.data)
                              .snapshots(),
                          builder: (context, sp) {
                            if (!sp.hasData) {
                              return Container();
                            }
                            var userDocument = sp.data;
                            return Container(
                              alignment: Alignment.center,
                              child: customText(
                                  'Your Password is ${userDocument["password"]}',
                                  Colors.black,
                                  16,
                                  FontWeight.normal,
                                  null),
                            );
                          },
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
