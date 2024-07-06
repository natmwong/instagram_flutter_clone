import "package:flutter/material.dart";
import "package:instagram_flutter/models/user.dart";
import "package:instagram_flutter/providers/user_provider.dart";
import "package:instagram_flutter/resources/firestore_methods.dart";
import "package:instagram_flutter/utils/colors.dart";
import "package:instagram_flutter/widgets/comment_card.dart";
import "package:provider/provider.dart";

class CommentsScreen extends StatefulWidget {
  final snap;
  const CommentsScreen({super.key, required this.snap});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: const Text('Comments'),
          centerTitle: false,
        ),
        body: CommentCard(),
        bottomNavigationBar: SafeArea(
            child: Container(
          height: kToolbarHeight,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user.photoUrl),
                radius: 18,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Comment as ${user.username}',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              InkWell(
                  onTap: () async {
                    await FirestoreMethods().postComment(
                      widget.snap['postId'],
                      _commentController.text,
                      user.uid,
                      user.username,
                      user.photoUrl,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 8,
                    ),
                    child: const Text(
                      'Post',
                      style: TextStyle(
                        color: blueColor,
                      ),
                    ),
                  ))
            ],
          ),
        )));
  }
}
