// ignore: file_names

import 'package:flutter/material.dart';
import '../loginPage.dart';
import '../service/globalVar.dart';
import 'profilePage.dart';
import 'showKependudukan.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = GlobalVar.userName;
  late Future user;
  int count = 0;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const HomePage()));
      } else if (_selectedIndex == 1) {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ShowKependudukan()));
      } else if (_selectedIndex == 2) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Profile()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        //   appBar: AppBar(
        //   title: const Text(
        //     "Booking Kelas",
        //     style: TextStyle(color: Colors.white),
        //   ),
        //   backgroundColor: Color.fromRGBO(88, 129, 87, 1),
        //   // backgroundColor: Colors.transparent,
        //   automaticallyImplyLeading: false,
        // ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                // Color.fromRGBO(52, 78, 65, 1),
                // Color.fromRGBO(163, 177, 138, 1),
                // Color.fromRGBO(233, 237, 201, 1),
                // Color.fromRGBO(233, 237, 201, 1),
                Colors.white,
                Colors.white,
                Colors.white,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Halaman Utama,",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Kayuhan Kulon Mobile App",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      colors: [
                        // Colors.white,
                        // Colors.white,
                        // Colors.white,
                        Color.fromRGBO(250, 237, 205, 1),
                        Color.fromRGBO(250, 237, 205, 1),
                        Color.fromRGBO(250, 237, 205, 1),
                      ],
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Halo,",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "Selamat datang, "+userName,
                            style: TextStyle(color: Colors.black, fontSize: 20),
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
                                    primary: Color.fromRGBO(173, 193, 120, 1),
                                    onPrimary: Colors.white,
                                    textStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ShowKependudukan()));
                                  },
                                  child: const Text('Data Kependudukan'),
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
                                primary: Color.fromRGBO(173, 193, 120, 1),
                                onPrimary: Colors.white,
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Profile()));
                              },
                              child: const Text('Profile RT'),
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
                                primary: Color.fromRGBO(255, 0, 0, .7),
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
                              child: const Text('Keluar'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_alt_rounded),
              label: 'Kependudukan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.holiday_village_rounded),
              label: 'Profile RT',
            ),
          ],
          currentIndex: _selectedIndex,
          unselectedItemColor: Colors.grey,
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
          selectedItemColor: Color.fromRGBO(169, 132, 103, 1),
          showUnselectedLabels: false,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
