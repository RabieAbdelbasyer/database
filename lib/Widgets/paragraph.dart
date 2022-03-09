import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:masterapplication/Widgets/inputField.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Paragraph extends StatefulWidget {
  Paragraph({Key? key, this.onClick}) : super(key: key);
  final List<String> list = [
    'text',
    'bold',
    'center',
    'image',
    'video',
    'divider'
  ];
  int index = 0;
  final TextEditingController controller = TextEditingController();
  String getSelected() => list[index];
  String? getValue() => controller.text.trim().isEmpty ? null : controller.text;
  Function? onClick;

  @override
  State<Paragraph> createState() => _ParagraphState();
}

class _ParagraphState extends State<Paragraph> {
  bool isUploading = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          SizedBox(width: double.infinity),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 7,
            ),
            child: Row(
              children: [
                DropdownButton(
                  value: widget.index,
                  items: [
                    DropdownMenuItem(
                      child: Text(widget.list[0]),
                      value: 0,
                    ),
                    DropdownMenuItem(
                      child: Text(widget.list[1]),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Text(widget.list[2]),
                      value: 2,
                    ),
                    DropdownMenuItem(
                      child: Text(widget.list[3]),
                      value: 3,
                    ),
                    DropdownMenuItem(
                      child: Text(widget.list[4]),
                      value: 4,
                    ),
                    DropdownMenuItem(
                      child: Text(widget.list[5]),
                      value: 5,
                    ),
                  ],
                  onChanged: (int? value) {
                    setState(() {
                      if ((value == 3 &&
                              widget.index != 4 &&
                              widget.index != 5) ||
                          (value == 4 &&
                              widget.index != 3 &&
                              widget.index != 5) ||
                          (value == 5 &&
                              widget.index != 4 &&
                              widget.index != 3)) widget.controller.clear();

                      widget.index = value ?? 0;
                    });
                  },
                ),
                Spacer(),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Icon(
                    FontAwesomeIcons.trash,
                    color: Colors.red,
                  ),
                  onTap: () =>
                      widget.onClick == null ? () {} : widget.onClick!(),
                )
              ],
            ),
          ),
          Row(
            children: [
              if (widget.getSelected() == 'image')
                TextButton(
                  onPressed: () async {
                    final ImagePicker _picker = ImagePicker();
                    final XFile? image =
                        await _picker.pickImage(source: ImageSource.gallery);
                    setState(() {
                      isUploading = true;
                    });
                    if (image != null) {
                      firebase_storage.FirebaseStorage firebaseStorage =
                          firebase_storage.FirebaseStorage.instance;
                      await firebaseStorage
                          .ref()
                          .child(
                              '/images/${Uri.file(image.path).pathSegments.last}')
                          .putFile(File(image.path))
                          .then((value) {
                        value.ref.getDownloadURL().then((value) {
                          setState(() {
                            widget.controller.text = value;
                            isUploading = false;
                          });
                        });
                      });
                    } else {
                      setState(() {
                        isUploading = false;
                      });
                    }
                  },
                  child: isUploading
                      ? CircularProgressIndicator()
                      : Icon(
                          Icons.image,
                          size: 30,
                        ),
                ),
              Expanded(
                child: InputFieldWithText(
                  text: '',
                  controller: widget.controller,
                  multiLines: !(widget.index == 3 || widget.index == 4),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
