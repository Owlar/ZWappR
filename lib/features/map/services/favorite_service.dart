import 'package:zwappr/features/map/repository/favorite_repository.dart';
import 'package:zwappr/features/map/services/i_favorite_service.dart';

class FavoriteService implements IFavoriteService {

  final FavoriteRepository _repository = FavoriteRepository();

  @override
  Future<void> create(String thingId) async => _repository.create(thingId);

  @override
  Future<void> delete(String thingId) async => _repository.delete(thingId);
}