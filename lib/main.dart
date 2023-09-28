import 'package:flutter/material.dart';
import 'package:sertifikasi_mobile_jihan/screens/loginpage.dart';
import 'package:sertifikasi_mobile_jihan/data/database_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi database
  await DatabaseHelper();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nusakas',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
