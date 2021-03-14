class ChatUsers {
  String name;
  String message;
  String image;
  String date;

  ChatUsers(this.name, this.message, this.image, this.date);

  factory ChatUsers.fromJson(Map<String, dynamic> json) {
    return ChatUsers(
        json['name'], json['message'], json['image'], json['date']);
  }
}

