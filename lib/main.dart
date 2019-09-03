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
  final Scope _model = Scope();

  @override
  void initState() {
    super.initState();
    _model.updateTodoList();
    _model.setInitialCurrentList();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: _model,
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          backgroundColor: Colors.grey,
        ),
        routes: {'/': (BuildContext context) => MainPage()},
      ),
    );
  }
}
