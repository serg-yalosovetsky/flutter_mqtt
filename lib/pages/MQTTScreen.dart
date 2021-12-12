// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:english_words/english_words.dart';

import 'package:myapp/mqtt.dart' show mqtt_main;
import 'package:myapp/mqtt.dart' show get_notifications;


class MQTTScreen extends StatefulWidget {
  const MQTTScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MQTTScreenState createState() => _MQTTScreenState();
}

class _MQTTScreenState extends State<MQTTScreen> {

  String? user_todo;
  List todo_list = [];
  List notifications = [];

  @override
  void initState() {
    super.initState();
    // todo_list.addAll(['home', 'kitchen']);
  }

  @override
  Widget build(BuildContext context) {


    void refresh_notifications() {
      setState(() {
        notifications = get_notifications();
      });
      print(notifications.toString());
      print(notifications.length);
    }

    var widgets = <Widget>[
        Text(
          notifications.toString(),
        ),
      ];

      var column = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widgets,
      );

      var refresh_button = FloatingActionButton(
        onPressed: mqtt_main,
        tooltip: 'Refresh',
        heroTag: 'refresh_button',
        child: const Icon(Icons.refresh),
      );

      AlertDialog build_add_widget (BuildContext context) {
        void text_change (String value) {
          user_todo = value;
        }

        var commit_text = Text('add');

        void commit_button () {
          setState(() {
            todo_list.add(user_todo);
          });
          Navigator.of(context).pop();
        }

        var _actions = [
          ElevatedButton(
              onPressed: commit_button,
              child: commit_text)
        ];

        var alertDialog = AlertDialog(
            title: Text('add element'),
            content: TextField(
              onChanged: text_change,
            ),
            actions: _actions,
        );

        return alertDialog;
      }

      void show_dialog () {
        showDialog(context: context, builder: build_add_widget);
      }

      var add_button = FloatingActionButton(
        // onPressed: show_dialog,
        onPressed: refresh_notifications,
        tooltip: 'Add',
        heroTag: 'add_button',
        child: Icon(
          Icons.add_box,
        ),
      );

      Dismissible item_builder (BuildContext context, int index) {

          void dismiss_item(direction) {
            // if (direction == DismissDirection.endToStart)
            setState(() {
              notifications.removeAt(index);
            });
          }

          var remove_icon = Icon(
              Icons.delete_sweep,
              color: Colors.deepOrangeAccent
          );

          // var listTile =

          var card = Card(
              child: ListTile(
                // title: Text(todo_list[index]),
                title: Text(notifications[index]),
                trailing: remove_icon,
                onTap: () {
                  setState(() {
                    notifications.removeAt(index);
                  });
                },
              ),
          );

          var dismissible_item = Dismissible(
            // key: Key(todo_list[index]),
            key: Key(notifications[index]),
            child: card,
            onDismissed: dismiss_item,
          );

          return dismissible_item;
      }

      var listView = ListView.builder(
          // itemCount: todo_list.length,
          itemCount: notifications.length,
          itemBuilder: item_builder
      );

       void menu_buttons(_route)  {
          Navigator.pop(context);
          Navigator.pushNamedAndRemoveUntil(context, _route, (route) => false );
      }

      void _menuOpen () {
        var menu_button = ElevatedButton(
          onPressed: () => menu_buttons('/todo'),
          child: Text('on main'),
        );
        var mqtt_button = ElevatedButton(
          onPressed: () => menu_buttons('/'),
          child: Text('on mqtt'),
        );

        List<Widget> body_rows = [
          menu_button,
          mqtt_button,
          Padding(padding: EdgeInsets.only(left: 15)),
          Text('main menu')
        ];

        var _scaffold = Scaffold(
          appBar: AppBar(
              title: Text('menu'),
          ),
          body: Row(children: body_rows)

        );

        // Scaffold menu_bilder (BuildContext context) => scaffold;
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => _scaffold)
        );

      }

      var scaffold = Scaffold(
        backgroundColor: Colors.amber,


        appBar: AppBar(
          // Here we take the value from the MQTTScreen object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
          // centerTitle: true,
          // actions: [
          //   IconButton(
          //       onPressed: _menuOpen,
          //       icon: Icon(
          //         Icons.menu
          //       )
          //   )
          // ],

        ),
        body: listView,
        // body: Text(notifications.toString()),
        // floatingActionButton: [add_button, refresh_button],
        persistentFooterButtons: [add_button, refresh_button],

        // This trailing comma makes auto-formatting nicer for build methods.
      );

      return scaffold;
    }


}
