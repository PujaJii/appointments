// import 'package:dm_app/auth_service.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class DemoHome extends StatefulWidget {
//   const DemoHome({Key? key}) : super(key: key);
//
//   @override
//   State<DemoHome> createState() => _DemoHomeState();
// }
//
// class _DemoHomeState extends State<DemoHome> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(FirebaseAuth.instance.currentUser!.displayName!),
//             Text(FirebaseAuth.instance.currentUser!.email!),
//             ElevatedButton(onPressed: (){
//               AuthService().signOut();
//             }, child: const Text('Logout'))
//           ],
//         ),
//       ),
//     );
//   }
// }
