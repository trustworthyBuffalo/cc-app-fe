import 'package:cobaaja/screen_v2/feed_loader.dart';
import 'package:cobaaja/service/feed_service.dart';
import 'package:flutter/material.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: ThreadService.getAllThread(),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            if (snapshot.data!.data == null) {}

            if (snapshot.data!.isSuccess) {
              return FeedLoader(threads: snapshot.data!.data);
            } else {
              return Center(child: Text("can't receive feed"));
            }
          }

          return SizedBox.shrink();
        },
      ),
    );
  }
}
