import 'package:scoped_model/scoped_model.dart';

import '../database/database_helper.dart';
import '../models/todo_model.dart';

class Scope extends Model {
  final DatabaseHelper _dataBaseHelper = DatabaseHelper.instance;
  List<Todo> _todoList = [];

  List<Todo> get todoList => List.of(_todoList);

  void updateTodoList() async {
    final List<Map<String, dynamic>> allRows =
        await _dataBaseHelper.queryAllRows();
    _todoList = List.generate(
      allRows.length,
      (i) => Todo(
        allRows[i][DatabaseHelper.columnId],
        allRows[i][DatabaseHelper.columnTodoDescription],
        allRows[i][DatabaseHelper.columnIsDone] == 0 ? false : true,
      ),
    );
    notifyListeners();
  }

  void insert(String description) {
    Map<String, dynamic> row = {
      DatabaseHelper.columnIsDone: 0,
      DatabaseHelper.columnTodoDescription: description
    };
    _dataBaseHelper.insert(row);
    updateTodoList();
  }

  void update(Map<String, dynamic> map) {
    _dataBaseHelper.update(map);
    updateTodoList();
  }

  void delete(int id) {
    _dataBaseHelper.delete(id);
    updateTodoList();
  }
}
