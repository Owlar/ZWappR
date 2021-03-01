

import 'package:zwappr/features/feed/models/thing.dart';

abstract class IFeedService {

  // Getting all things in feed for user with:
  /// [userUid]
  Future<List<Thing>> getAll(String userUid) async => getAll(userUid);

}