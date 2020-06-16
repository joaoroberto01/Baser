import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
//        ListTile(
//          leading: Icon(Icons.info_outline),
//          title: Text("Sobre"),
//          onTap: (){
//            print("");
//          },
//        )
      AboutListTile(
        applicationName: "Baser",
        applicationVersion: "1.0",
        child: Text("Sobre"),
      )
      ],
    );
  }
}
