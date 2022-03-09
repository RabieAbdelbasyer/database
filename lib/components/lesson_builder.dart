// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masterapplication/components/navigate.dart';
import 'package:masterapplication/layouts/lesson_screen/lesson_screen.dart';
import 'package:masterapplication/models/lesson_model.dart';
import 'package:masterapplication/models/user_model.dart';

Widget lessonBuilder(context, LessonModel model, UserModel name) {
  return Card(
    elevation: 10,
    child: Directionality(
      textDirection: TextDirection.rtl,
      child: InkWell(
        onTap: () {
          navigateTo(context, LessonScreen(model, name));
        },
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Container(
            height: 70,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Image.network(
                    model.image!,
                    height: 70,
                    width: 70,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.title!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 15),
                      child: Text(
                        model.text!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
