import 'dart:convert';

import 'package:db_oilab/LoginPage.dart';
import 'package:db_oilab/categoriesPage.dart';

import 'package:http/http.dart' as http;
import 'Color.dart';
import 'package:flutter/material.dart';

import 'AddEditPage.dart';
import 'AjoutClientPage.dart';

class PageProfessionnels extends StatefulWidget {
  const PageProfessionnels({super.key});

  @override
  // ignore: library_private_types_in_public_api
  PageProfessionnelsState createState() => PageProfessionnelsState();
}

class PageProfessionnelsState extends State<PageProfessionnels> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

// ignore: unused_field
  final List _screens = [
    {"screen": CategoriesPage()},
    {"screen": const ListeProfessionnels()},
    {"screen": LoginPage()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 14,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: const Color.fromRGBO(241, 238, 146, 1),
        selectedItemColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            label: 'Retour',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list,
              color: Colors.black,
            ),
            label: 'Professionnels',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app, color: Colors.black),
            label: 'Exit',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: _screens[_selectedIndex]["screen"],
    );
  }
}

class ListeProfessionnels extends StatefulWidget {
  const ListeProfessionnels({super.key});

  @override
  // ignore: library_private_types_in_public_api
  ListeProfessionnelsState createState() => ListeProfessionnelsState();
}

class ListeProfessionnelsState extends State<ListeProfessionnels> {
  Future getProfessionnels() async {
    var url = 'http://localhost:80/exp/read-professionnels.php';

    var response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
    getProfessionnels();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Liste des professionnels',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromRGBO(124, 137, 58, 1),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WriteSQLdata(),
              ),
            ).then((value) => getProfessionnels());
          },
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 11),
          child: FutureBuilder(
            future: getProfessionnels(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        List list = snapshot.data;
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                color: (const Color.fromRGBO(241, 238, 146, 1)),
                                child: ListTile(
                                  hoverColor: Colors.yellow,
                                  leading: GestureDetector(
                                    child: const Icon(
                                      Icons.edit,
                                      color: Color.fromARGB(255, 12, 19, 2),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AddEditPage(
                                            list: list,
                                            index: index,
                                          ),
                                        ),
                                      );
                                      debugPrint('Edit Clicked');
                                    },
                                  ),
                                  title: Text(
                                    list[index]['nom'].toString().toUpperCase(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 89, 89, 89)),
                                  ),
                                  subtitle: Text(list[index]['adresse']),
                                  trailing: GestureDetector(
                                    child: const Icon(Icons.delete,
                                        color: Color.fromARGB(255, 12, 19, 2)),
                                    onTap: () {
                                      setState(() {
                                        var url =
                                            'http://localhost/exp/delete.php';
                                        http.post(Uri.parse(url), body: {
                                          'id': list[index]['id'],
                                        });
                                      });
                                      debugPrint('delete Clicked');
                                    },
                                  ),
                                )));
                      })
                  : const CircularProgressIndicator();
            },
          ),
        ));
  }
}
