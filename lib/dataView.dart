// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:notepad/profile/const.dart';
// import 'package:notepad/profile/profile.dart';
//
// class DataPagaView extends StatelessWidget {
//   List currentItems;
//   DataPagaView({required this.currentItems});
//
//   @override
//   Widget build(BuildContext context) {
//     return  SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           actions: [
//             Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: IconButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => ProfilePage()),
//                   );
//                 },
//                 icon: Icon(Icons.info_outlined,color: Color(0xffffA8B2D1),),
//               ),
//             ),
//           ],
//           systemOverlayStyle: SystemUiOverlayStyle(
//             // Status bar color
//             statusBarColor: Color(0xff808080),
//
//             // Status bar brightness (optional)
//             statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
//             statusBarBrightness: Brightness.light, // For iOS (dark icons)
//           ),
//           backgroundColor: Color(0xff808080),
//           title: Text(
//             "Note Pad",
//             style: myStyle(24, Color(0xffffA8B2D1),FontWeight.bold),
//           ),
//           centerTitle: true,
//         ),
//         body: Container(
//           color: Colors.white,
//           child: ListTile(
//             title: Text(currentItems[""],style: TextStyle(color: Colors.red),),
//
//           )
//         ),
//       ),
//     );
//   }
// }
