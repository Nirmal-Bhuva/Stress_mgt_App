import 'package:flutter/material.dart';
import '../themes/colors.dart';

class MyButton extends StatelessWidget {
  final String text;
  final void Function ()? onTap;

  const MyButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.065),
        width: MediaQuery.of(context).size.width * 0.95,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
                letterSpacing: 5.0,
              ),
            ),
            const SizedBox(width: 10,),
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import '../themes/colors.dart';
//
// class MyButton extends StatelessWidget {
//   final String text;
//   final void Function ()? onTap;
//
//   const MyButton({
//     super.key,
//     required this.text,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           color: secondaryColor,
//           // color: const Color.fromARGB(212, 135, 81, 77),
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.elliptical(30, 30),
//             topRight: Radius.elliptical(30, 30),
//           ),
//         ),
//         padding: const EdgeInsets.all(30),
//         width: 380,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Text
//             Text(
//               text,
//               style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 25,
//                 letterSpacing: 10,
//               ),
//             ),
//             const SizedBox(width: 10,),
//           ],
//         ),
//       ),
//     );
//   }
// }