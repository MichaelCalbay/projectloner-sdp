import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final TabController tabController;
  final String text;
  const CustomCheckbox({
    Key? key,
    required this.tabController,
    required this.text,
  }) : super(key: key);

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool? value = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: (value) {
            setState(() {
              this.value = value;
            });
          },
        ),
        Text(
          widget.text,
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
