import 'package:zwappr/features/feed/repository/favorite_repository.dart';
import 'package:zwappr/features/feed/services/i_favorite_service.dart';

class FavoriteService implements IFavoriteService{
  final FavoriteRepository _repository = FavoriteRepository();

  @override
  Future<void> create(String thingId) async => _repository.create(thingId);
}