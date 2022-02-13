import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceUtils {
  SharedPreferences _prefs;

  SharedPreferenceUtils() {
    init();
  }

  void init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void setId(String userId) async {
    await _prefs.setString(id, userId);
  }

  Future<String> getId() async {
    if (!_prefs.containsKey(id)) {
      return null;
    } else {
      var uid = _prefs.getString(id);
      return uid;
    }
  }

  void setDocumentId(String docid) async {
    await _prefs.setString(docId, docid);
  }

  Future<String> getDocumentId() async {
    if (!_prefs.containsKey(docId)) {
      return null;
    } else {
      var uid = _prefs.getString(docId);
      return uid;
    }
  }

  void setLoginStatus(String status) async {
    await _prefs.setString(isLogin, status);
  }

  Future<String> getLoginStatus() async {
    if (!_prefs.containsKey(isLogin)) {
      return null;
    } else {
      var status = _prefs.getString(isLogin);
      return status;
    }
  }
}

const String id = 'id';
const String docId = 'docId';
const String isLogin = 'isLogin';
