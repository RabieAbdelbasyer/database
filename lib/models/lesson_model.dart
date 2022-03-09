class LessonModel {
  String? title;
  String? text;
  String? image;
  String? type;
  String? lessonId;
  String? center;
  String? video;
  String? bold;
  String? divider;
  int? order;
  LessonModel.fromJson(this.lessonId, Map<String, dynamic> json) {
    title = json['title'];
    text = json['text'];
    image = json['image'];
    type = json['type'];
    center = json['center'];
    video = json['video'];
    bold = json['bold'];
    order = json['order'];
    divider = json['divider'];
  }
  LessonModel({
    this.lessonId,
    this.order,
    this.text,
    this.center,
    this.bold,
    this.title,
    this.video,
    this.image,
    this.type,
    this.divider,
  });
  Map<String, dynamic> toMap() {
    return {
      'lessonId': lessonId,
      'order': order,
      'text': text,
      'center': center,
      'bold': bold,
      'title': title,
      'video': video,
      'image': image,
      'type': type,
      'divider': divider,
    };
  }
}
