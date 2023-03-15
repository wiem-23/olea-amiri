// ignore_for_file: file_names

import 'dart:convert';

import 'package:db_oilab/ListeTests.dart';
import 'package:db_oilab/ResultatWidgetPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'ListClients.dart';

class AddEditTest extends StatefulWidget {
  final List list;
  final int index;
  const AddEditTest({super.key, required this.list, required this.index});
  @override
  // ignore: library_private_types_in_public_api
  _AddEditTestState createState() => _AddEditTestState();
}

class _AddEditTestState extends State<AddEditTest> {
  TextEditingController aciditectl = TextEditingController();
  TextEditingController fruitectl = TextEditingController();
  TextEditingController defautctl = TextEditingController();

  TextEditingController polyphenolctl = TextEditingController();
  TextEditingController tocopherolctl = TextEditingController();
  TextEditingController solctl = TextEditingController();
  TextEditingController regionctl = TextEditingController();
  TextEditingController degustectl = TextEditingController();
  TextEditingController varietectl = TextEditingController();
  TextEditingController resultctl = TextEditingController();
  bool editMode = false;

  addUpdateTest() {
    if (editMode) {
      var url = 'http://localhost/exp/edit.php';
      http.post(Uri.parse(url), body: {
        'id_test': widget.list[widget.index]['id_test'],
        "sol": solctl.text,
        "region": regionctl.text,
        "variete": varietectl.text,
        "deguste": degustectl.text,
        "polyphenol": polyphenolctl.text,
        "tocopherol": tocopherolctl.text,
        "defaut": defautctl.text,
        "fruite": fruitectl.text,
        "acidite": aciditectl.text,
        "results": widget.list[widget.index]['results'],
        'id_client': widget.list[widget.index]['id_client'],
      });
    } else {
      var url = 'http://localhost/exp/add-test.php';
      http.post(Uri.parse(url), body: {
        "sol": solctl.text,
        "region": regionctl.text,
        "variete": varietectl.text,
        "deguste": degustectl.text,
        "polyphenol": polyphenolctl.text,
        "tocopherol": tocopherolctl.text,
        "defaut": defautctl.text,
        "fruite": fruitectl.text,
        "acidite": aciditectl.text,
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // ignore: unnecessary_null_comparison
    if (widget.index != null) {
      editMode = true;
      solctl.text = widget.list[widget.index]['sol'];
      regionctl.text = widget.list[widget.index]['region'];
      varietectl.text = widget.list[widget.index]['variete'];
      degustectl.text = widget.list[widget.index]['deguste'];
      polyphenolctl.text = widget.list[widget.index]['polyphenol'];
      tocopherolctl.text = widget.list[widget.index]['tocopherol'];
      defautctl.text = widget.list[widget.index]['defaut'];
      fruitectl.text = widget.list[widget.index]['fruite'];
      aciditectl.text = widget.list[widget.index]['acidite'];
      resultctl.text = widget.list[widget.index]['results'];
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
              controller: aciditectl,
              decoration: const InputDecoration(
                labelText: 'Acidité :',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: fruitectl,
              decoration: const InputDecoration(
                labelText: 'Fruité:',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: polyphenolctl,
              decoration: const InputDecoration(
                labelText: 'Polyphénol:',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: defautctl,
              decoration: const InputDecoration(
                labelText: 'Médiane de défaut',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: tocopherolctl,
              decoration: const InputDecoration(
                labelText: 'Tocophérol:',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: regionctl,
              decoration: const InputDecoration(
                labelText: 'Région :',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: solctl,
              decoration: const InputDecoration(
                labelText: 'Sol:',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: varietectl,
              decoration: const InputDecoration(
                labelText: 'Variété',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: degustectl,
              decoration: const InputDecoration(
                labelText: 'Dégusté',
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: editMode
                  ? TextField(
                      controller: resultctl,
                      decoration: const InputDecoration(
                        labelText: 'Résultat du test:',
                      ),
                    )
                  : const SizedBox(
                      height: 10.0,
                    )),
          Padding(
            padding: const EdgeInsets.all(8),
            child: MaterialButton(
              onPressed: () {
                setState(() {
                  addUpdateTest();
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ListeTests(),
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
        ],
      ),
    );
  }
}
