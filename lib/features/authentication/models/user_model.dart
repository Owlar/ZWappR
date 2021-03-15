// Can't be named 'User' because User is already defined in Firebase auth.
class UserModel {
  // Unique identifier
  final String uid;
  final String displayName;
  String imageID;

  UserModel({
    this.uid,
    this.displayName,
    this.imageID
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        uid: json['uid'],
        displayName: json['displayName'],
        imageID: json['imageID']
    );
  }
}
