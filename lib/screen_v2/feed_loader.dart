import 'package:cobaaja/model/thread.dart';
import 'package:cobaaja/widget/thread_widget.dart';
import 'package:flutter/material.dart';

class FeedLoader extends StatelessWidget {
  const FeedLoader({super.key, required this.threads});

  final List<Thread> threads;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ...threads.map((t) {
          return ThreadWidget(t: t);
        }),
      ],
    );
  }
}
