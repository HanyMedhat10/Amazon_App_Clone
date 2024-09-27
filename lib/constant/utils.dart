import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void showSnackBar(BuildContext context, String text, {bool error = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: error ? Colors.red : Colors.green,
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
    ),
  );
}

Future<List<File>> pickImages() async {
  List<File> images = [];
  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        images.add(File(files.files[i].path!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}
  // return await showModalBottomSheet(
  //   context: Get.context!,
  //   builder: (context) => Column(
  //     children: [
  //       ListTile(
  //         title: const Text('Take a photo'),
  //         leading: const Icon(Icons.camera),
  //         onTap: () {},
  //       ),
  //       ListTile(
  //         title: const Text('Choose from gallery'),
  //         leading: const Icon(Icons.image),
  //         onTap: () {},
  //       ),
  //     ],
  //   ),
  // );

