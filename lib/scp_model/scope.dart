import 'package:scoped_model/scoped_model.dart';

import '../database/database_helper.dart';
import '../models/todo_model.dart';

enum CurrentList { ALL, TODO, DONE }

class Scope extends Model {
  final DatabaseHelper _dataBaseHelper = DatabaseHelper.instance;
  List<Todo> _all = [];
  List<Todo> _currentList = [];

  List<Todo> get all => _all;

  List<Todo> get done => List.of(_all.where((Todo todo) => todo.isDone == true));

  List<Todo> get todoList => List.of(_all.where((Todo todo) => todo.isDone == false));

  List<Todo> get currentList => _currentList;

  void setCurrentList(CurrentList currentList) {
    switch (currentList) {
      case CurrentList.ALL:
        _currentList = all;
        break;

      case CurrentList.TODO:
        _currentList = todoList;
        break;

      case CurrentList.DONE:
        _currentList = done;
        break;
    }
  }

  void setInitialCurrentList() async => _currentList = await updateListFromDatabase();

  //Database methods
  void updateTodoList() async {
    _all = await updateListFromDatabase();
    notifyListeners();
  }

  Future updateListFromDatabase() async {
    final List<Map<String, dynamic>> allRows = await _dataBaseHelper.queryAllRows();
     final _list = List.generate(
      allRows.length,
      (i) => Todo(
        allRows[i][DatabaseHelper.columnId],
        allRows[i][DatabaseHelper.columnTodoDescription],
        allRows[i][DatabaseHelper.columnIsDone] == 0 ? false : true,
      ),
    );
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
