import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String title;
  bool isDane;
  Timestamp createdTime;
  Timestamp updatedTime;

  Task({this.title,this.isDane,this.createdTime,this.updatedTime});

}