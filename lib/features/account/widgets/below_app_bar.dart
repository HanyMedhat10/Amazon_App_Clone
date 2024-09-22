import 'package:amazon_clone/constant/global_variable.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// class BelowAppBar extends StatelessWidget {
//   const BelowAppBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: GlobalVariables.appBarGradient,
//         //  LinearGradient(
//         //   colors: [
//         //     Color.fromARGB(255, 29, 201, 192),
//         //     Color.fromARGB(255, 125, 221, 216),
//         //   ],
//         // ),
//       ),
//       padding: const EdgeInsets.only(
//         left: 10,
//         right: 10,
//         bottom: 10,
//       ),
//       child: const Row(
//         children: [
//           SizedBox(
//             height: 40,
//             width: 40,
//             child: Icon(
//               Icons.location_on_outlined,
//             ),
//           ),
//           Expanded(
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: 'Search Amazon.in',
//                 hintStyle: TextStyle(
//                   color: Colors.white,
//                 ),
//                 enabledBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Colors.white,
//                   ),
//                 ),
//                 focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Colors.white,
//                   ),
//                 ),
//                 border: UnderlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 40,
//             width: 40,
//             child: Icon(
//               Icons.mic,
//             ),
//           ),
//         ],
//         // width: double.infinity,
//         // height: 1,
//         // color: Color.fromARGB(255, 29, 201, 192),
//       ),
//     );
//   }
// }

class BelowAppBar extends StatelessWidget {
  const BelowAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Container(
      decoration: const BoxDecoration(
        gradient: GlobalVariables.appBarGradient,
      ),
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              text: 'Hello, ',
              style: const TextStyle(
                fontSize: 22,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: user.name,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
