import 'package:flutter/material.dart';
import 'package:flutter_firebase/domain/book.dart';
import 'package:provider/provider.dart';
import 'edit_book_model.dart';

class EditBookPage extends StatelessWidget {
  final Book book;
  EditBookPage(this.book);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditBookModel>(
      create: (_) => EditBookModel(book),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Book'),
        ),
        body: Center(
          child: Consumer<EditBookModel>(builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: model.titleController,
                    decoration: const InputDecoration(
                      hintText: 'Book Title',
                    ),
                    onChanged: (text) {
                      model.setTitle(text);
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: model.authorController,
                    decoration: const InputDecoration(
                      hintText: 'Book Author',
                    ),
                    onChanged: (text) {
                      model.setTitle(text);
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                      onPressed: model.isUpdated()
                          ? () async {
                              try {
                                await model.update();
                                Navigator.of(context).pop(model.title);
                              } catch (e) {
                                final snackBar = SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(e.toString()),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            }
                          : null,
                      child: const Text('Edit'))
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
