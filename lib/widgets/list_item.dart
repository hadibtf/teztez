import 'package:flutter/material.dart';
import '../models/todo_model.dart';
import '../database/DatabaseHelper.dart';


class ListItem extends StatefulWidget {
  final Todo item;

  ListItem({this.item});

  @override
  State<StatefulWidget> createState() => _ListItemState(item);
}

class _ListItemState extends State<ListItem> {
  final DatabaseHelper _dataBaseHelper = DatabaseHelper.instance;

  bool check = false;

  Todo _item;

  _ListItemState(this._item);

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _itemHeight = _height * .1;
    return Dismissible(
      key: Key("${_item.id}"),
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
                Text("${_item.todoDescription}"),
                Expanded(child: SizedBox()),
                Checkbox(
                  value: _item.isDone,
                  onChanged: (bool value) {
                    setState(() {
                      _item = Todo(_item.id, _item.todoDescription, !_item.isDone);
                      _update();
                    });
                  },
                ),
              ],
            )),
      ),
    );
  }
  void _update() async {
    // row to update
    Map<String, dynamic> row = {
      DatabaseHelper.columnId   : _item.id,
      DatabaseHelper.columnTodoDescription : _item.todoDescription,
      DatabaseHelper.columnIsDone  : _item.isDone
    };
    final rowsAffected = await _dataBaseHelper.update(row);
    print('updated $rowsAffected row(s)');
  }
}
