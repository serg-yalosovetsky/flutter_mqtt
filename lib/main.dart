
import 'package:flutter/material.dart';

import 'package:myapp/mqtt.dart' show mqtt_main;

import 'package:myapp/pages/home.dart';

/// An annotated simple subscribe/publish usage example for mqtt_server_client. Please read in with reference
/// to the MQTT specification. The example is runnable, also refer to test/mqtt_client_broker_test...dart
/// files for separate subscribe/publish tests.
/// First create a client, the client is constructed with a broker name, client identifier
/// and port if needed. The client identifier (short ClientId) is an identifier of each MQTT
/// client connecting to a MQTT broker. As the word identifier already suggests, it should be unique per broker.
/// The broker uses it for identifying the client and the current state of the client. If you don’t need a state
/// to be hold by the broker, in MQTT 3.1.1 you can set an empty ClientId, which results in a connection without any state.
/// A condition is that clean session connect flag is true, otherwise the connection will be rejected.
/// The client identifier can be a maximum length of 23 characters. If a port is not specified the standard port
/// of 1883 is used.
/// If you want to use websockets rather than TCP see below.



void main() {
  runApp(const MyApp());
  mqtt_main();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var theme = ThemeData(
      // This is the theme of your application.
      //
      // Try running your application with "flutter run". You'll see the
      // application has a blue toolbar. Then, without quitting the app, try
      // changing the primarySwatch below to Colors.green and then invoke
      // "hot reload" (press "r" in the console where you ran "flutter run",
      // or simply save your changes to "hot reload" in a Flutter IDE).
      // Notice that the counter didn't reset back to zero; the application
      // is not restarted.
      primarySwatch: Colors.blue,
    );
    var app = MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
    return app;
  }
}
