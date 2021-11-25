import 'package:flutter/material.dart';
import 'package:flutter_firebase/register/register_model.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterModel>(
      create: (_) => RegisterModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('User Register'),
        ),
        body: Center(
          child: Consumer<RegisterModel>(builder: (context, model, child) {
            return Stack(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      controller: model.emailController,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                      onChanged: (text) {
                        model.setEmail(text);
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: model.passwordController,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                      onChanged: (text) {
                        model.setPassword(text);
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          try {
                            model.startLoading();
                            await model.signup();
                            Navigator.of(context).pop();
                          } catch (e) {
                            final snackBar = SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(e.toString()),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } finally {
                            model.endLoading();
                          }
                        },
                        child: const Text('Register'))
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
