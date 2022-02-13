import 'package:flutter/material.dart';

class CustomTextArea extends StatefulWidget {
  String hintText;
  TextEditingController textEditingController;
  TextInputType textInputType;
  CustomTextArea(this.hintText, this.textEditingController, this.textInputType);
  @override
  _CustomTextAreaState createState() => _CustomTextAreaState();
}

class _CustomTextAreaState extends State<CustomTextArea> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textEditingController,
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
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Colors.black38,
          fontSize: 15,
        ),
      ),
      keyboardType: widget.textInputType,
      maxLines: 5,
    );
  }
}
