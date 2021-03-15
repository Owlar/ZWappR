// Can't be named 'User' because User is already defined in Firebase auth.
class UserModel {
  // Unique identifier
  final String uid;
  final String displayName;
  String imageId;

  UserModel({
    this.uid,
    this.displayName,
    this.imageId
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        uid: json['uid'],
        displayName: json['displayName']
    );
  }
}
