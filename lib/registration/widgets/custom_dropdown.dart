import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomDropdown extends StatelessWidget {
  final TabController tabController;
  final server = [
    'APAC',
    'EU',
    'NA',
    'LATAM',
  ];
  String? valueServer;
  DropdownMenuItem<String> menuItem(String items) => DropdownMenuItem(
        value: items,
        child: Text(
          items,
          style: const TextStyle(fontSize: 16),
        ),
      );

  CustomDropdown({Key? key, required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonFormField<String>(
        value: valueServer,
        items: server.map(menuItem).toList(),
        onChanged: (value) {
          valueServer = value;
        },
        icon: const Icon(
          Icons.arrow_drop_down_circle,
          color: Colors.deepPurple,
        ),
        decoration: const InputDecoration(
          labelText: 'Server',
          border: InputBorder.none,
        ),
      ),
    );
  }
}