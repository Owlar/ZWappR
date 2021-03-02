import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zwappr/features/feed/models/thing.dart';

class FeedRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Thing>> getAll(String userUid) async {
    List<Thing> things = List();
    await _db.collection("users").doc(userUid).collection("things").get().then((querySnapshot) {
      querySnapshot.docs.forEach((res)  {
        final Map<String, dynamic> documentFields = res.data();
        final thing = Thing(
            uid: documentFields["uid"],
            title: documentFields["title"],
            description: documentFields["description"],
            numberOfLikes: documentFields["numberOfLikes"]
        );
        things.add(thing);
      });
    });
    return things;
  }

}