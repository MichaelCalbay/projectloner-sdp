import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final String text;
  final bool value;
  final Function(bool?)? onChanged;

  const CustomCheckbox({
    Key? key,
    required this.text,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
        Text(
          text,
          style: const TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

// class CustomCheckbox extends StatelessWidget {
//   final TabController tabController;
//   final String text;
//   const CustomCheckbox({
//     Key? key,
//     required this.tabController,
//     required this.text,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Checkbox(
//           value: false,
//           onChanged: (bool? newValue) {},
//         ),
//         Text(
//           text,
//           style: const TextStyle(
//               fontSize: 12,
//               fontStyle: FontStyle.italic,
//               fontWeight: FontWeight.bold),
//         ),
//       ],
//     );
//   }
// }
