class UserModel {
  String name;
  String status;
  String image;
  String token;
  UserModel({
    required this.image,
    required this.name,
    required this.status,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        image: json["image"],
        name: json["name"],
        status: json["status"],
        token: json["token"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "status": status,
      "image": image,
      "token": token,
    };
  }
}
