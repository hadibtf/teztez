import 'package:flutter/material.dart';
import '../widgets/list_item.dart';
import '../models/todo_model.dart';
import '../database/DatabaseHelper.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final DatabaseHelper _dataBaseHelper = DatabaseHelper.instance;
  List<Todo> _list = List<Todo>();

  @override
  void initState() {
    super.initState();
    _query();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Colors.grey,
      appBar: AppBar(title: Text("Todo")),
      body: ListView.builder(
        itemCount: _list.length,
        itemBuilder: (BuildContext context, int index) {
          return ListItem(
            item: _list[index],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _insert();
        },
      ),
    );
  }

  void _insert() async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnIsDone: 0,
      DatabaseHelper.columnTodoDescription: "Hello, World!"
    };
    final id = await _dataBaseHelper.insert(row);
    print('inserted row id: $id');
    setState(() {
      _list.add(Todo(id, "Hello, World!", false));
    });
  }

  void _query() async {
    final allRows = await _dataBaseHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) {
      print(row);
      setState(() {
        _list.add(Todo(
            row[DatabaseHelper.columnId],
            row[DatabaseHelper.columnTodoDescription],
            row[DatabaseHelper.columnIsDone] == 0 ? false : true));
      });
    });
  }
}
