import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GiantFridge',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.pink,
        fontFamily: 'Lobster',
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.image),
        title: Center(
            child: Text(
          'GiantFridge',
          style: TextStyle(fontSize: 32),
        )),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.jpg'),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image(
                image: AssetImage('assets/imgs/1.jpg'),
              ),
              Image(
                image: AssetImage('assets/imgs/2.jpg'),
              ),
              Image(
                image: AssetImage('assets/imgs/3.jpg'),
              ),
              Image(
                image: AssetImage('assets/imgs/4.jpg'),
              ),
              Image(
                image: AssetImage('assets/imgs/5.jpg'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
