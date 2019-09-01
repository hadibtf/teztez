import 'package:scoped_model/scoped_model.dart';
//import 'dart:async';

import '../database/database_helper.dart';
import '../models/todo_model.dart';

class Scope extends Model {
  final DatabaseHelper _dataBaseHelper = DatabaseHelper.instance;
  List<Todo> _todos = [];

  List<Todo> get todoList {
    return List.of(_todos);
  }

  void updateTodoList() async {
    final List<Map<String, dynamic>> allRows = await _dataBaseHelper.queryAllRows();
    _todos = List.generate(
      allRows.length,
      (i) => Todo(
        allRows[i][DatabaseHelper.columnId],
        allRows[i][DatabaseHelper.columnTodoDescription],
        allRows[i][DatabaseHelper.columnIsDone] == 0 ? false : true,
      ),
    );
    notifyListeners();
  }

  void insert() async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnIsDone: 0,
      DatabaseHelper.columnTodoDescription: "Hello, World!"
    };
    final id = await _dataBaseHelper.insert(row);
    print('inserted row id: $id');
    updateTodoList();
  }

  void query() async {
    final allRows = await _dataBaseHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) {
      print(row);
    });
    notifyListeners();
  }

  void update(Map<String, dynamic> map) async {
    final rowsAffected = await _dataBaseHelper.update(map);
    print('updated $rowsAffected row(s)');
    updateTodoList();
  }

  void delete(int id) async {
    // Assuming that the number of rows is the id for the last row.
//    final id = await _dataBaseHelper.queryRowCount();
    final rowsDeleted = await _dataBaseHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
    updateTodoList();
  }
}
