import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sertifikasi_mobile_jihan/data/database_helper.dart';
import 'package:sertifikasi_mobile_jihan/screens/homepage.dart';
import 'cashflowpage.dart';
import 'package:intl/intl.dart';

class OutcomePage extends StatefulWidget {
  final int id_user;
  const OutcomePage({Key? key, required this.id_user}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OutcomePageState createState() => _OutcomePageState();
}

class _OutcomePageState extends State<OutcomePage> {
  TextEditingController dateController = TextEditingController();
  TextEditingController nominalController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Pengeluaran'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 20),

            //FORM PENGELUARAN
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              margin: const EdgeInsets.only(top: 10.0),
              child: TextFormField(
                controller: dateController,
                onChanged: (value) => setState(() => null),
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Tanggal',
                  suffixIcon: IconButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(
                              2000), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101));

                      if (pickedDate != null) {
                        print(
                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(
                            formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                        setState(
                          () {
                            dateController.text =
                                formattedDate; //set output date to TextField value.
                          },
                        );
                      } else {
                        print("Date is not selected");
                      }
                    },
                    icon: const Icon(Icons.calendar_today),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              margin: const EdgeInsets.only(top: 10.0),
              child: TextFormField(
                controller: nominalController,
                onChanged: (value) => setState(() => null),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: const InputDecoration(
                  prefixText: 'Rp ',
                  labelText: 'Nominal',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              margin: const EdgeInsets.only(top: 10.0),
              child: TextFormField(
                controller: descriptionController,
                onChanged: (value) => setState(() => null),
                decoration: const InputDecoration(
                  labelText: 'Keterangan',
                ),
              ),
            ),
            const SizedBox(height: 20),

            //BUTTON RESET
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              margin: const EdgeInsets.only(top: 10.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFBB117),
                ),
                onPressed: () {
                  dateController.clear();
                  nominalController.clear();
                  descriptionController.clear();
                },
                child: const Text('Reset'),
              ),
            ),

            //BUTON SIMPAN
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              margin: const EdgeInsets.only(top: 10.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF54C571),
                ),
                onPressed: () async {
                  if (dateController.text.isEmpty ||
                      nominalController.text.isEmpty ||
                      descriptionController.text.isEmpty) {
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
                    DatabaseHelper().addOutcome(
                        widget.id_user,
                        dateController.text,
                        int.parse(nominalController.text),
                        descriptionController.text,
                        context);
                  }
                },
                child: const Text('Simpan'),
              ),
            ),
            
            //BUTTON KEMBALI
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              margin: const EdgeInsets.only(top: 10.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Kembali'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
