import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jiffy/jiffy.dart';

Widget assetImageView(String path, double width, double height) {
  return Image(
    image: AssetImage(path),
    width: width,
    height: height,
  );
}

Widget networkImageView(String path, double width, double height) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(14),
    child: Image(
      image: NetworkImage(path),
      width: width,
      height: height,
      fit: BoxFit.contain,
    ),
  );
}

Widget assetAvatarView(String path) {
  return CircleAvatar(
    radius: 19.0,
    backgroundImage: AssetImage(path),
    backgroundColor: Colors.transparent,
  );
}

Widget networkAvatarView(String path) {
  return CircleAvatar(
    radius: 19.0,
    backgroundImage: NetworkImage(path),
    backgroundColor: Colors.transparent,
  );
}

Widget customText(String text, Color color, double fontSize,
    FontWeight fontWeight, TextAlign textAlign) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    ),
    textAlign: textAlign,
  );
}

void sendToScreen(BuildContext context, Widget screen) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => screen),
  );
}

void sendToScreenTwo(BuildContext context, Widget screen) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => screen),
    (Route<dynamic> route) => false,
  );
}

Widget customButton(
    BuildContext context, double width, String text, Function callback) {
  return InkWell(
    onTap: () {
      callback.call();
    },
    child: Container(
      width: width,
      padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(7),
      ),
      child: customText(
          text, Colors.white, 16, FontWeight.normal, TextAlign.center),
    ),
  );
}

void showToast(String text) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0);
}

Widget customTextBox(String hintText,
    TextEditingController textEditingController, TextInputType textInputType) {
  return TextField(
    controller: textEditingController,
    style: TextStyle(
      color: Colors.black,
    ),
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      focusedBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      filled: true,
      fillColor: Colors.grey[200],
      enabledBorder: InputBorder.none,
      hintText: hintText,
      hintStyle: TextStyle(
        color: Colors.black38,
        fontSize: 15,
      ),
    ),
    keyboardType: textInputType,
  );
}

Widget searchBox(String hintText, TextEditingController textEditingController,
    TextInputType textInputType, Function callback) {
  return TextField(
    controller: textEditingController,
    style: TextStyle(
      color: Colors.white,
    ),
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      focusedBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      filled: true,
      hintText: hintText,
      suffixIcon: GestureDetector(
        onTap: () {
          callback.call();
        },
        child: Icon(
          Icons.search,
          color: Colors.white,
        ),
      ),
      hintStyle: TextStyle(
        color: Colors.white30,
        fontSize: 15,
      ),
    ),
    keyboardType: textInputType,
  );
}

Widget getDateWidget(String createdTime) {
  var createdDateTime = DateTime.parse(createdTime);
  var localTime = createdDateTime.toLocal();
  var timeAgo = Jiffy(localTime).fromNow();
  return customText(timeAgo, Colors.white60, 15, FontWeight.normal, null);
}

void showAlert(BuildContext context, String heading, String subHeading,
    String button1, String button2, Function callBack) async {
  var alertDialog = AlertDialog(
    backgroundColor: Colors.white,
    title: Text(
      heading,
      style: TextStyle(
        color: Colors.black,
      ),
    ),
    content: Text(
      subHeading,
      style: TextStyle(
        color: Colors.black,
      ),
    ),
    actions: <Widget>[
      FlatButton(
        child: Text(
          button1,
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      FlatButton(
        child: Text(
          button2,
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop();
          callBack.call();
        },
      ),
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alertDialog;
    },
  );
}

void initializeFirebase() async {
  await Firebase.initializeApp();
}
