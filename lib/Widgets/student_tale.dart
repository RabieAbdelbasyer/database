import 'package:flutter/material.dart';
import 'package:masterapplication/models/user_model.dart';

Widget studentTale(UserModel model, {required Function onClick}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      children: [
        Icon(Icons.person),
        SizedBox(width: 5),
        Expanded(
          child: InkWell(
            onTap: () => onClick(),
            child: Text(
              model.fullName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
