import 'package:zwappr/features/activity/models/chat_users.dart';
import 'package:zwappr/features/activity/repository/chat_repository.dart';
import 'package:zwappr/features/activity/services/i_chat_service.dart';

class ChatService implements IChatService {

  final ChatRepository _repository = ChatRepository();


  @override
  Future<void> put(String uid) async => _repository.put(uid);

  @override
  Future<Map> get() async => _repository.get();

  @override
  Future<void> create(String userId) async => _repository.create(userId);

  @override
  Future<void> createMsg(String convId, String msg) async => _repository.createMsg(convId, msg);







}
