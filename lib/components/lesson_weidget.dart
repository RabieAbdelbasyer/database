import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masterapplication/models/lesson_model.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

Widget lessonWidget(LessonModel lessonModel) {
  if (lessonModel.text != null)
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Text(
        lessonModel.text!,
        style: TextStyle(fontSize: 20),
      ),
    );
  else if (lessonModel.bold != null)
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Text(
        lessonModel.bold!,
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  else if (lessonModel.divider != null)
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        color: Color(int.parse('0xff${lessonModel.divider!}')),
        height: 1,
        width: double.infinity,
      ),
    );
  else if (lessonModel.center != null)
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        child: Text(
          lessonModel.center!,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  else if (lessonModel.image != null)
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Image.network(lessonModel.image!),
    );
  else if (lessonModel.video != null) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: lessonModel.video!,
      params: YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: false,
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: YoutubePlayerIFrame(
        controller: _controller,
        aspectRatio: 16 / 9,
      ),
    );
  } else
    return Container(
      height: 0,
    );
}
