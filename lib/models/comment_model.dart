class CommentModel {
  late String comment;
  late String name;
  late String date;
  CommentModel.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
    name = json['name'];
    date = json['date'];
  }
  CommentModel({
    required this.comment,
    required this.date,
    required this.name,
  });
  Map<String, dynamic> toMap() {
    return {
      'comment': comment,
      'name': name,
      'date': date,
    };
  }
}
