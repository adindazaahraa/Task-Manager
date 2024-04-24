import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_manager/models/taskmanage_model.dart';

class TaskManageService {
  final taskmanageCollection =
      FirebaseFirestore.instance.collection('taskmanagerApp');

  // CRUD
  // CREATE
  void adddNewTask(TaskManageModel model) {
    taskmanageCollection.add(model.toMap());
  }

  // UPDATE
  void updateTask(String? docID, bool? valueUpdate) {
    taskmanageCollection.doc(docID).update({
      'checkBox': valueUpdate,
    });
  }

  // DELETE
  void deleteTask(String? docID) {
    taskmanageCollection.doc(docID).delete();
  }
}
