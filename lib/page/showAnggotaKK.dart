// ignore: file_names

import 'package:flutter/material.dart';
import 'package:kayuhan_kulon/Model/angotaKeluarga.dart';
import 'package:kayuhan_kulon/service/anggotaKeluarga.dart';
import 'package:kayuhan_kulon/service/globalVar.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:intl/intl.dart';
import 'homePage.dart';
import 'profilePage.dart';
import 'showKependudukan.dart';

// ignore: must_be_immutable
class ShowAnggotaKK extends StatefulWidget {
  const ShowAnggotaKK({Key? key}) : super(key: key);

  @override
  _ShowAnggotaKKState createState() => _ShowAnggotaKKState();
}

class _ShowAnggotaKKState extends State<ShowAnggotaKK> {
  AnggotaKeluargaApi dataAnggota = AnggotaKeluargaApi();
  int idUser = GlobalVar.userID;
  int idKK = DetailGlobal.idKK;
  int _selectedIndex = 1;
  bool isLoading = true;
  late Future dataKeluarga;
  List<AnggotaKeluarga> listDataKK = [];

  void refreshData() {
    dataKeluarga = dataAnggota.getData(idKK);
    dataKeluarga.then((value) {
      setState(() {
        listDataKK = value;
      });
    });
  }

  @override
  void initState() {
    dataKeluarga = dataAnggota.getData(idKK);
    dataKeluarga.then((value) {
      setState(() {
        refreshData();
        listDataKK = value;
        isLoading = false;
      });
    });
    super.initState();
  }

  Future<void> refresh() async {
    final startTime = DateTime.now();
    refreshData();
    final endTime = DateTime.now();
    final executionTime = endTime.difference(startTime).inMilliseconds;

    if (executionTime < 1000) {
      await Future.delayed(Duration(milliseconds: 1000 - executionTime));
    }
  }

  String formatDate(String inputDate) {
    DateTime date = DateTime.parse(inputDate);
    String formattedDate = DateFormat('dd-MM-yyyy').format(date);
    return formattedDate;
  }

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
      appBar: AppBar(
        title: const Text(
          "Data Anggota Keluarga",
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
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color.fromRGBO(169, 132, 103, 1),
              ),
            )
          : LiquidPullToRefresh(
              onRefresh: refresh,
              color: Color.fromRGBO(169, 132, 103, 1),
              // backgroundColor: const Color(0xFFFFC300),
              backgroundColor: Color.fromRGBO(255, 255, 255, 1),
              height: 300,
              animSpeedFactor: 2,
              showChildOpacityTransition: true,
              child: listDataKK.isEmpty
                  ? Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Data Kosong",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                          const Text('\u{1F614}',
                              style: TextStyle(fontSize: 30)),
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
                                refresh();
                              },
                              child: const Text('Segarkan'),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: listDataKK.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Material(
                            color: const Color.fromRGBO(212, 163, 115, .5),
                            borderRadius: BorderRadius.circular(10),
                            child: ListTile(
                              title: Text("Nama              \t: " +
                                  listDataKK[index].namaLengkap),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Jenis Kelamin     \t: " +
                                      listDataKK[index].jenisKelamin),
                                  Text("Tempat Lahir       \t: " +
                                      listDataKK[index].tempatLahir),
                                  Text("Tanggal Lahir      \t: " +
                                      formatDate(listDataKK[index]
                                          .tanggalLahir
                                          .toIso8601String())),
                                  Text("Agama                 \t: " +
                                      listDataKK[index].agama),
                                ],
                              ),
                              trailing: PopupMenuButton<String>(
                                onSelected: (value) {
                                  if (value == 'Hapus') {
                                    Alert(
                                        context: context,
                                        style: AlertStyle(
                                          backgroundColor: Colors.white,
                                          isCloseButton: false,
                                          alertBorder: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            side: const BorderSide(
                                              color: Color(0xff000814),
                                              width: 4,
                                            ),
                                          ),
                                          descStyle: TextStyle(fontSize: 14),
                                        ),
                                        title: "Hapus Data",
                                        desc:
                                            "Apakah anda yakin ingin menghapus data ini?",
                                        type: AlertType.warning,
                                        buttons: [
                                          DialogButton(
                                              radius: BorderRadius.circular(10),
                                              color: Colors.green,
                                              child: const Text(
                                                "Confirm",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                dataAnggota
                                                    .delete(listDataKK[index]
                                                        .id
                                                        .toString())
                                                    .then((value) {
                                                  setState(() {
                                                    if (value) {
                                                      Alert(
                                                          context: context,
                                                          style: AlertStyle(
                                                            backgroundColor:
                                                                Colors.white,
                                                            isCloseButton:
                                                                false,
                                                            alertBorder:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30),
                                                              side:
                                                                  const BorderSide(
                                                                color: Color(
                                                                    0xff000814),
                                                                width: 4,
                                                              ),
                                                            ),
                                                            // descStyle: TextStyle(fontSize: 14),
                                                          ),
                                                          title: "Terhapus!",
                                                          type:
                                                              AlertType.success,
                                                          buttons: [
                                                            DialogButton(
                                                                radius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: Colors
                                                                    .green,
                                                                child:
                                                                    const Text(
                                                                  "OK",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                  refreshData();
                                                                }),
                                                          ]).show();
                                                    } else {
                                                      Alert(
                                                          context: context,
                                                          style: AlertStyle(
                                                            backgroundColor:
                                                                Colors.white,
                                                            isCloseButton:
                                                                false,
                                                            alertBorder:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30),
                                                              side:
                                                                  const BorderSide(
                                                                color: Color(
                                                                    0xff000814),
                                                                width: 4,
                                                              ),
                                                            ),
                                                            // descStyle: TextStyle(fontSize: 14),
                                                          ),
                                                          title:
                                                              "Gagal Menghapus Data!",
                                                          type: AlertType.error,
                                                          buttons: [
                                                            DialogButton(
                                                                radius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: Colors
                                                                    .green,
                                                                child:
                                                                    const Text(
                                                                  "OK",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                  refreshData();
                                                                }),
                                                          ]).show();
                                                    }
                                                  });
                                                });
                                              }),
                                          DialogButton(
                                              radius: BorderRadius.circular(10),
                                              color: Colors.red,
                                              child: const Text(
                                                "Batal",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              }),
                                        ]).show();
                                  }
                                },
                                itemBuilder: (BuildContext context) {
                                  return <PopupMenuEntry<String>>[
                                    const PopupMenuItem<String>(
                                      value: 'Hapus',
                                      child: ListTile(
                                        trailing: Icon(Icons.delete_forever),
                                        iconColor: Colors.red,
                                        title: Text('Hapus'),
                                      ),
                                    ),
                                  ];
                                },
                              ),
                            ),
                          ),
                        );
                      }),
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
}
