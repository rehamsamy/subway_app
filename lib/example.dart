
import 'package:flutter/material.dart';


class Example extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.pink[800], //Changing this will change the color of the TabBar
        accentColor: Colors.cyan[600],
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
             // backgroundColor: Colors.grey,

              title: Text('Tabs Demo'),
              elevation: 10,
            ),
            body:
            Column(
              children: <Widget>[
                Card(
                  elevation: 5,
                  child: TabBar(
                    indicatorColor: Colors.deepOrange,

                    tabs: [
                      Tab(icon: Icon(Icons.directions_car),),
                      Tab(icon: Icon(Icons.directions_transit)),
                      Tab(icon: Icon(Icons.directions_bike)),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TabBarView(
                    children: [
                      Icon(Icons.directions_car),
                      Icon(Icons.directions_transit),
                      Icon(Icons.directions_bike),
                    ],
                  ),
                )
              ],
            ),
          floatingActionButton: FloatingActionButton(

          ),

        ),
      ),
    );
  }


}
