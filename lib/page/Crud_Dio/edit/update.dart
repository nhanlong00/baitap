import 'package:core/import.dart';
import 'package:core/page/Crud_Dio/controller.dart';
import 'package:core/page/Crud_Dio/model/model.dart';
import 'package:core/widgets/Button/button_primary.dart';
import 'package:core/widgets/Button/button_secondary.dart';

class FormUpdateContent extends StatefulWidget {
  const FormUpdateContent({
    super.key,
    required this.id,
    required this.title,
    required this.detailTask,
    required this.dateTime,
  });

  final String id;
  final String title;
  final String detailTask;
  final DateTime dateTime;

  @override
  State<FormUpdateContent> createState() => _FormUpdateContentState();
}

class _FormUpdateContentState extends State<FormUpdateContent> {
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.dateTime;
  }

  Future<void> selectDate(BuildContext context) async {
    final now = DateTime.now();
    final dateTime = DateTime(
        now.year - 1, now.month, now.day, now.hour, now.minute, now.second);
    final time = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: dateTime,
      lastDate: now,
    );

    if (time != null) {
      setState(() {
        selectedDate = time;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController controllerTitle = TextEditingController();
    TextEditingController controllerDetailTask = TextEditingController();
    controllerTitle.text = widget.title;
    controllerDetailTask.text = widget.detailTask;

    return GetBuilder<FormController>(
      init: FormController(),
      builder: (controller) {
        return SizedBox(
          width: 600,
          child: Column(
            children: [
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Tên công việc'),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: controllerTitle,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Vui lòng nhập tên công việc';
                        }
                        return null;
                      },
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                      onSaved: (value) {
                        controller.title = controllerTitle.text;
                        controller.update();
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text('Mô tả công việc'),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: controllerDetailTask,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Vui lòng nhập mô tả công việc';
                        }
                        return null;
                      },
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                      onSaved: (value) {
                        controller.detailTask = controllerDetailTask.text;
                        controller.update();
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text('Thời gian'),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 12),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(4)),
                            child: Row(
                              children: [
                                Text(
                                  selectedDate == null
                                      ? 'Chọn thời gian'
                                      : controller.dataTime =
                                          formatter.format(selectedDate!)
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    selectDate(context);
                                  },
                                  child: const Icon(
                                    Icons.calendar_month,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ButtonSecondary(
                    onClick: () {
                      Get.back();
                      Get.delete<FormController>();
                    },
                    title: 'Hủy',
                  ),
                  const SizedBox(width: 20),
                  ButtonPrimary(
                    onClick: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        controller.updateItem(widget.id, {
                          'title': controller.title,
                          'desc': controller.detailTask,
                          'createdTime': controller.dataTime
                        });
                      }
                    },
                    title: 'Cập nhật',
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
