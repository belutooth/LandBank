import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_gorgeous_login/ui/login_page.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'TheGorgeousLogin',
      theme: new ThemeData(
        accentColor: Colors.blueGrey[400], // background color of card headers
        cardColor: Colors.white, // background color of fields
        backgroundColor: Colors.white, // color outside the card
        primaryColor: Colors.white, // color of page header
        buttonColor: Colors.grey, // background color of buttons
        textTheme: TextTheme(
          button:
          TextStyle(color: Colors.black), // style of button text
          subhead: TextStyle(color: Colors.grey[900]), // style of input text
        ),
        primaryTextTheme: TextTheme(
          title: TextStyle(color: Colors.black), // style for headers
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.black), // style for labels
        ),
      ),
      home: new LoginPage(),
    );
  }
}