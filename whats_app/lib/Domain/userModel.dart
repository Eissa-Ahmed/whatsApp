class UserModel {
  String name;
  String status;
  String image;
  String token;
  String lastActive;
  String lastMessage;
  bool active;
  String phone;

  UserModel({
    required this.image,
    required this.name,
    required this.status,
    required this.token,
    required this.active,
    required this.lastActive,
    required this.lastMessage,
    required this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        image: json["image"],
        name: json["name"],
        status: json["status"],
        active: json["active"],
        lastActive: json["lastActive"],
        lastMessage: json["lastMessage"],
        phone: json["phone"],
        token: json["token"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "status": status,
      "image": image,
      "token": token,
      "lastMessage": lastMessage,
      "lastActive": lastActive,
      "active": active,
      "phone": phone,
    };
  }
}
