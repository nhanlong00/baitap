import 'dart:io';

import 'package:core/import.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

class FormUpload extends StatefulWidget {
  const FormUpload({super.key, required this.typeFile, this.sizeLimit});

  final List<String> typeFile;
  final int? sizeLimit;

  @override
  State<FormUpload> createState() => _FormUploadState();
}

class _FormUploadState extends State<FormUpload> {
  FilePickerResult? result;
  String? selectedFile;
  File? showImage;
  PlatformFile? pickFile;
  String? nameFile;
  Uint8List? showImageForWeb;
  chooseFile() async {
    try {
      result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: widget.typeFile);

      if (result != null && result!.files.isNotEmpty) {
        setState(() {
          nameFile = result!.files.first.name;
          pickFile = result!.files.first;
          print('ssss ${widget.typeFile}');

            if (widget.typeFile.contains(result?.files.first.extension)) {
            if (kIsWeb) {
              showImageForWeb = pickFile!.bytes;
            } else {
              showImage = File(pickFile!.path.toString());
            }
          } else {
            print('Chọn file hợp lệ');
          }
        });
      } else {
        print('Chọn lại file');
      }
    } catch (error) {
      print('Đã xảy ra lỗi $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (pickFile != null)
            ? Container(
                child: kIsWeb
                    ? Image.memory(showImageForWeb!)
                    : Image.file(showImage!))
            : const SizedBox(),
        ElevatedButton(onPressed: chooseFile, child: const Text('Upload file'))
      ],
    );
  }
}
