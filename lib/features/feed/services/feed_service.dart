import 'package:zwappr/features/feed/repository/feed_repository.dart';
import 'package:zwappr/features/feed/services/i_feed_service.dart';
import 'package:zwappr/features/things/models/thing_model.dart';

class FeedService implements IFeedService {
  final FeedRepository _feedRepository = FeedRepository();

  @override
  Future<List<ThingModel>> getAll() async => _feedRepository.getAll();

  @override
  Future<List<ThingModel>> getAllOfMyOwn() async => _feedRepository.getAllOfMyOwn();

  @override
  Future<void> delete(String uid) async => _feedRepository.delete(uid);
}