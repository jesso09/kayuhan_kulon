// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:kayuhan_kulon/page/registerPage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../service/globalVar.dart';
import 'page/homePage.dart';

// ignore: must_be_immutable
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // const Login({super.key});
  final TextEditingController roleController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String baseUrl = GlobalApi.getBaseUrl();
  bool passwordVisible = true;
  late String role;
  late String message;

  Future doLogin(String? role, String? password) async {
    Uri url = Uri.parse('${baseUrl}login');

    final response = await http.post(url, body: {
      "role": role,
      "password": password,
    });

    var userLoggedIn = json.decode(response.body);
    message = userLoggedIn['message'];
    if (response.statusCode == 200) {
      GlobalVar.userID = userLoggedIn['id'];
      GlobalVar.userName = userLoggedIn['nama'];
      GlobalVar.userRole = userLoggedIn['role'];
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
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
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 60,
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
                            height: 60,
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
                                    controller: roleController,
                                    decoration: const InputDecoration(
                                      hintText: "Jabatan (misal RT 09)",
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
                                            const TextStyle(color: Colors.grey),
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
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Register(),
                                ),
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Buat Akun',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            height: 50,
                            margin: const EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: const Color(0xff000814),
                            ),
                            child: Center(
                              child: Container(
                                height: 50,
                                width: 300,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    //button color
                                    primary: const Color.fromRGBO(88, 129, 87, 1),
                                    onPrimary: Colors.white,
                                    textStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {
                                    doLogin(roleController.text,
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
                                                  const TextStyle(fontSize: 14),
                                            ),
                                            title: "Berhasil Masuk",
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
                                                        .pushReplacement(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const HomePage()));
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
                                                  const TextStyle(fontSize: 14),
                                            ),
                                            title: message,
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
                                    // Navigator.of(context).push(MaterialPageRoute(
                                    //     builder: (context) => ShowMember()));
                                  },
                                  child: const Text('Masuk'),
                                ),
                              ),
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
