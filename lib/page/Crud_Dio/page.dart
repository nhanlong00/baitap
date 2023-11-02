import 'package:core/import.dart';
import 'package:core/page/Crud_Dio/controller.dart';
import 'package:core/page/Crud_Dio/edit/edit.dart';
import 'package:core/page/Crud_Dio/table_data.dart';
import 'package:core/widgets/Button/button_primary.dart';

class FormPage extends StatelessWidget {
  const FormPage({super.key});

  Future<void> _formEdit(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (_) {
        return const AlertDialog(
          title: Text('Thêm mới công việc'),
          content: FormEditContent(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FormController>(
        init: FormController(),
        builder: (controller) {
          return Center(
            child: Container(
              width: 1000,
              margin: const EdgeInsets.only(top: 40),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 500,
                    child: TextFormField(
                      controller: controller.searchController,
                      decoration: const InputDecoration(
                        hintText: 'Tìm kiếm công việc',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  ButtonPrimary(
                      onClick: () {
                        controller
                            .searchTasks(controller.searchController.text);
                      },
                      title: 'Tìm kiếm'),
                  const SizedBox(height: 20),
                  ButtonPrimary(
                    onClick: () {
                      _formEdit(context);
                    },
                    iconData: Icons.add,
                    title: 'Thêm mới công việc',
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 1000,
                    height: 400,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(2, 1),
                          blurRadius: 3.0,
                          spreadRadius: 1.0,
                        ),
                        BoxShadow(color: Colors.white)
                      ],
                    ),
                    child: const TableData(),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
