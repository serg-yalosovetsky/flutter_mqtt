import 'package:flutter/material.dart';

Widget menu_drawer(context) {
  return Drawer(
    // Add a ListView to the drawer. This ensures the user can scroll
    // through the options in the drawer if there isn't enough vertical
    // space to fit everything.
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text('Menu'),
        ),
        ListTile(
          title: const Text('Settings'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/settings');
          },
        ),
        ListTile(
          title: const Text('Mqtt'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/mqtt');
          },
        ),
        ListTile(
          title: const Text('About'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/about');
          },
        ),
        ListTile(
          title: const Text('fab'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/fab');
          },
        ),
      ],
    ),
  );
}
