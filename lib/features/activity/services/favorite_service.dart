import 'package:zwappr/features/activity/repository/favorite_repository.dart';
import 'package:zwappr/features/activity/services/i_favorite_service.dart';
import 'package:zwappr/features/things/models/thing_model.dart';

class FavoriteService implements IFavoriteService{

  final FavoriteRepository _repository = FavoriteRepository();

  @override
  Future<void> create(String thingId) async => _repository.create(thingId);

  @override
  Future<Map> getMe() {
    // TODO: implement getMe
    throw UnimplementedError();
  }
  @override
  Future<List<ThingModel>> getAll() async => _repository.getAll();
  @override
  Future<void> put(String uid) {
    // TODO: implement put
    throw UnimplementedError();
  }
}