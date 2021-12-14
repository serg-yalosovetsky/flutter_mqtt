import 'package:flutter/material.dart';

import 'package:myapp/elements/menu.dart';
import 'package:myapp/elements/tab_scaffold.dart';
import 'package:myapp/helpers.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  DashboardPageState createState() => DashboardPageState();
}

int editable = 0;

Widget first_tab = first_scaffold(to_bool(editable));

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
              floatingActionButton: (to_bool(editable)) ? floatingActionButton : null,
            ),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
          ]
          ),
          drawer: menu_drawer(context),
        )
    );
  }
}