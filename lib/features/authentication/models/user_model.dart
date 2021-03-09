// Can't be named 'User' because User is already defined in Firebase auth.
class UserModel {
  // Unique identifier
  final String uid;
  final String displayName;

  UserModel(this.uid, this.displayName);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        json['uid'],
        json['displayName']
    );
  }
}
