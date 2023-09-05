// ignore_for_file: avoid_print, sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kayuhan_kulon/page/addAnggotaKK.dart';
import 'package:kayuhan_kulon/service/globalVar.dart';
import 'package:kayuhan_kulon/service/kartuKeluargaApi.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'showKependudukan.dart';

class AddKK extends StatefulWidget {
  const AddKK({super.key});

  @override
  State<AddKK> createState() => _AddKKState();
}

class _AddKKState extends State<AddKK> {
  KartuKeluargaApi kartuKeluargaApi = KartuKeluargaApi();
  final TextEditingController kepalaKKController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController nikController = TextEditingController();
  int idUser = GlobalVar.userID;
  String roleUser = GlobalVar.userRole;
  String userName = GlobalVar.userName;
  int count = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Tambah Data KK",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color.fromRGBO(169, 132, 103, 1),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
                child: Column(
              children: [
                Theme(
                  data: ThemeData(
                      inputDecorationTheme: InputDecorationTheme(
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.3),
                    labelStyle: TextStyle(
                      color: Colors.black.withOpacity(1),
                    ),
                  )),
                  child: Column(
                    children: [
                      TextFormField(
                        enabled: false,
                        autocorrect: false,
                        autofocus: true,
                        readOnly: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: roleUser + " - " + userName),
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: "NIK"),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        controller: nikController,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: "Nama Kepala Keluarga"),
                        textInputAction: TextInputAction.next,
                        controller: kepalaKKController,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: "Alamat"),
                        textInputAction: TextInputAction.next,
                        controller: alamatController,
                      ),
                    ],
                  ),
                ),

                //Save Button
                SizedBox(height: 50),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      kartuKeluargaApi
                          .tambahData(idUser, kepalaKKController.text,
                              alamatController.text, nikController.text)
                          .then((value) {
                        setState(() {
                          if (value) {
                            Alert(
                                context: context,
                                title: "Data Added",
                                style: AlertStyle(
                                  backgroundColor: Colors.white,
                                  isCloseButton: false,
                                  alertBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: const BorderSide(
                                      color: Color(0xff000814),
                                      width: 4,
                                    ),
                                  ),
                                ),
                                type: AlertType.success,
                                buttons: [
                                  DialogButton(
                                      radius: BorderRadius.circular(10),
                                      color: Colors.green,
                                      child: Text("OK"),
                                      onPressed: () {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ShowKependudukan()),
                                            (Route<dynamic> route) => false);
                                      }),
                                ]).show();
                          } else {
                            Alert(
                                context: context,
                                style: AlertStyle(
                                  backgroundColor: Colors.white,
                                  isCloseButton: false,
                                  alertBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: const BorderSide(
                                      color: Color(0xff000814),
                                      width: 4,
                                    ),
                                  ),
                                ),
                                title: "Failed Adding Data",
                                type: AlertType.error,
                                buttons: [
                                  DialogButton(
                                      radius: BorderRadius.circular(10),
                                      color: Colors.green,
                                      child: Text("OK"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }),
                                ]).show();
                          }
                        });
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromRGBO(173, 193, 120, 1),
                      ),
                    ),
                    child: Text(
                      "Buat Data",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddAnggotaKK()));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromRGBO(173, 193, 120, 1),
                      ),
                    ),
                    child: Text(
                      "Tambah Anggota Keluarga",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )),
          ),
        ));
  }
}
