// ignore: file_names

import 'package:flutter/material.dart';
import 'package:kayuhan_kulon/service/registerApi.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../loginPage.dart';

// ignore: must_be_immutable
class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool passwordVisible = true;
  RegisterApi userRegisterApi = RegisterApi();
  late Future user;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Color.fromRGBO(52, 78, 65, 1),
                Color.fromRGBO(163, 177, 138, 1),
                Color.fromRGBO(218, 215, 205, 1),
                // Color(0xffFFC300),
                // Color(0xffFFD60A),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 80,
              ),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Kayuhan Kulon",
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                    Text(
                      "Register",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      colors: [
                        Colors.white,
                        Colors.white,
                        Colors.white,
                        // Color.fromRGBO(217, 159, 134, .5),
                        // Color.fromRGBO(217, 159, 134, .5),
                        // Color.fromRGBO(217, 159, 134, .5)
                      ],
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 53, 102, 0.5),
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.shade200),
                                    ),
                                  ),
                                  child: TextField(
                                    controller: namaController,
                                    decoration: const InputDecoration(
                                      hintText: "Nama",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.shade200),
                                    ),
                                  ),
                                  child: TextField(
                                    controller: roleController,
                                    decoration: const InputDecoration(
                                      hintText: "Jabatan",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.shade200),
                                    ),
                                  ),
                                  child: TextField(
                                    controller: passwordController,
                                    obscureText: passwordVisible,
                                    decoration: InputDecoration(
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none,
                                        suffixIcon: IconButton(
                                          tooltip: passwordVisible
                                              ? "Show password"
                                              : "Hide password",
                                          onPressed: () {
                                            setState(() {
                                              passwordVisible =
                                                  !passwordVisible;
                                            });
                                          },
                                          icon: Icon(
                                            passwordVisible
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                          ),
                                        )),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Container(
                            height: 50,
                            margin: const EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color(0xff000814),
                            ),
                            child: Center(
                              child: Container(
                                height: 50,
                                width: 300,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    //button color
                                    primary: Color.fromRGBO(88, 129, 87, 1),
                                    onPrimary: Colors.white,
                                    textStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {
                                    userRegisterApi
                                        .registerUser(
                                            namaController.text,
                                            roleController.text,
                                            passwordController.text)
                                        .then((value) {
                                      if (value) {
                                        Alert(
                                            context: context,
                                            style: AlertStyle(
                                              backgroundColor: Colors.white,
                                              isCloseButton: false,
                                              alertBorder:
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                side: const BorderSide(
                                                  color: Color.fromRGBO(88, 129, 87, 1),
                                                  width: 4,
                                                ),
                                              ),
                                              descStyle:
                                                  TextStyle(fontSize: 14),
                                            ),
                                            title: "Akun Berhasil Dibuat",
                                            type: AlertType.success,
                                            buttons: [
                                              DialogButton(
                                                  radius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.green,
                                                  child: const Text(
                                                    "OK",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .popUntil((_) =>
                                                            count++ >= 2);
                                                  }),
                                            ]).show();
                                      } else {
                                        Alert(
                                            context: context,
                                            style: AlertStyle(
                                              backgroundColor: Colors.white,
                                              isCloseButton: false,
                                              alertBorder:
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                side: const BorderSide(
                                                  color: Color.fromRGBO(212, 163, 115, 1),
                                                  width: 4,
                                                ),
                                              ),
                                              descStyle:
                                                  TextStyle(fontSize: 14),
                                            ),
                                            title: "Gagal Membuat Akun",
                                            type: AlertType.error,
                                            buttons: [
                                              DialogButton(
                                                  radius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.green,
                                                  child: const Text(
                                                    "OK",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  }),
                                            ]).show();
                                      }
                                    });
                                  },
                                  child: const Text('Buat Akun'),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 50,
                            width: 240,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                //button color
                                primary: Color.fromRGBO(255, 0, 0, .6),
                                onPrimary: Colors.white,
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Login()));
                              },
                              child: const Text('Batal'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
