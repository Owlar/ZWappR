import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zwappr/features/feed/models/thing.dart';

class FeedRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> getAll(String userUid) async {
    await _db.collection("users").doc(userUid).collection("things").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
      });
    });
  }

}