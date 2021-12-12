import 'package:flutter/material.dart';

import 'package:myapp/pages/SettingsScreen.dart';
import 'package:myapp/pages/AboutScreen.dart';
import 'package:myapp/pages/MQTTScreen.dart';


class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  DashboardPageState createState() => DashboardPageState();
}
bool to_bool(int a) {
  return a==0 ? false : true;
}
int editable = 0;

Widget floatingActionButton = FloatingActionButton(
    onPressed: ()
    {
      // Add your onPressed code here!
    },
    backgroundColor: Colors.blue,
    child: const Icon(Icons.add),
);
Widget first_scaffold = Scaffold(
  body: Center(child: Text('something')),
  floatingActionButton: (! to_bool(editable)) ? floatingActionButton : null,
);
// Widget first_tab = Text('directions_car');
Widget first_tab = first_scaffold;

class DashboardPageState extends State<DashboardPage> {

@override
void initState() {
  editable = 0;


}

  List edit_icons = [
    Icon(
      Icons.edit_off_outlined,
      color: Colors.white,
      size: 22.0,
    ),
    Icon(
      Icons.edit_outlined,
      color: Colors.black,
      size: 26.0,
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap:  () {
                      setState(() {
                        editable = editable==0 ? 1 : 0 ;
                        // if (to_bool(editable))
                        // first_tab =  first_scaffold;
                        // else

                        //   first_tab =  _first_scaffold;
                        // first_tab =  first_scaffold;

                      });
                    },
                    child: edit_icons[editable],
                  )
              ),
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Icon(
                        Icons.more_vert
                    ),
                  )
              ),
            ],
          ),
          body: TabBarView(children:
          [
            Scaffold(
              body: Center(child: Text('something')),
              floatingActionButton: (! to_bool(editable)) ? floatingActionButton : null,
            ),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
          ]
          ),
          drawer: Drawer(
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
              ],
            ),
          ),
        )
    );
  }
}