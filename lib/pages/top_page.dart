import 'package:flutter/material.dart';
import 'package:flutter_app_2021430/model/task.dart';
import 'package:flutter_app_2021430/pages/add_task_page.dart';
import 'package:flutter_app_2021430/pages/dane_task_page.dart';
import 'package:flutter_app_2021430/pages/undone_task_page.dart';


class TopPage extends StatefulWidget {
  TopPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  List<Task> doneTaskList = [];

  bool showUndoneTaskPage = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('flutter　×　Firebase for WEB'),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          showUndoneTaskPage
              ? UndoneTaskPage()
              : DoneTaskPage(),


          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: (){
                    showUndoneTaskPage = true;
                    setState(() {
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    color: Colors.redAccent,
                    child: Text(
                        '未完了タスク',
                      style: TextStyle(color: Colors.white,fontSize: 20),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: (){
                    showUndoneTaskPage = false;
                    setState(() {

                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    color: Colors.greenAccent,
                    child: Text('完了タスク',
                    style: TextStyle(color: Colors.white,fontSize: 20)),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    floatingActionButton: FloatingActionButton(
      onPressed: () async{
        await Navigator.push(context, MaterialPageRoute(builder:(context)=>AddTaskPage()));
        setState(() {

        });
      },
      tooltip: 'Increment',
      child: Icon(Icons.add),
    ),
    // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}