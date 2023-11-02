import 'package:core/import.dart';
import 'package:core/page/Crud_Dio/controller.dart';
import 'package:core/page/Crud_Dio/model/model.dart';
import 'package:core/widgets/Button/button_primary.dart';
import 'package:core/widgets/Button/button_secondary.dart';

class FormEditContent extends StatefulWidget {
  const FormEditContent({super.key});

  @override
  State<FormEditContent> createState() => _FormEditContentState();
}

class _FormEditContentState extends State<FormEditContent> {
  DateTime? selectedDate;

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

    if(time != null) {
      setState(() {
        selectedDate = time;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

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
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Vui lòng nhập tên công việc';
                        }
                        return null;
                      },
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                      onSaved: (value) {
                        controller.title = value;
                        controller.update();
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text('Mô tả công việc'),
                    const SizedBox(height: 8),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Vui lòng nhập mô tả công việc';
                        }
                        return null;
                      },
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                      onSaved: (value) {
                        controller.detailTask = value;
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
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(4)
                            ),
                            child: Row(
                              children: [
                                Text(
                                  selectedDate == null
                                      ? 'Chọn thời gian'
                                      : controller.dataTime = formatter.format(selectedDate!),
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
                        controller.submit();
                      }
                    },
                    title: 'Thêm mới',
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
