import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/todo_model.dart';
import '../database/database_helper.dart';
import '../scp_model/scope.dart';

class ListItem extends StatelessWidget {
  final Todo item;

  ListItem(this.item);

  @override
  Widget build(BuildContext context) {
    final DatabaseHelper _dataBaseHelper = DatabaseHelper.instance;
    final double _height = MediaQuery.of(context).size.height;
    final double _itemHeight = _height * .1;
    return ScopedModelDescendant<Scope>(
      builder: (BuildContext context, Widget child, Scope model) => Dismissible(
        key: Key("${item.id}"),
        onDismissed: (direction) {
          model.delete(item.id);
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          height: _itemHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            elevation: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text("${item.todoDescription}"),
                ),
                Expanded(child: SizedBox()),
                Checkbox(
                  value: item.isDone,
                  onChanged: (bool value) {
                    final map = {
                      DatabaseHelper.columnTodoDescription:
                          item.todoDescription,
                      DatabaseHelper.columnIsDone: !item.isDone,
                      DatabaseHelper.columnId: item.id,
                    };
                    model.update(map);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
