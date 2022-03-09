import 'package:flutter/material.dart';
import 'package:masterapplication/models/comment_model.dart';

Widget commentBubble(CommentModel commentModel) {
  return Align(
    alignment: AlignmentDirectional.topStart,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
      child: Material(
        elevation: 5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(20),
            topStart: Radius.circular(20),
            topEnd: Radius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(10),
          color: Color(0xFFE8F5FD),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                commentModel.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                commentModel.comment,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
