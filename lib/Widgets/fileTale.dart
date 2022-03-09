import 'package:flutter/material.dart';
import 'package:masterapplication/models/file_model.dart';
import 'package:url_launcher/url_launcher.dart';

Widget fileTale(FileModel fileModel) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(Icons.file_copy),
        SizedBox(width: 5),
        Expanded(
          child: InkWell(
            onTap: () async {
              if (fileModel.downloadLink != null) {
                await canLaunch(fileModel.downloadLink!)
                    ? await launch(fileModel.downloadLink!)
                    : print('error');
              }
            },
            child: Text(
              fileModel.fileName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        if (fileModel.isUploading)
          Container(
            child: CircularProgressIndicator(),
            width: 22,
            height: 22,
          ),
      ],
    ),
  );
}
