import 'package:cobaaja/model/thread.dart';
import 'package:flutter/material.dart';

class ThreadWidget extends StatelessWidget {
  const ThreadWidget({super.key, required this.t});

  final Thread t;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  CircleAvatar(child: Text(t.user.name[0].toUpperCase())),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text(t.user.name),
                        Text(
                          t.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Row(
          spacing: 5,
          children: [
            ElevatedButton(onPressed: () {}, child: Icon(Icons.thumb_up)),
            ElevatedButton(
              onPressed: () {},
              child: Row(
                spacing: 5,
                children: [Icon(Icons.people), Text("posts")],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
