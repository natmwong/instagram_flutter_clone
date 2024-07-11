import 'package:cloud_firestore/cloud_firestore.dart';
/// Represents a user in the application.
class User {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String bio;
  final List followers;
  final List following;

  /// Constructs a new [User] instance.
  const User({
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.username,
    required this.bio,
    required this.followers,
    required this.following,
  });

  /// Converts the [User] object to a JSON representation.
  Map<String, dynamic> toJson() => {
        "email": email,
        "uid": uid,
        "photoUrl": photoUrl,
        "username": username,
        "bio": bio,
        "followers": followers,
        "following": following,
      };

  /// Creates a [User] object from a [DocumentSnapshot].
  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot['username'],
      uid: snapshot['uid'],
      email: snapshot['email'],
      photoUrl: snapshot['photoUrl'],
      bio: snapshot['bio'],
      followers: snapshot['followers'],
      following: snapshot['following'],
    );
  }
}
