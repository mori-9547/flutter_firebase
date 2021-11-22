import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/domain/book.dart';

class BookListModel extends ChangeNotifier {
  // final Stream<QuerySnapshot> _booksStream =
  //     FirebaseFirestore.instance.collection('books').snapshots();
  final _bookCollection = FirebaseFirestore.instance.collection('books');

  List<Book>? books;

  void fetchBlookList() async {
    final QuerySnapshot snapshot = await _bookCollection.get();

    final List<Book> books = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
      final String id = document.id;
      final String title = data['title'];
      final String author = data['author'];
      return Book(id, title, author);
    }).toList();

    // _booksStream.listen((QuerySnapshot snapshot) {
    // final List<Book> books = snapshot.docs.map((DocumentSnapshot document) {
    //   Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    //   final String title = data['title'];
    //   final String author = data['author'];
    //   return Book(title, author);
    // }).toList();
    this.books = books;
    notifyListeners();
    // });
  }
}
