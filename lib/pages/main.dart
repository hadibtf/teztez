import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:teztez_app/scp_model/scope.dart';
import '../widgets/list_item.dart';
import '../models/todo_model.dart';
import '../database/database_helper.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<Scope>(
      builder: (BuildContext context, Widget child, Scope model) {
        return Scaffold(
//      backgroundColor: Colors.grey,
          appBar: AppBar(title: Text("Todo")),
          body: ListView.builder(
            itemCount: model.todoList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListItem(model.todoList[index]);
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              model.insert();
              model.getTodos();
            },
          ),
        );
      },
    );
  }
}
