import 'package:flutter/material.dart';

class FormList extends StatelessWidget {
  const FormList({super.key, required this.listDataPassToPlaceOther, required this.deleteItem});

  final Function(dynamic) deleteItem;
  final List<dynamic> listDataPassToPlaceOther;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listDataPassToPlaceOther.length,
      itemBuilder: (BuildContext context, index) {
        return (listDataPassToPlaceOther.isNotEmpty)
            ? Container(
          padding:
          const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Họ và tên: ${listDataPassToPlaceOther[index]['fullName']}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                   InkWell(
                    onTap: () {
                      deleteItem(listDataPassToPlaceOther[index]);
                    },
                    child: const Icon(Icons.delete),
                  )
                ],
              ),
            ),
          ),
        )
            : const Center(
          child: Text('Không có dữ liệu'),
        );
      },
    );
  }
}