import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class AddTaskPage extends StatefulWidget {
  // final List<Task> undoneTaskList;
  // AddTaskPage({this.undoneTaskList});
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  TextEditingController titleController = TextEditingController();

  Future<void> insertTask(String title) async {
    var collection = Firestore.instance.collection('task');
    collection.add(
        {'title': title, 'is_done': false, 'created_time': Timestamp.now()});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('タスクを追加'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Text('タスク名', style: TextStyle(fontSize: 20)),
            ),
            Container(
                width: 500,
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () async {
                        //①新しく追加するタスクを作成
                        // Task newTask = Task(
                        //   title: titleController.text,
                        //   isDane: false,
                        // );
                        //②作成したタスクを未完了タスクリストに追加
                        // widget.undoneTaskList.add(newTask);
                        await insertTask(titleController.text);
                        //③追加が完了すれば元の画面に遷移
                        Navigator.pop(context);
                      },
                      child: Text(
                        '追加',
                        style: TextStyle(fontSize: 20),
                      ))),
            )
          ],
        ),
      ),
    );
  }
}
