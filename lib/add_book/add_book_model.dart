import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddBookModel extends ChangeNotifier {
  String? title;
  String? author;

  Future addBook() async {
    if (title == null || title!.isEmpty) {
      throw 'Require Book Title';
    }

    if (author == null || author!.isEmpty) {
      throw 'Require Book Author';
    }

    await FirebaseFirestore.instance.collection('books').add({
      'title': title,
      'author': author,
    });
  }
}
