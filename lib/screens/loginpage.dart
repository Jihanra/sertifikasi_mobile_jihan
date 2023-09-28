import 'package:flutter/material.dart';
import 'package:sertifikasi_mobile_jihan/data/database_helper.dart';
import 'package:sertifikasi_mobile_jihan/screens/homepage.dart';
import 'package:sertifikasi_mobile_jihan/screens/signuppage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

TextEditingController usernameController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: AppBar(
          toolbarHeight: 10,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Column(children: [
            
            //LOGO
            Image.asset(
              'lib/image/icon.png',
              height: 200.0,
              width: 200.0,
            ),

            //TEXT LOGO
            const Text(
              "Nusakas",
              style: TextStyle(
                color: Color(0xFF000000),
                fontSize: 29,
              ),
              textAlign: TextAlign.center,
            ),

            //FORM LOGIN
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              margin: const EdgeInsets.only(top: 10.0),
              child: TextFormField(
                controller: usernameController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              margin: const EdgeInsets.only(top: 10.0),
              child: TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
            ),

            //BUTTON LOGIN
            Container(
              padding: const EdgeInsets.only(top: 30, bottom: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2B60DE),
                  fixedSize: const Size(300, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () async {
                  if (usernameController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Error'),
                          content: const Text('Data tidak boleh kosong.'),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    DatabaseHelper().login(usernameController.text,
                        passwordController.text, context);
                  }
                },
                child: const Text('Login'),
              ),
            ),

            //TEXT BLM PUNYA AKUN
            const Text(
              "Belum punya Akun?",
              style: TextStyle(
                color: Color(0xFF000000),
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            ),

            //BUTTON SIGNUP
            Container(
              padding: const EdgeInsets.only(top: 5, bottom: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2B60DE),
                  fixedSize: const Size(300, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const SignupPage()));
                },
                child: const Text('Sign Up'),
              ),
            ),
          ])
        ])));
  }
}
