import 'package:flutter/material.dart';
import 'package:flutter_firebase/add_book/add_book_page.dart';
import 'package:flutter_firebase/domain/book.dart';
import 'package:provider/provider.dart';
import 'book_list_model.dart';

class BookListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookListModel>(
      create: (_) => BookListModel()..fetchBlookList(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Book List'),
        ),
        body: Center(
          child: Consumer<BookListModel>(builder: (context, model, child) {
            final List<Book>? books = model.books;

            if (books == null) {
              return const CircularProgressIndicator();
            }

            final List<Widget> widgets = books
                .map(
                  (book) => ListTile(
                    title: Text(book.title),
                    subtitle: Text(book.author),
                  ),
                )
                .toList();
            return ListView(
              children: widgets,
            );
          }),
        ),
        floatingActionButton:
            Consumer<BookListModel>(builder: (context, model, child) {
          return FloatingActionButton(
            onPressed: () async {
              final bool? added = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddBookPage(),
                  fullscreenDialog: true,
                ),
              );

              if (added != null && added) {
                const snackBar = SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('Add Book Sccessfully!'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }

              model.fetchBlookList();
            },
            child: const Icon(Icons.add),
          );
        }), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
