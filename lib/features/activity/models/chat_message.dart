import 'package:flutter/cupertino.dart';

class ChatMessage {
  String messageContent;
  String messageType;
  String messageImage;

  ChatMessage({
    @required this.messageContent,
    @required this.messageType,
    this.messageImage
  });
}
