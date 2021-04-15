import 'package:zwappr/features/authentication/models/user_model.dart';
import 'package:zwappr/features/profile/repository/like_repository.dart';
import 'package:zwappr/features/profile/repository/profile_repository.dart';
import 'package:zwappr/features/profile/services/i_like_service.dart';
import 'package:zwappr/features/profile/services/i_profile_service.dart';
import 'package:zwappr/features/things/models/thing_model.dart';

class LikeService implements ILikeService {
  final LikeRepository _repository = LikeRepository();
  @override
  Future<List<ThingModel>> getAll() async => _repository.getAll();


  @override
  Future<Map> get() async => _repository.get();

  @override
  Future<void> create(String thingId) async => _repository.create(thingId);
}