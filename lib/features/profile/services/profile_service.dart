import 'package:zwappr/features/authentication/models/user_model.dart';
import 'package:zwappr/features/profile/repository/profile_repository.dart';
import 'package:zwappr/features/profile/services/i_profile_service.dart';

class ProfileService implements IProfileService {
  final ProfileRepository _repository = ProfileRepository();

  @override
  Future<void> put(String uid) async => _repository.put(uid);

  @override
  Future<UserModel> get() async => _repository.get();

}
