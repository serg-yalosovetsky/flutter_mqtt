import 'package:flutter/material.dart';

class MqttScreen extends StatelessWidget {
  const MqttScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text('todo list'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Text('Mqtt screen'),
            ElevatedButton(
                onPressed: () {
                  // Navigator.pushNamed(context, '/todo');
                  Navigator.pushReplacementNamed(context, '/todo');
                  // Navigator.pushNamedAndRemoveUntil(
                  //     context,
                  //     '/todo',
                  //     (route) => true);
                },
                child: Text('todo screen'))
          ],
        ),
    );
  }
}