import 'dart:convert';
import 'package:db_oilab/AddEditTest.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'AddEditPage.dart';
import 'AjoutClientPage.dart';

class ListeTests extends StatefulWidget {
  const ListeTests({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ListeTestsState createState() => _ListeTestsState();
}

class _ListeTestsState extends State<ListeTests> {
  Future getData() async {
    var url = 'http://localhost:80/exp/read-tests.php';

    var response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Php Mysql Crud'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WriteSQLdata(),
            ),
          ).then((value) => getData());
          debugPrint('Clicked FloatingActionButton Button');
        },
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    List list = snapshot.data;
                    return ListTile(
                      leading: GestureDetector(
                        child: const Icon(Icons.edit),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddEditTest(
                                list: list,
                                index: index,
                              ),
                            ),
                          );
                          debugPrint('Edit Clicked');
                        },
                      ),
                      title: Text(list[index]['results']),
                      subtitle: Text(list[index]['id_test']),
                      trailing: GestureDetector(
                        child: const Icon(Icons.delete),
                        onTap: () {
                          setState(() {
                            var url = 'http://localhost/exp/delete-test.php';
                            http.post(Uri.parse(url), body: {
                              'id_test': list[index]['id_test'],
                            });
                          });
                          debugPrint('delete Clicked');
                        },
                      ),
                    );
                  })
              : const CircularProgressIndicator();
        },
      ),
    );
  }
}
