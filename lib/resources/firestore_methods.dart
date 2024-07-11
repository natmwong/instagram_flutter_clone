import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_flutter/models/post.dart';
import 'package:instagram_flutter/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Uploads a post to Firestore.
  ///
  /// Parameters:
  /// - [description]: The description of the post.
  /// - [file]: The image file of the post.
  /// - [uid]: The user ID of the post creator.
  /// - [username]: The username of the post creator.
  /// - [profImage]: The profile image URL of the post creator.
  ///
  /// Returns:
  /// - A [Future] that completes with a [String] indicating the result of the upload.
  ///   - If the upload is successful, the [String] will be "success".
  ///   - If an error occurs, the [String] will contain the error message.
  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profImage,
  ) async {
    String res = "some error occurred";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);

      String postId = const Uuid().v1();
      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profImage: profImage,
        likes: [],
      );

      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  /// Likes or unlikes a post.
  ///
  /// Parameters:
  /// - [postId]: The ID of the post.
  /// - [uid]: The user ID of the liker.
  /// - [likes]: The list of user IDs who have liked the post.
  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }

  /// Posts a comment on a post.
  ///
  /// Parameters:
  /// - [postId]: The ID of the post.
  /// - [text]: The text of the comment.
  /// - [uid]: The user ID of the commenter.
  /// - [name]: The name of the commenter.
  /// - [profilePic]: The profile picture URL of the commenter.
  Future<void> postComment(String postId, String text, String uid, String name,
      String profilePic) async {
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'name': name,
          'postId': postId,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
          'likes': [],
        });
      } else {
        print('Text is empty');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  /// Likes or unlikes a comment.
  ///
  /// Parameters:
  /// - [postId]: The ID of the post.
  /// - [commentId]: The ID of the comment.
  /// - [uid]: The user ID of the liker.
  /// - [likes]: The list of user IDs who have liked the comment.
  Future<void> likeComment(String postId, String commentId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).collection('comments').doc(commentId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('posts').doc(postId).collection('comments').doc(commentId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }

  /// Deletes a post.
  ///
  /// Parameters:
  /// - [postId]: The ID of the post to delete.
  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (err) {
      print(err.toString());
    }
  }

  /// Follows or unfollows a user based on the provided user ID and follow ID.
  ///
  /// If the user is already following the specified follow ID, this function will unfollow the user.
  /// Otherwise, it will follow the user.
  ///
  /// Parameters:
  /// - [uid]: The user ID of the current user.
  /// - [followId]: The user ID of the user to follow/unfollow.
  Future<void> followUser(
    String uid,
    String followId,
  ) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
