import 'package:flutter/material.dart';
import 'package:flutter_firebase/domain/book.dart';
import 'package:provider/provider.dart';
import 'edit_book_model.dart';

class EditBookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditBookModel>(
      create: (_) => EditBookModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Book'),
        ),
        body: Center(
          child: Consumer<EditBookModel>(builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Book Title',
                    ),
                    onChanged: (text) {
                      model.title = text;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Book Author',
                    ),
                    onChanged: (text) {
                      model.author = text;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        try {
                          await model.update();
                          Navigator.of(context).pop(true);
                        } catch (e) {
                          final snackBar = SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(e.toString()),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
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
