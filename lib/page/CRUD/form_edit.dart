import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:core/page/CRUD/form_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormEdit extends StatefulWidget {
  const FormEdit({super.key});

  @override
  State<FormEdit> createState() => _FormEditState();
}

class _FormEditState extends State<FormEdit> {
  final _formKeyController = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final addressController = TextEditingController();
  final descController = TextEditingController();

  String? fullName;
  String? address;
  String? desc;
  List<Map<String, dynamic>> listData = [];
  String? listEncode;
  List? listDecode;

  @override
  void dispose() {
    // TODO: implement dispose
    fullNameController.dispose();
    addressController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('myData');
    if (data != null) {
      listDecode = jsonDecode(data);
      setState(() {
        if (listDecode != null) {
          listData = List<Map<String, dynamic>>.from(listDecode!);
        }
      });
    }
  }

  submit() async {
    if (_formKeyController.currentState!.validate()) {
      _formKeyController.currentState!.save();
      fullName = fullNameController.text;
      address = addressController.text;
      desc = descController.text;

      fullNameController.clear();
      addressController.clear();
      descController.clear();

      setState(() {
        listData.add({'fullName': fullName, 'address': address, 'desc': desc});
      });

      _saveData();
      _loadData();
    }
  }

  // void _saveData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final data = listData.map((item) => item).toList();
  //   final jsonString = jsonEncode(data);
  //   await prefs.setString('myData', jsonString);
  // }

  deleteItem(item) async {
    setState(() {
      listData.remove(item);
    });
    _saveData();
  }

  void _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(listData);
    await prefs.setString('myData', jsonString);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 300,
            height: 450,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(
                      1.0,
                      3.0,
                    ),
                    blurRadius: 16.0,
                    spreadRadius: 2.0,
                  ), //BoxShadow
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(0.0, 0.0),
                    blurRadius: 0.0,
                    spreadRadius: 0.0,
                  ),
                ]),
            child: Form(
              key: _formKeyController,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('Họ và tên'),
                    const SizedBox(height: 8),
                    TextFormField(
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập họ và tên';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          fullNameController.text = value;
                        });
                      },
                      onSaved: (value) {
                        fullNameController.text = value!;
                      },
                    ),
                    const SizedBox(height: 12),
                    const Text('Address'),
                    const SizedBox(height: 8),
                    ElevatedButton(
                        onPressed: submit, child: const Text('Thêm mới'))
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 100),
          Container(
            width: 300,
            height: 450,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(
                      1.0,
                      3.0,
                    ),
                    blurRadius: 16.0,
                    spreadRadius: 2.0,
                  ), //BoxShadow
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(0.0, 0.0),
                    blurRadius: 0.0,
                    spreadRadius: 0.0,
                  ),
                ]),
            child: FormList(
              listDataPassToPlaceOther: listDecode ?? [],
              deleteItem: (item) {
                deleteItem(item);
              },
            ),
          ),
        ],
      ),
    );
  }
}
