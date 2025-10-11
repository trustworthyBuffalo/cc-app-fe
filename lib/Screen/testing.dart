import 'package:cobaaja/model/user.dart';
import 'package:flutter/material.dart';

class Testing extends StatelessWidget {
  const Testing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(onPressed: () async {
User.login("test", "test1234");

          }, child: Text("tekan"))
        ],
      ),
    );
  }
}