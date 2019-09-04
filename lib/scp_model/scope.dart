import 'package:scoped_model/scoped_model.dart';

import '../database/database_helper.dart';
import '../models/todo_model.dart';

enum CurrentList { ALL, TODO, DONE }

class Scope extends Model {
  final DatabaseHelper _dataBaseHelper = DatabaseHelper.instance;
  List<Todo> _todoList = [];

  List<Todo> get todoList => List.of(_todoList);

  void setCurrentList(CurrentList currentList) async {
    switch (currentList) {
      case CurrentList.ALL:
        _todoList = await updateListFromDatabase();
        break;

      case CurrentList.TODO:
        final _list = await updateListFromDatabase();
        _todoList = List.of(_list.where((Todo todo) => todo.isDone == false));
        break;

      case CurrentList.DONE:
        final _list = await updateListFromDatabase();
        _todoList = List.of(_list.where((Todo todo) => todo.isDone == true));
        break;
    }
  }

  void setInitialCurrentList() async => _todoList = await updateListFromDatabase();

  //Database methods
  void updateTodoList() async => _todoList = await updateListFromDatabase();

  updateListFromDatabase() async {
    final List<Map<String, dynamic>> allRows = await _dataBaseHelper.queryAllRows();
    final _list = List.generate(allRows.length, (i) => Todo(
        allRows[i][DatabaseHelper.columnId],
        allRows[i][DatabaseHelper.columnTodoDescription],
        allRows[i][DatabaseHelper.columnIsDone] == 0 ? false : true,
      ));
    notifyListeners();
    return _list;
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
    setCurrentList(CurrentList.ALL);
    updateTodoList();
  }

  void delete(int id) {
    _dataBaseHelper.delete(id);
    updateTodoList();
  }
}
