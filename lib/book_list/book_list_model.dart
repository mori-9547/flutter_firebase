import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/domain/book.dart';

class BookListModel extends ChangeNotifier {
  final _bookCollection = FirebaseFirestore.instance.collection('books');

  List<Book>? books;

  void fetchBlookList() async {
    final QuerySnapshot snapshot = await _bookCollection.get();

    final List<Book> books = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
      final String id = document.id;
      final String title = data['title'];
      final String author = data['author'];
      final String? imgUrl = data['imgUrl'];
      return Book(id, title, author, imgUrl);
    }).toList();

    this.books = books;
    notifyListeners();
  }

  Future delete(Book book) {
    return FirebaseFirestore.instance.collection('books').doc(book.id).delete();
  }
}
