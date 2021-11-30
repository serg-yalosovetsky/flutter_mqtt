// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:english_words/english_words.dart';

import 'package:myapp/mqtt.dart' show mqtt_main;
// import 'package:myapp/mqtt.dart' show get_notifications;


class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String? user_todo;
  List todo_list = [];

  @override
  void initState() {
    super.initState();

    todo_list.addAll(['home', 'kitchen']);
  }

  int _counter = 0;

  // get notifications => _main().notifications;


  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }


  String _return_words() {
    final wordPair = WordPair.random();

    // setState(() {
    //   // This call to setState tells the Flutter framework that something has
    //   // changed in this State, which causes it to rerun the build method below
    //   // so that the display can reflect the updated values. If we changed
    //   // _counter without calling setState(), then the build method would not be
    //   // called again, and so nothing would appear to happen.
    //   // _counter++;
    // });
    return wordPair.asPascalCase;
  }

  @override
  Widget build(BuildContext context) {
    var widgets = <Widget>[
      // const Text(
      //   'You have pushed the button this many times:',
      // ),
      Text(
        '$_counter' + _return_words(),
        // style: Theme.of(context).textTheme.headline4,
      ),
      // Text(
      //   pong(),
      // ),
    ];
    var column = Column(
      // Column is also a layout widget. It takes a list of children and
      // arranges them vertically. By default, it sizes itself to fit its
      // children horizontally, and tries to be as tall as its parent.
      //
      // Invoke "debug painting" (press "p" in the console, choose the
      // "Toggle Debug Paint" action from the Flutter Inspector in Android
      // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
      // to see the wireframe for each widget.
      //
      // Column has various properties to control how it sizes itself and
      // how it positions its children. Here we use mainAxisAlignment to
      // center the children vertically; the main axis here is the vertical
      // axis because Columns are vertical (the cross axis would be
      // horizontal).
      mainAxisAlignment: MainAxisAlignment.center,
      children: widgets,
    );
    var refresh_button = FloatingActionButton(
      onPressed: mqtt_main,
      tooltip: 'Refresh',
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
        onPressed: show_dialog,
        tooltip: 'Add',
        child: Icon(
          Icons.add_box,
        ),
      );

      Dismissible item_builder (BuildContext context, int index) {

        void dismiss_item (direction) {
          // if (direction == DismissDirection.endToStart)
          setState(() {
            todo_list.removeAt(index);
          });
        }
        var remove_icon = Icon(
            Icons.delete_sweep,
            color: Colors.deepOrangeAccent
        );
        var listTile = ListTile(
          title: Text(todo_list[index]),
          trailing: remove_icon,
          onTap: () {
            setState(() {
              todo_list.removeAt(index);
            });
          },
        );

        var card = Card(
            child: listTile
        );

        var dismissible_item = Dismissible(
          key: Key(todo_list[index]),
          child: card,
          onDismissed: dismiss_item,
        );

        return dismissible_item;
      }
      var listView = ListView.builder(
          itemCount: todo_list.length,
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

        var scaffold = Scaffold(
          appBar: AppBar(
              title: Text('menu'),
          ),
          body: Row(children: body_rows)

        );
        // Scaffold menu_bilder (BuildContext context) => scaffold;
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => scaffold)
        );
      }

      var scaffold = Scaffold(
        backgroundColor: Colors.amber,


        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: _menuOpen,
                icon: Icon(
                  Icons.menu
                )
            )
          ],

        ),
        body: listView,
        // floatingActionButton: [add_button, refresh_button],
        persistentFooterButtons: [add_button, refresh_button],

        // This trailing comma makes auto-formatting nicer for build methods.
      );
      return scaffold;
    }

    // return Scaffold(
    //   backgroundColor: Colors.amber,
    //   appBar: AppBar(
    //     title: Text('Список дел'),
    //     centerTitle: true,
    //   ),
    //   body: listView
    // );
  }
