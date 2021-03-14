import 'package:zwappr/features/activity/models/chat_users.dart';

abstract class IChatService {

  // Creating a thing with:
  /// [Create conversation]
  Future<void> create(String userId);
  Future<void> createMsg(String convoId, String msg);
  // Listing all things


  // Updating a thing with:
  /// [uid]
  Future<void> put(String uid);

  // Deleting a thing with:
  /// [uid]


  // Getting a thing with:
  /// [uid]
  Future<Map> get();

}