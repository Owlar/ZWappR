import 'package:zwappr/features/feed/repository/feed_repository.dart';
import 'package:zwappr/features/feed/services/i_feed_service.dart';

class FeedService implements IFeedService {
  final FeedRepository _feedRepository = FeedRepository();

  @override
  Future<void> getAll(String userUid) async => _feedRepository.getAll(userUid);
}