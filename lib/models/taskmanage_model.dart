import 'package:cloud_firestore/cloud_firestore.dart';

class TaskManageModel {
  String? docID;
  final String titleTask;
  final String description;
  final String category;
  final String dateTask;
  final String timeTask;
  final bool checkBox;

  TaskManageModel(
      {this.docID,
      required this.titleTask,
      required this.description,
      required this.category,
      required this.dateTask,
      required this.timeTask,
      required this.checkBox,
      }
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'titleTask': titleTask,
      'description': description,
      'category': category,
      'dateTask': dateTask,
      'timeTask': timeTask,
      'checkBox': checkBox,
    };
  }

  factory TaskManageModel.fromMap(Map<String, dynamic> map) {
    return TaskManageModel(
      docID: map['docID'] != null ? map['docID'] as String : null,
      titleTask: map['titleTask'] as String,
      description: map['description'] as String,
      category: map['category'] as String,
      dateTask: map['dateTask'] as String,
      timeTask: map['timeTask'] as String,
      checkBox: map['checkBox'] as bool,
    );
  }

  factory TaskManageModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    return TaskManageModel(
      docID: doc.id,
      titleTask: doc['titleTask'],
      description: doc['description'],
      category: doc['category'],
      dateTask: doc['dateTask'],
      timeTask: doc['timeTask'],
      checkBox: doc['checkBox'],
    );
  }
}
