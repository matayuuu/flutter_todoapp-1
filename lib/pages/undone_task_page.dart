import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UndoneTaskPage extends StatefulWidget {
  // final List<Task> undoneTaskList;
  // final List<Task> doneTaskList;
  // UndoneTaskPage({this.undoneTaskList,this.doneTaskList});

  @override
  _UndoneTaskPageState createState() => _UndoneTaskPageState();
}

class _UndoneTaskPageState extends State<UndoneTaskPage> {
  TextEditingController editTitleController = TextEditingController();
  CollectionReference tasks;

  
  // List<Task> undoneTaskList = [];
  // Future<void> getUndoneTasks() async{
  //   var collection = Firestore.instance.collection('task');
  //   var snapshot = await collection.where('is_done', isEqualTo: false).getDocuments();
  //   snapshot.documents.forEach((task) {
  //     Task undoneTask = Task(
  //       title: task.data['title'],
  //       isDane: task.data['is_done'],
  //       createdTime: task.data['created_time']
  //     );
  //     undoneTaskList.add(undoneTask);
  //   });
  //   setState(() {});
  // }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tasks = Firestore.instance.collection('task');
  }
  
  @override
  Widget build(BuildContext context) {
    return   
    StreamBuilder<QuerySnapshot>(
      stream: tasks.snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
        return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              if(snapshot.data.documents[index]['is_done']) return Container();
              return CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(snapshot.data.documents[index]['title']),
                value: snapshot.data.documents[index]['is_done'],
                onChanged: (bool value) {
                  // //①完了・未完了の情報を更新
                  // widget.undoneTaskList[index].isDane = value;
                  // //②完了したタスクを完了タスクに追加
                  // widget.doneTaskList.add(widget.undoneTaskList[index]);
                  // //③完了したタスクを未完了タスクリストから削除
                  // widget.undoneTaskList.removeAt(index);
                  // //④画面を再描画
                  // setState(() {});
                  snapshot.data.documents[index].reference.updateData({
                    'is_done': value,
                    'updated_time': Timestamp.now()
                  });

                },
                secondary: IconButton(
                  icon: Icon(Icons.more_horiz),
                  onPressed: (){
                    //ボトムシートを表示
                    showModalBottomSheet(context: context, builder: (context){
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Text('編集'),
                            leading: Icon(Icons.edit),
                            onTap: (){
                              //編集の処理
                              //①ボトムシートを非表示
                              Navigator.pop(context);
                              //②編集用のダイアログを表示
                              showDialog(context: context, builder: (context){
                                return SimpleDialog(
                                  titlePadding: EdgeInsets.all(20),
                                  title: Container(
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        Text('タイトルを編集'),
                                        Container(
                                            width: 500,
                                            child: TextField(
                                              controller: editTitleController,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder()
                                              ),
                                            )),

                                        Padding(
                                          padding: const EdgeInsets.only(top:30),
                                          child: Container(
                                              width: 200,
                                              height: 30,
                                              child: ElevatedButton(
                                                  onPressed: () async{
                                                    // widget.undoneTaskList[index].title = editTitleController.text;
                                                    // Navigator.pop(context);
                                                    // setState(() {});
                                                    await snapshot.data.documents[index].reference.updateData({
                                                      'title': editTitleController.text
                                                        });
                                                    Navigator.pop(context);

                                                  },
                                                  child: Text('編集'))),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                            },
                          ),
                          ListTile(
                            title: Text('削除'),
                            leading: Icon(Icons.delete),
                            onTap: (){
                              //削除の処理
                              //①ボトムシートを非表示に
                              Navigator.pop(context);
                              //②削除用のダイアログを表示
                              showDialog(context: context, builder: (context){
                                return AlertDialog(
                                  title: Text('${snapshot.data.documents[index]['title']}を削除しますか？'),
                                actions: [
                                  TextButton(onPressed: () async{
                                    // widget.undoneTaskList.removeAt(index);
                                    // Navigator.pop(context);
                                    // setState(() {});
                                    await snapshot.data.documents[index].reference.delete();
                                    Navigator.pop(context);
                                  },
                                      child: Text('はい')),
                                  TextButton(onPressed: (){
                                    Navigator.pop(context);
                                  },
                                      child: Text('キャンセル'))
                                ],);
                              });
                            },
                          )
                        ],
                      );
                    }
                    );
                  }
                ),
              );
            },
          itemCount: snapshot.data.documents.length,
        );
        }else{
          return Container();
        }
      }
    );

    // Center(child: Text('未完了タスクを表示中'));
  }
}
