// // splash.dart
// import 'dart:async';
// import 'package:cobaaja/Screen/pages/profil.dart';
// import 'package:cobaaja/service/user.dart';
// import 'package:flutter/material.dart';
// import 'login.dart';

// class Home extends StatefulWidget {
//   Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: User.checkToken(),
//       builder: (context, snapshot) {

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Scaffold(
//             backgroundColor: Colors.blue[300],
//             body: Stack(
//               children: [
//                 Container(
//                   width: double.infinity,
//                   height: double.infinity,
//                   color: Color(0xFF96B8FA),
//                 ),

//                 Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         width: 200,
//                         height: 100,
//                         child: Image.asset(
//                           'pic/CCLogo.png',
//                           width: 250,
//                           height: 250,
//                           fit: BoxFit.contain,
//                         ),
//                       ),

//                       SizedBox(
//                         width: 80,
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(10),
//                           child: LinearProgressIndicator(
//                             valueColor: AlwaysStoppedAnimation<Color>(
//                               Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         } else {

//           if (snapshot.hasData) {

//           // active token found
//           if (snapshot.data!) {
//             WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilPage(),));
//           },); 
//           } else {
//             WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
//             },);
//           }
//         } 
//       return SizedBox.shrink();
//       }
//       }
//     );
//   }

// }
