class MessageModel {
  String message;
  String dateSend;
  String dateRead;
  String sendTo;
  String type;
  bool read;
  MessageModel({
    required this.dateRead,
    required this.message,
    required this.dateSend,
    required this.sendTo,
    required this.type,
    required this.read,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      dateRead: json["dateRead"],
      message: json["message"],
      dateSend: json["dateSend"],
      sendTo: json["sendTo"],
      type: json["type"],
      read: json["read"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "dateSend": dateSend,
      "dateRead": dateRead,
      "sendTo": sendTo,
      "type": type,
      "read": read,
    };
  }
}
