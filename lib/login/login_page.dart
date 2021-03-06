import 'package:flutter/material.dart';
import 'package:flutter_firebase/login/login_model.dart';
import 'package:flutter_firebase/register/register_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginModel>(
      create: (_) => LoginModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Center(
          child: Consumer<LoginModel>(builder: (context, model, child) {
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
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        model.startLoading();
                        try {
                          await model.login();
                          Navigator.of(context).pop();
                        } catch (e) {
                          final snackBar = SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(e.toString()),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } finally {
                          model.endLoading();
                          print('success');
                        }
                      },
                      child: const Text('Login'),
                    ),
                    TextButton(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                            fullscreenDialog: true,
                          ),
                        );
                      },
                      child: const Text('Register New User'),
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
