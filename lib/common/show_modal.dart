import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/constants/app_style.dart';
import 'package:task_manager/models/taskmanage_model.dart';
import 'package:task_manager/provider/datetime_provider.dart';
import 'package:task_manager/provider/radio_provider.dart';
import 'package:task_manager/provider/service_provider.dart';
import 'package:task_manager/widgets/datetime_widget.dart';
import 'package:task_manager/widgets/radio_widget.dart';
import 'package:task_manager/widgets/textfield_widget.dart';

class AddNewTaskModal extends ConsumerWidget {
  AddNewTaskModal({
    super.key,
  });

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateProv = ref.watch(dateProvider);

    return Container(
      padding: const EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height * 0.80,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: double.infinity,
            child: Text(
              'New Task Todo',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Divider(
            thickness: 1.2,
            color: Colors.grey.shade200,
          ),
          const Gap(12),
          const Text(
            'Title Task',
            style: AppStyle.headingOne,
          ),
          const Gap(6),
          TextFieldWidget(
            hintText: 'Add Task Name',
            maxLine: 1,
            txtController: titleController,
          ),
          const Gap(12),
          const Text(
            'Description',
            style: AppStyle.headingOne,
          ),
          const Gap(6),
          TextFieldWidget(
            hintText: 'Add Description',
            maxLine: 5,
            txtController: descriptionController,
          ),
          const Gap(12),
          const Text(
            'Category',
            style: AppStyle.headingOne,
          ),
          Row(
            children: [
              Expanded(
                  child: RadioWidget(
                titleRadio: 'Study',
                categoryColor: Colors.green.shade700,
                valueInput: 1,
                onChangeValue: () =>
                    ref.read(radioProvider.notifier).update((state) => 1),
              )),
              Expanded(
                  child: RadioWidget(
                titleRadio: 'Work',
                categoryColor: Colors.blue.shade700,
                valueInput: 2,
                onChangeValue: () =>
                    ref.read(radioProvider.notifier).update((state) => 2),
              )),
              Expanded(
                  child: RadioWidget(
                titleRadio: 'General',
                categoryColor: Colors.yellow.shade700,
                valueInput: 3,
                onChangeValue: () =>
                    ref.read(radioProvider.notifier).update((state) => 3),
              )),
            ],
          ),

          // Date & Time Section
          Row(
            children: [
              DateTimeWidget(
                titleText: 'Date',
                valueText: dateProv,
                iconSection: CupertinoIcons.calendar,
                onTap: () async {
                  final getValue = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2022),
                    lastDate: DateTime(2026),
                  );
                  if (getValue != null) {
                    final format = DateFormat.yMd();
                    ref
                        .read(dateProvider.notifier)
                        .update((state) => format.format(getValue));
                  }
                },
              ),
              const Gap(22),
              DateTimeWidget(
                titleText: 'Time',
                valueText: ref.watch(timeProvider),
                iconSection: CupertinoIcons.clock,
                onTap: () async {
                  final getTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (getTime != null) {
                    ref
                        .read(timeProvider.notifier)
                        .update((state) => getTime.format(context));
                  }
                },
              ),
            ],
          ),

          // Button Section
          const Gap(12),
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blue.shade800,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: BorderSide(
                          color: Colors.blue.shade800,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'))),
              const Gap(22),
              Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade800,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        final getRadioValue = ref.read(radioProvider);
                        String category = '';

                        switch (getRadioValue) {
                          case 1:
                            category = 'Learning';
                            break;
                          case 2:
                            category = 'Work';
                            break;
                          case 3:
                            category = 'General';
                            break;
                        }

                        ref.read(serviceProvider).adddNewTask(TaskManageModel(
                            titleTask: titleController.text,
                            description: descriptionController.text,
                            category: category,
                            dateTask: ref.read(dateProvider),
                            timeTask: ref.read(timeProvider),
                            checkBox: false,
                            ));

                        print('Data is saving');

                        titleController.clear();
                        descriptionController.clear();
                        ref.read(radioProvider.notifier).update((state) => 0);
                        Navigator.pop(context);
                      },
                      child: const Text('Create'))),
            ],
          )
        ],
      ),
    );
  }
}
