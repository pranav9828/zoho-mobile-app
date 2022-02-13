import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedback_app/components/custom_text_area.dart';
import 'package:feedback_app/features/auth/login_screen.dart';
import 'package:feedback_app/features/feedback/feedback_service.dart';
import 'package:feedback_app/utils/refresh_events.dart';
import 'package:feedback_app/utils/refresh_service.dart';
import 'package:feedback_app/utils/service_locator.dart';
import 'package:feedback_app/utils/shared_preference_utils.dart';
import 'package:feedback_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  var feedbackController = TextEditingController();
  FeedbackService feedbackService;
  @override
  void initState() {
    feedbackService = FeedbackService();
    initializeFirebase();
    getIt
        .get<RefreshService>()
        .eventBus
        .on<CreateCommentRefresh>()
        .listen((event) {
      feedbackService.refresh();
    });
    super.initState();
  }

  @override
  void dispose() {
    feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title:
            customText('Comments', Colors.white, 18, FontWeight.normal, null),
        centerTitle: true,
        elevation: 0.0,
        actions: [
          GestureDetector(
            onTap: () {
              logoutUser();
            },
            child: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 265,
                  padding: EdgeInsets.fromLTRB(15, 10, 10, 10),
                  child: CustomTextArea('Enter your Comment',
                      feedbackController, TextInputType.text),
                ),
                customButton(context, 87, 'Submit', () {
                  createComment(feedbackController.text);
                }),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 15, top: 5),
              child: customText(
                  'Comments', Colors.black, 18, FontWeight.bold, null),
            ),
            FutureBuilder(
              key: UniqueKey(),
              future: feedbackService.getComments(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print('snapshot error is ${snapshot.error}');
                  return const Text(
                    "Something went wrong",
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  var dataList = snapshot.data as List;
                  if (dataList.isEmpty) {
                    return Center(
                      child: customText('No Comments found', Colors.black, 16,
                          FontWeight.normal, null),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: dataList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(top: 15),
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          color: Colors.blue[50],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.account_circle_rounded,
                                    color: Colors.black,
                                    size: 50,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  customText(
                                      dataList[index]['email'],
                                      Colors.black,
                                      16,
                                      FontWeight.normal,
                                      null),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: customText(dataList[index]['comment'],
                                    Colors.black, 16, FontWeight.normal, null),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }

  void createComment(String comment) async {
    var response = await getIt.get<FeedbackService>().createComment(comment);
    feedbackController.text = '';
    getIt.get<RefreshService>().eventBus.fire(CreateCommentRefresh());
    if (response != '') {
      showToast(response);
    }
  }

  void logoutUser() {
    showAlert(
        context, 'Logout', 'Are you sure you want to logout?', 'No', 'Yes', () {
      logout();
    });
  }

  void logout() async {
    var documentId = await getIt.get<SharedPreferenceUtils>().getDocumentId();
    FirebaseFirestore.instance
        .collection('users')
        .doc(documentId)
        .update({"islogin": "0"});

    await FirebaseAuth.instance.signOut();
    sendToScreenTwo(context, LoginScreen());
  }
}
