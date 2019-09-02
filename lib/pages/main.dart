import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:teztez_app/scp_model/scope.dart';
import 'package:toast/toast.dart';
import '../widgets/list_item.dart';

class MainPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _description;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<Scope>(
      builder: (BuildContext context, Widget child, Scope model) {
        return Scaffold(
          drawer: _buildDrawer(context),
//      backgroundColor: Colors.grey,
          appBar: AppBar(title: Text("Todo")),
          body: ListView.builder(
            itemCount: model.todoList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListItem(model.todoList[index]);
            },
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 0,
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Form(
                              key: _formKey,
                              child: TextFormField(
                                initialValue: "",
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                    hintText: "Type your ToDo here"),
                                onSaved: (String value) {
                                  _description = value;
                                },
                                validator: (String value) {
                                  String errorMsg;
                                  if (value.isEmpty) errorMsg = "Input can't be empty!";
                                  return errorMsg;
                                },
                              ),
                            ),
                            SizedBox(height: 25),
                            SizedBox(
                              height: 50,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Center(
                                      child: FlatButton(
                                        textColor: Colors.blue,
                                        child: Text("Add"),
                                        onPressed: () =>
                                            addToList(model, context),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: FlatButton(
                                        textColor: Colors.black,
                                        child: Text("Close"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  void addToList(Scope model, BuildContext context) {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    model.insert(_description);
    Toast.show("Added", context);
    Navigator.of(context).pop();
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text("Menu"),
          ),
          ListTile(
            leading: Icon(
              Icons.done,
              color: Colors.green,
            ),
            title: Text("Done"),
            onTap: () {
              Toast.show("Hello world", context, duration: Toast.LENGTH_LONG);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Todo List'),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
