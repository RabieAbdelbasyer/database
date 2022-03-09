class UserModel {
  late String id;
  late String fullName;
  late String mobile;
  late String email;
  late bool isAdmin;

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['FullName'];
    mobile = json['Mobile'];
    email = json['email'];
    isAdmin = json['is_admin'] ?? false;
  }
}
