import 'package:flutter/material.dart';
import '../models/todo_model.dart';
import '../database/database_helper.dart';

class ListItem extends StatelessWidget {
  final Todo item;

  ListItem(this.item);

  @override
  Widget build(BuildContext context) {
    final DatabaseHelper _dataBaseHelper = DatabaseHelper.instance;
    final double _height = MediaQuery.of(context).size.height;
    final double _itemHeight = _height * .1;
    return Dismissible(
      key: Key("${item.id}"),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {},
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
              Text("${item.todoDescription}"),
              Expanded(child: SizedBox()),
              Checkbox(
                value: item.isDone,
                onChanged: (bool value) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
