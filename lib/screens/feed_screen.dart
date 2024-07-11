import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:instagram_flutter/utils/colors.dart";
import "package:instagram_flutter/widgets/post_card.dart";

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: SvgPicture.asset(
          'assets/ic_instagram.svg',
          colorFilter: ColorFilter.mode(primaryColor, BlendMode.srcIn),
          height: 32,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.messenger_outline),
          ),
        ],
      ),
      /// Builds the body of the feed screen with a stream builder that listens to changes in the 'posts' collection in Firestore.
      /// It displays a circular progress indicator while waiting for the connection state to change to 'waiting'.
      /// Once the connection state is no longer 'waiting', it builds a ListView using the data from the snapshot.
      /// Each item in the ListView is rendered using the PostCard widget, passing the data from the snapshot.
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) => PostCard(
              snap: snapshot.data!.docs[index].data(),
            ),
          );
        },
      ),
    );
  }
}
