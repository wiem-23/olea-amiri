// ignore_for_file: file_names

import 'package:db_oilab/AjoutTestPage.dart';
import 'package:db_oilab/ListeTests.dart';
import 'package:db_oilab/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'ListClients.dart';
import 'AddEditTest.dart';

class AddEditPage extends StatefulWidget {
  final List list;
  final int index;
  const AddEditPage({super.key, required this.list, required this.index});
  @override
  // ignore: library_private_types_in_public_api
  _AddEditPageState createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  TextEditingController nom = TextEditingController();
  TextEditingController adresse = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController tel = TextEditingController();
  TextEditingController id = TextEditingController();
  bool editMode = false;

  addUpdateData() {
    if (editMode) {
      var url = 'http://localhost/exp/edit.php';
      http.post(Uri.parse(url), body: {
        'id_client': widget.list[widget.index]['id_client'],
        'nom': nom.text,
        'adresse': adresse.text,
        'type': type.text,
        'tel': tel.text,
      });
    } else {
      var url = 'http://localhost/exp/add.php';
      http.post(Uri.parse(url), body: {
        'nom': nom.text,
        'adresse': adresse.text,
        'type': type.text,
        'tel': tel.text,
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // ignore: unnecessary_null_comparison
    if (widget.index != null) {
      editMode = true;

      nom.text = widget.list[widget.index]['nom'];
      adresse.text = widget.list[widget.index]['adresse'];
      type.text = widget.list[widget.index]['type'];
      tel.text = widget.list[widget.index]['tel'];
      id.text = widget.list[widget.index]['id_client'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(editMode ? 'Update' : 'Add Data'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: nom,
              decoration: const InputDecoration(
                labelText: 'nom ',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: adresse,
              decoration: const InputDecoration(
                labelText: 'adresse',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: type,
              decoration: const InputDecoration(
                labelText: 'type',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: tel,
              decoration: const InputDecoration(
                labelText: 'tel',
              ),
            ),
          ),
          editMode
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: id,
                    decoration: const InputDecoration(
                      labelText: 'id',
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8),
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        addUpdateData();
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListClients(),
                        ),
                      );
                      debugPrint('Clicked RaisedButton Button');
                    },
                    color: Colors.blue,
                    child: Text(
                      editMode ? 'Update' : 'Save',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AjoutTest(id_client: int.parse(id.text)),
                  ),
                );
                debugPrint('Clicked RaisedButton Button');
              },
              color: Colors.blue,
              child: Text(
                editMode ? 'Tester' : 'Save',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
