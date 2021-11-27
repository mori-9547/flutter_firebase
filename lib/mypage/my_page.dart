import 'package:flutter/material.dart';
import 'package:flutter_firebase/edit_profile/edit_profile_page.dart';
import 'package:provider/provider.dart';
import 'my_model.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyModel>(
      create: (_) => MyModel()..fetchUser(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Page'),
          actions: [
            Consumer<MyModel>(builder: (context, model, child) {
              return IconButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EditProfilePage(model.name!, model.description!),
                    ),
                  );
                  model.fetchUser();
                },
                icon: const Icon(Icons.edit),
              );
            })
          ],
        ),
        body: Center(
          child: Consumer<MyModel>(builder: (context, model, child) {
            return Stack(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      model.name ?? 'Name is null',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(model.email ?? 'No mail address'),
                    Text(model.description ?? 'Description is null'),
                    TextButton(
                      onPressed: () async {
                        await model.logout();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Logout'),
                    )
                  ],
                ),
              ),
              if (model.isLoading)
                Container(
                  color: Colors.black54,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ]);
          }),
        ),
      ),
    );
  }
}
