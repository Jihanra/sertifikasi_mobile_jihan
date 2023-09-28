import 'package:flutter/material.dart';
import 'package:sertifikasi_mobile_jihan/data/database_helper.dart';
import 'package:sertifikasi_mobile_jihan/screens/loginpage.dart';

class SettingPage extends StatefulWidget {
  final int id_user;
  const SettingPage({Key? key, required this.id_user}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                  ),
                  child: const Text(
                    "Ganti Password",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),

            //FORM GANTI PASSWORD
            TextField(
              controller: passwordController,
              onChanged: (value) {
                setState(() => null);
              },
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password Saat Ini",
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            TextField(
              controller: newPasswordController,
              onChanged: (value) {
                setState(() => null);
              },
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password Baru",
                prefixIcon: Icon(Icons.lock_reset),
              ),
            ),

            const SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  width: double.infinity,

                  //BUTTON SIMPAN
                  child: ElevatedButton(
                    onPressed: () async {
                      if (passwordController.text.isEmpty ||
                          newPasswordController.text.isEmpty) {
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
                        await DatabaseHelper().changePassword(
                          widget.id_user,
                          passwordController.text,
                          newPasswordController.text,
                          context,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF54C571),
                    ),
                    child: const Text('Simpan',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                  ),
                ),
                SizedBox(
                  width: double.infinity,

                  //BUTON KEMBALI
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    child: const Text('Kembali'),
                  ),
                ),
                SizedBox(
                  width: double.infinity,

                  //BUTTON LOGOUT
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const LoginPage()));
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                    ),
                    child: const Text('Log Out'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            //FOOTER INDENTITAS
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Container(
                    width: 110,
                    height: 160,
                    child: Image.asset(
                        'lib/image/2141764034_Jihan Rahadatul Aisy.jpg',
                        fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(width: 20),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About This App..',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Aplikasi ini dibuat oleh: ',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Nama : Jihan Rahadatul Aisy',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'NIM : 2141764034',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Tanggal : 23 September 2023',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
