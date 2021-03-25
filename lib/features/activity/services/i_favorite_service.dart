import 'package:zwappr/features/things/models/thing_model.dart';

abstract class IFavoriteService {

  // Creating a conversation with:
  /// [userId]
  Future<void> create(String userId);
  // Creating a message with:
  /// [convoId]
  /// [msg]

  // Updating me as a user with:
  /// [uid]
  Future<void> put(String uid);

  // Getting a conversation

  Future<List<ThingModel>> getAll();
  // Getting a message with:
  /// [uid]

  // Getting me as a user
  Future<Map> getMe();


}