import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedback_app/utils/service_locator.dart';
import 'package:feedback_app/utils/shared_preference_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AuthService {
  AuthService() {
    Firebase.initializeApp();
  }
  Future<String> signUpUser(
      String email, String password, String secretcode) async {
    try {
      EasyLoading.show(status: 'loading...');
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final User user = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      if (user != null) {
        User user = FirebaseAuth.instance.currentUser;
        var users =
            FirebaseFirestore.instance.collection('users').doc(user.uid);
        getIt.get<SharedPreferenceUtils>().setDocumentId(user.uid);
        users.set({
          'userid': user.uid,
          'email': email,
          'password': password,
          'secretcode': secretcode,
          'islogin': '1',
        });
        EasyLoading.dismiss();
        return '';
      }
    } catch (e) {
      EasyLoading.dismiss();
      return 'Failed to Sign up';
    }

    User user = FirebaseAuth.instance.currentUser;

    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  Future<String> loginUser(String email, String password) async {
    try {
      EasyLoading.show(status: 'loading...');
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final User user = (await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      if (user != null) {
        EasyLoading.dismiss();
        return '';
      }
    } catch (e) {
      EasyLoading.dismiss();
      return 'Failed to Sign in';
    }
  }
}
