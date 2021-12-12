import 'dart:io';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

final client = MqttServerClient('10.80.39.78', 'mqttx_498526');

var notifications = [];

List get_notifications () {
  return notifications;
}

Future<void> mqtt_main() async {

  client.logging(on: false);

  List _get_notifications () {
    return notifications;
  }

  client.keepAlivePeriod = 60;
  String username = 'igor';
  String password = 'p29041971';

  client.onDisconnected = onDisconnected;

  client.onConnected = onConnected;

  client.onSubscribed = onSubscribed;

  client.pongCallback = pong;

  final connMess = MqttConnectMessage()
      .withClientIdentifier('mqttx_498239')
  // .withWillTopic('house') // If you set this you must set a will message
  // .withWillMessage('1')
      .startClean() // Non persistent session for testing
      .withWillQos(MqttQos.atLeastOnce);
  print('Mosquitto client connecting....');
  client.connectionMessage = connMess;
  String error_message = 'client exception - ';
  try {
    await client.connect(username, password);
  } on NoConnectionException catch (e) {
    // Raised by the client when connection fails.
    print('$error_message $e');
    client.disconnect();
  } on SocketException catch (e) {
    // Raised by the socket layer
    print('$error_message $e');
    client.disconnect();
  }

  /// Check we are connected
  if (client.connectionStatus!.state == MqttConnectionState.connected) {
    print('Mosquitto client connected');
  } else {
    /// Use status here rather than state if you also want the broker return code.
    print(
        'ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
    client.disconnect();
    // exit(-1);
  }

  /// Ok, lets try a subscription
  print('Subscribing to the house/cabinet/lamp/command0 topic');
  const topic = 'house/#'; // Not a wildcard topic
  client.subscribe(topic, MqttQos.atMostOnce);

  /// The client has a change notifier object(see the Observable class) which we then listen to to get
  /// notifications of published updates to each subscribed topic.
  client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
    final recMess = c![0].payload as MqttPublishMessage;
    final pt =
    MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
    MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
    String message = 'Change notification:: topic is ${c[0].topic}, payload is $pt';
    print(message);
    print('');
    notifications.add(message);
  });

  // client.published!.listen((MqttPublishMessage message) {
  //   print(
  //       'EXAMPLE::Published notification:: topic is ${message.variableHeader!.topicName}, with Qos ${message.header!.qos}');
  // });

  // const pubTopic = 'house/cabinet/lamp/command0';
  // final builder = MqttClientPayloadBuilder();
  // builder.addString('1');

  /// Subscribe to it   444
  // print('EXAMPLE::Subscribing to the house/cabinet/lamp/command0 topic');
  // client.subscribe(pubTopic, MqttQos.exactlyOnce);

  /// Publish it
  // print('EXAMPLE::Publishing our topic');
  // client.publishMessage(pubTopic, MqttQos.exactlyOnce, builder.payload!);

  print('Sleeping.....');
  await MqttUtilities.asyncSleep(120);

  // print('EXAMPLE::Unsubscribing');
  // client.unsubscribe(topic);
  //
  // /// Wait for the unsubscribe message from the broker if you wish.
  // await MqttUtilities.asyncSleep(2);
  // print('EXAMPLE::Disconnecting');
  // client.disconnect();
  // return 'exit';
}

/// The subscribed callback
String onSubscribed(String topic) {
  String message = 'Subscription confirmed for topic $topic';
  print(message);
  return(message);
}

/// The unsolicited disconnect callback
String onDisconnected() {
  String init_message = 'OnDisconnected client callback - Client disconnection';
  print(init_message);
  if (client.connectionStatus!.disconnectionOrigin ==
      MqttDisconnectionOrigin.solicited) {
    String message = 'OnDisconnected callback is solicited, this is correct';
    print(message);
    return(message);
  }
  else {
    return(init_message);
  }
  // exit(-1);
}

/// The successful connect callback
String onConnected() {
  String message = 'OnConnected client callback - Client connection was sucessful';
  print(message);
  return(message);
}

/// Pong callback
String pong() {
  String message = 'Ping response client callback invoked';

  print(message);
  return(message);
}

