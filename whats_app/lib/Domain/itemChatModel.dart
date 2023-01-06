class ItemChatModel {
  String name;
  String image;
  String lastMessage;
  String date;
  bool isActive;

  ItemChatModel({
    required this.date,
    required this.image,
    required this.isActive,
    required this.lastMessage,
    required this.name,
  });

  factory ItemChatModel.fromJson(Map<String, dynamic> json) {
    return ItemChatModel(
      date: json["date"],
      image: json["image"],
      isActive: json["isActive"],
      lastMessage: json["lastMessage"],
      name: json["name"],
    );
  }
}
