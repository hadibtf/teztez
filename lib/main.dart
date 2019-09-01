import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './pages/main.dart';
import './scp_model/scope.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  final Scope _scope = Scope();

  @override
  void initState() {
    super.initState();
    _scope.getTodos();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: _scope,
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          backgroundColor: Colors.grey,
        ),
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
        routes: {'/': (BuildContext context) => MainPage()},
      ),
    );
  }
}

//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//  final String title;
//
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  int _counter = 0;
//
//  void _incrementCounter() {
//    setState(() {
//      _counter++;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(widget.title),
//      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
//    );
//  }
//}
