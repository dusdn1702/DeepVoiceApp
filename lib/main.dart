import 'package:deep_voice_application/loginPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deep Voice',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        backgroundColor: Colors.deepPurpleAccent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(
                  height: 200, child: Image.asset('assets/intro_logo.png')),
              RaisedButton(
                child: Text('시작하기'),
                color: Colors.white,
                onPressed: (){
                  Navigator.pushNamed(context, '/login');
                },
              )
            ],
          ),
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
      },
     // onGenerateRoute: _getRoute,
    );
  }
}
