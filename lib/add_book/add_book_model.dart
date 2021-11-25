import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddBookModel extends ChangeNotifier {
  String? title;
  String? author;
  File? imageFile;
  bool isLoading = false;

  final picker = ImagePicker();

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future addBook() async {
    if (title == null || title!.isEmpty) {
      throw 'Require Book Title';
    }

    if (author == null || author!.isEmpty) {
      throw 'Require Book Author';
    }

    final doc = FirebaseFirestore.instance.collection('books').doc();
    String? imgUrl;
    if (imageFile != null) {
      final task = await FirebaseStorage.instance
          .ref('books/${doc.id}')
          .putFile(imageFile!);
      imgUrl = await task.ref.getDownloadURL();
    }

    await FirebaseFirestore.instance.collection('books').add({
      'title': title,
      'author': author,
      'imgUrl': imgUrl,
    });
  }

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      notifyListeners();
    }
  }
}
