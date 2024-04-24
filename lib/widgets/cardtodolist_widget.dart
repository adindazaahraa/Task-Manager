import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:task_manager/provider/service_provider.dart';

class CardTodoListWidget extends ConsumerWidget {
  const CardTodoListWidget({
    super.key,
    required this.getIndex,
  });

  final int getIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskmanageData = ref.watch(fetchStreamProvider);
    return taskmanageData.when(
        data: (taskmanageData) {
          Color categoryColor = Colors.white;
          final getCategory = taskmanageData[getIndex].category;

          switch (getCategory) {
            case 'Learning':
            categoryColor = Colors.green;
            break;

            case 'Work':
            categoryColor = Colors.blue.shade700;
            break;

            case 'General':
            categoryColor = Colors.amber.shade700;
            break;
          }
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: categoryColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12)),
                  ),
                  width: 20,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: IconButton(
                            icon: Icon(CupertinoIcons.delete),
                            onPressed: () => ref.read(serviceProvider).deleteTask(taskmanageData[getIndex].docID),
                          ),
                          title: Text(
                            taskmanageData[getIndex].titleTask, 
                            maxLines: 1,
                            style: TextStyle(
                              decoration: taskmanageData[getIndex].checkBox ? TextDecoration.lineThrough : null
                            ),
                          ),
                          subtitle: Text(
                            taskmanageData[getIndex].description, 
                            maxLines: 1,
                            style: TextStyle(
                              decoration: taskmanageData[getIndex].checkBox ? TextDecoration.lineThrough : null
                            ),
                          ),
                          trailing: Transform.scale(
                            scale: 1.5,
                            child: Checkbox(
                              activeColor: Colors.blue.shade800,
                              shape: const CircleBorder(),
                              // value: taskmanageData[getIndex].checkBox,
                              value: false,
                              onChanged: (value) => ref
                                .read(serviceProvider)
                                .updateTask(taskmanageData[getIndex].docID, value),
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(0, -12),
                          child: Column(
                            children: [
                              Divider(
                                thickness: 1.5,
                                color: Colors.grey.shade200,
                              ),
                              Row(
                                children: [
                                  const Text('Today'),
                                  const Gap(12),
                                  Text(taskmanageData[getIndex].timeTask)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) => Center(
              child: Text(stackTrace.toString()),
            ),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }
}
