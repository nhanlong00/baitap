import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:core/import.dart';
import 'package:core/page/Crud_Dio/model/model.dart';
import 'package:http/http.dart' as http;

class FormController extends GetxController {
  String? id;
  String? title;
  String? detailTask;
  String? dataTime;
  bool? isCompleted = false;

  String? errorMessage;
  List<TaskModel> tasks = [];

  String? searchTitle;
  final TextEditingController searchController = TextEditingController();
  List<TaskModel> result = [];

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  // get data from server
  Future<void> getData() async {
    final url = Uri.https(
        'app-practice-34fcf-default-rtdb.firebaseio.com', 'tasks.json');

    try {
      final res = await http.get(Uri.parse('$url'));

      if (res.statusCode == 200) {
        Map<String, dynamic> dataDecode = jsonDecode(res.body);
        final inputFormat = DateFormat("MM/dd/yyyy");
        DateTime createdTime;

        if (dataDecode.isNotEmpty) {
          for (final item in dataDecode.entries) {
            final createdTimeString = item.value['createdTime'] ?? '';
            createdTime = inputFormat.parse(createdTimeString);

            tasks.add(TaskModel(
              id: item.key.toString(),
              title: item.value['title'] ?? '',
              detailTask: item.value['desc'] ?? '',
              dateTime: createdTime,
            ));
          }
        } else {
          print('Nó đang bị null ở đâu đấy');
        }

        update();
      } else {
        throw Exception('Có lỗi xảy ra ${res.statusCode}');
      }
    } catch (error) {
      throw Exception('Có lỗi xảy ra $error');
    }
  }

  // send a data to server
  Future<void> submit() async {
    final url = Uri.https(
        'app-practice-34fcf-default-rtdb.firebaseio.com', 'tasks.json');

    try {
      final res = await http.post(
        url,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(
          {
            'title': title,
            'desc': detailTask,
            'createdTime': dataTime,
            'isCompleted': isCompleted
          },
        ),
      );

      if (res.statusCode == 200) {
        print('Thêm mới thành công');
      } else {
        print('Thêm mới thất bại');
      }
    } catch (error) {
      throw Exception('Có lỗi xảy ra $error');
    }
  }

  // update a record item to server
  Future<void> updateItem(String id, Map<String, dynamic> newData) async {
    final url = Uri.https(
        'app-practice-34fcf-default-rtdb.firebaseio.com', 'tasks/$id.json');

    final dataUpdate = jsonEncode(newData);
    try {
      final res = await http.put(url,
          headers: <String, String>{'Content-Type': 'application/json'},
          body: dataUpdate);

      if (res.statusCode == 200) {
        print('Cập nhật thành công');
      } else {
        print('Cập nhật thất bại');
      }
    } catch (error) {
      throw Exception('Cập nhật thất bại. Có lỗi xảy ra $error');
    }
  }

  // delete a item
  Future<http.Response> deleteItem(String id) async {
    final url = Uri.https(
        'app-practice-34fcf-default-rtdb.firebaseio.com', 'tasks/$id.json');

    try {
      final http.Response res = await http.delete(url);

      if (res.statusCode == 200) {
        print('Xóa thành công');
      } else {
        print('Xóa thất bại');
      }
      return res;
    } catch (error) {
      throw Exception('Có lỗi xảy ra $error');
    }
  }

  Future<void> searchTasks(String keyword) async {
    final response = await http.get(Uri.https(
        'app-practice-34fcf-default-rtdb.firebaseio.com', 'tasks.json'));
    final inputFormat = DateFormat("MM/dd/yyyy");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      DateTime createdTime;
      print('$data');
      data.forEach((key, value) {
        final createdTimeString = value['createdTime'] ?? '';
        createdTime = inputFormat.parse(createdTimeString);

        if (value['title'].contains(keyword) ||
            value['desc'].contains(keyword)) {
          result.add(TaskModel(
            id: value['key'].toString(),
            title: value['title'] ?? '',
            detailTask: value['desc'] ?? '',
            dateTime: createdTime,
          ));
        }
      });
      update();
      print('result $result');
    } else {
      throw Exception(
          'Không thể tìm thấy bản ghi hoặc có lỗi: ${response.statusCode}');
    }
  }

  Future<void> updateTaskComplete(String taskId, bool isCompleted) async {
    print('is $isCompleted');
    update();
    // const String baseUrl = 'app-practice-34fcf-default-rtdb.firebaseio.com';
    // final String path = 'tasks/$taskId.json';

    // final response = await http.get(Uri.https('$baseUrl/$path'));

    // try {
    //   if (response.statusCode == 200) {
    //     final Map<String, dynamic> currentData = jsonDecode(response.body);
    //
    //     currentData["isCompleted"] = isCompleted;
    //
    //     final updateResponse = await http.put(
    //       Uri.parse('$baseUrl/$path'),
    //       body: jsonEncode(currentData),
    //     );
    //
    //     if (updateResponse.statusCode == 200) {
    //       print('Cập nhật công việc thành công.');
    //     } else {
    //       print('Có lỗi xảy ra khi cập nhật công việc.');
    //     }
    //   } else {
    //     print('Có lỗi xảy ra khi lấy dữ liệu từ server.');
    //   }
    // } catch (error) {
    //   throw Exception('Có lỗi xảy ra: ${response.statusCode}');
    // }
  }
}
