import 'package:flutter/material.dart';
import 'package:sertifikasi_mobile_jihan/data/database_helper.dart';
import 'package:sertifikasi_mobile_jihan/screens/settingpage.dart';
import 'cashflowpage.dart';
import 'incomepage.dart';
import 'outcomepage.dart';

class HomePage extends StatefulWidget {
  final int id_user;
  const HomePage({Key? key, required this.id_user}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<int> income;
  late Future<int> outcome;
  late Future<String> name;

  @override
  void initState() {
    super.initState();
    income = DatabaseHelper().totalIncome(id_user: widget.id_user);
    outcome = DatabaseHelper().totalOutcome(id_user: widget.id_user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          
          //INFO DIATAS
          FutureBuilder<int>(
            future: income,
            builder: (context, incomeSnapshot) {
              if (incomeSnapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (incomeSnapshot.hasError) {
                return Text("Error: ${incomeSnapshot.error}");
              } else {
                return FutureBuilder<int>(
                  future: outcome,
                  builder: (context, outcomeSnapshot) {
                    if (outcomeSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (outcomeSnapshot.hasError) {
                      return Text("Error: ${outcomeSnapshot.error}");
                    } else {
                      return Column(
                        children: [
                          Text(
                            "Pengeluaran: Rp. ${outcomeSnapshot.data}",
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.red,
                            ),
                          ),
                          Text(
                            "Pemasukan: Rp. ${incomeSnapshot.data}",
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      );
                    }
                  },
                );
              }
            },
          ),

          //GRAFIK
          Image.asset(
            'lib/image/grafik.png',
            height: 150.0,
            width: 130.0,
          ),

          //MENU
          GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            shrinkWrap: true,
            padding: const EdgeInsets.all(30),
            mainAxisSpacing: 50,
            crossAxisSpacing: 50,
            children: <Widget>[
              
              //MENU PEMASUKAN
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IncomePage(
                        id_user: widget.id_user,
                      ),
                    ),
                  );
                },
                child: const Text('Pemasukan'),
              ),

              //MENU PENGELUARAN
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OutcomePage(
                        id_user: widget.id_user,
                      ),
                    ),
                  );
                },
                child: const Text('Pengeluaran'),
              ),

              //MENU DETAIL CASHFLOW
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CashFlowPage(
                        id_user: widget.id_user,
                      ),
                    ),
                  );
                },
                child: const Text('Detail Cash Flow'),
              ),

              //MENU SETTINGS
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingPage(
                        id_user: widget.id_user,
                      ),
                    ),
                  );
                },
                child: const Text('Setting'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
