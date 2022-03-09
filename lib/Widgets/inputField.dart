// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputFieldWithText extends StatefulWidget {
  InputFieldWithText(
      {Key? key,
      required this.text,
      this.readOnly = false,
      required this.controller,
      this.multiLines = false,
      this.keyboard})
      : super(key: key);
  final String text;
  final bool readOnly;
  final multiLines;
  final TextInputType? keyboard;
  final TextEditingController controller;
  @override
  _InputFieldWithTextState createState() => _InputFieldWithTextState();
}

class _InputFieldWithTextState extends State<InputFieldWithText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.controller,
              readOnly: widget.readOnly,
              style: TextStyle(fontSize: 24),
              maxLines: widget.multiLines ? null : 1,
              keyboardType: widget.keyboard == null
                  ? widget.multiLines
                      ? TextInputType.multiline
                      : TextInputType.text
                  : widget.keyboard,
              decoration: InputDecoration(
                labelText: widget.text,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightBlueAccent),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
