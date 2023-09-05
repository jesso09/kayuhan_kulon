import 'package:flutter/material.dart';
import 'package:kayuhan_kulon/loginPage.dart';
import 'package:kayuhan_kulon/page/homePage.dart';
import 'package:kayuhan_kulon/page/showKependudukan.dart';
import 'package:kayuhan_kulon/service/globalVar.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../Model/kartuKeluarga.dart';
import '../service/kartuKeluargaApi.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  KartuKeluargaApi kartuKeluargaApi = KartuKeluargaApi();
  late Future dataKeluarga;
  List<KartuKeluarga> listDataKK = [];
  int _selectedIndex = 2;
  int idUser = GlobalVar.userID;
  String nama = GlobalVar.userName;
  String role = GlobalVar.userRole;
  bool isLoading = true;
  int jumlahKK = 0;
  //data instruktur

  void initState() {
  dataKeluarga = kartuKeluargaApi.getDataKeluarga(idUser);
    dataKeluarga.then((value) {
      setState(() {
        listDataKK = value;
        isLoading = false;
        fetchInstrukturData();
      });
    });
    super.initState();
    
  }

void fetchInstrukturData() async {
    try {
      setState(() {
       jumlahKK = listDataKK.length;
        _items[0] = ProfileInfoItem("Jumlah KK", jumlahKK);
      });
        
    } catch (error) {
      print('Gagal mengambil data anggota: $error');
    }
  }

  final List<ProfileInfoItem> _items = [
    ProfileInfoItem("Jumlah KK", 0),
  ];

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
    return Scaffold(
      body: Column(
        children: [
          const Expanded(flex: 2, child: _TopPortion()),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton.extended(
                        onPressed: () {},
                        heroTag: 'role',
                        elevation: 0,
                        label: Text(nama),
                        icon: const Icon(Icons.person),
                        backgroundColor: const Color(0xFFFFC300),
                      ),
                      const SizedBox(width: 16.0),
                      FloatingActionButton.extended(
                        onPressed: () {},
                        heroTag: 'status',
                        elevation: 0,
                        backgroundColor: Colors.lightBlue,
                        label: Text(role),
                        icon: const Icon(Icons.email),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  // const _ProfileInfoRow(),
                  Container(
                    height: 80,
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: _items
                          .map((item) => Expanded(
                                  child: Row(
                                children: [
                                  if (_items.indexOf(item) != 0)
                                    const VerticalDivider(),
                                  Expanded(child: _singleItem(context, item)),
                                ],
                              )))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 180),
                  FloatingActionButton.extended(
                    onPressed: () {
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
                            descStyle: TextStyle(fontSize: 14),
                          ),
                          title: "Log Out",
                          desc: "Are you sure you want to log out?",
                          type: AlertType.info,
                          buttons: [
                            DialogButton(
                              radius: BorderRadius.circular(10),
                                color: Colors.green,
                                child: const Text(
                                  "Log Out",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Login()),
                                  );
                                }),
                            DialogButton(
                              radius: BorderRadius.circular(10),
                                color: Colors.red,
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          ]).show();
                    },
                    heroTag: 'logout',
                    elevation: 0,
                    backgroundColor: Color.fromRGBO(255, 0, 0, .7),
                    label: const Text("Keluar"),
                    icon: const Icon(Icons.logout),
                  ),
                ],
              ),
            ),
          ),
        ],
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
    );
  }

  Widget _singleItem(BuildContext context, ProfileInfoItem item) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.value.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Text(
            item.title,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      );
}

class ProfileInfoItem {
  final String title;
  final int value;
  const ProfileInfoItem(this.title, this.value);
}

class _TopPortion extends StatelessWidget {
  const _TopPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [const Color.fromRGBO(204, 213, 174, 1), Color.fromRGBO(212, 163, 115, 1), Color.fromRGBO(127, 85, 57, 1)]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                            'assets/icon.png')),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
