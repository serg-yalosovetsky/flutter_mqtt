import 'package:flutter/material.dart';


Widget floatingActionButton = FloatingActionButton(
  onPressed: ()
  {
    // Add your onPressed code here!
  },
  backgroundColor: Colors.blue,
  child: const Icon(Icons.add),



);
Widget first_scaffold (bool is_editable) {
  return Scaffold(
    body: Center(child: Text('something')),
    floatingActionButton: (is_editable) ? floatingActionButton : null,
  );
}