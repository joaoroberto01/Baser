import 'package:baser/menu.dart';
import 'package:baser/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'convert_page.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int index = 0;

  final List<Widget> screens = [
    ConvertPage(),
    MenuPage()
  ];

  final List<Text> titles = [
    Text("Baser"),
    Text("Menu")
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          backgroundColor: Colors.greenAccent,
          primaryColor: Colors.greenAccent,
          primaryTextTheme: TextTheme(
              headline6: TextStyle(color: Colors.white))),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      home: Scaffold(
          appBar: AppBar(
            title: titles[index],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: index,
            items: [
              BottomNavigationBarItem(
                  title: Text("Converter"),
                  icon: Icon(Icons.swap_horiz),
                  activeIcon: Icon(Icons.swap_horizontal_circle)),
              BottomNavigationBarItem(
                title: Text("Menu"),
                icon: Icon(Icons.menu),
              )
            ],
            onTap: (index){
              setState(() { this.index = index; });
            },
          ),
          body: screens[index]),
    );
  }
}
