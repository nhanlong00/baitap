import 'package:core/import.dart';
import 'package:core/page/Crud_Dio/controller.dart';
import 'package:core/page/Crud_Dio/detail/detail.dart';
import 'package:core/page/Crud_Dio/edit/update.dart';
import 'package:core/page/Crud_Dio/model/model.dart';

class TableData extends StatelessWidget {
  const TableData({super.key});

  Future<void> formUpdate(BuildContext context, String id, String title,
      String detailTask, DateTime dateTime) async {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Chỉnh sửa công việc $title'),
          content: FormUpdateContent(
              id: id, title: title, detailTask: detailTask, dateTime: dateTime),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FormController>(
      init: FormController(),
      builder: (controller) {
        final List<TaskModel> displayedTasks =
            controller.result.isNotEmpty ? controller.result : controller.tasks;
        return ListView.builder(
          itemCount: displayedTasks.length,
          itemBuilder: (ctx, index) {
            return Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(1, 1),
                    blurRadius: 1.0,
                    spreadRadius: 1.0,
                  ),
                  BoxShadow(color: Colors.white)
                ],
              ),
              child: Row(
                children: [
                  Text((index + 1).toString()),
                  const SizedBox(width: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      Text('Tên công việc: ${displayedTasks[index].title}'),
                      const SizedBox(height: 12),
                      Text(
                          'Thời gian: ${displayedTasks[index].dateTime.month}/${displayedTasks[index].dateTime.day}/${displayedTasks[index].dateTime.year}'),
                    ],
                  ),
                  const SizedBox(width: 100),
                  InkWell(
                    onTap: () {
                      controller.update();
                      // controller.updateTaskComplete(displayedTasks[index].id, displayedTasks[index].isCompleted);
                    },
                    child: !displayedTasks[index].isCompleted
                        ? const Icon(Icons.check_box_outline_blank)
                        : const Icon(Icons.check_box),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      const FormDetail();
                    },
                    icon: const Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    onPressed: () {
                      formUpdate(
                        context,
                        controller.tasks[index].id,
                        controller.tasks[index].title,
                        controller.tasks[index].detailTask,
                        controller.tasks[index].dateTime,
                      );
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    onPressed: () {
                      controller.deleteItem(controller.tasks[index].id);
                    },
                    icon: const Icon(
                      Icons.delete_outlined,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
