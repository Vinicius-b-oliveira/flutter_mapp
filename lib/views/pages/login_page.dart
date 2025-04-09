import 'package:flutter/material.dart';
import 'package:flutter_course/views/widget_tree.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController(text: '123');
  TextEditingController passwordController = TextEditingController(text: '456');
  String confirmedEmail = '123';
  String confirmedPw = '456';

  void onLoginPressed() {
    if (confirmedEmail != emailController.text) return;

    if (confirmedPw != passwordController.text) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => WidgetTree()),
      (route) => false,
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    Lottie.asset("assets/lotties/login.json"),
                    FractionallySizedBox(
                      widthFactor: screenWidth > 500 ? 0.5 : 1.0,
                      child: Column(
                        spacing: 20.0,
                        children: [
                          TextField(
                            controller: emailController,
                            onEditingComplete: () => setState(() {}),
                            decoration: InputDecoration(
                              hintText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          ),
                          TextField(
                            controller: passwordController,
                            onEditingComplete: () => setState(() {}),
                            decoration: InputDecoration(
                              hintText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          ),
                          FilledButton(
                            onPressed: () {
                              onLoginPressed();
                            },
                            style: FilledButton.styleFrom(
                              minimumSize: Size(double.infinity, 40.0),
                            ),
                            child: const Text("Login"),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
