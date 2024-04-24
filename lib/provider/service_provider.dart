import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/models/taskmanage_model.dart';
import 'package:task_manager/services/taskmanage_service.dart';

final serviceProvider = StateProvider<TaskManageService>((ref) {
  return TaskManageService();
});

final fetchStreamProvider = StreamProvider<List<TaskManageModel>>((ref) async* {
  final getData = FirebaseFirestore.instance
      .collection('taskmanagerApp')
      .snapshots()
      .map((event) => event.docs
          .map((snapshot) => TaskManageModel.fromSnapshot(snapshot))
          .toList());
  yield* getData;
});