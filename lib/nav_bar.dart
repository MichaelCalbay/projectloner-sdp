import 'package:flutter/material.dart';
import 'package:instabug_flutter/instabug_flutter.dart';

// NAV BAR CLASS by sam

class NavBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              accountName: Text('Loner') // could be implented later on
              , accountEmail: Text('example@gmail.com')),
          ListTile(
            /*  BUG ICON  */
            leading: Icon(Icons.bug_report_rounded),
            title: Text('Reports'),
            onTap: () => Instabug.show(),
          ),
        ],
      ),
    );
  }
}
