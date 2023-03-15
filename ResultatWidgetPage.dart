// ignore_for_file: file_names

import 'dart:convert';

import 'package:db_oilab/AjoutTestPage.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class ResultatWidget extends StatefulWidget {
  const ResultatWidget({super.key, required this.results});
  final String results;
  @override
  ResultatWidgetState createState() => ResultatWidgetState();
}

class ResultatWidgetState extends State<ResultatWidget> {
  Future getResultat() async {
    var url = 'http://localhost:80/exp/read-results.php';

    var response = await http.get(
      Uri.parse(url),
    );
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
    getResultat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Qualité d'huile")),
      body: FutureBuilder(
        future: getResultat(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    List list = snapshot.data;
                    return ListTile(
                      title: Text(widget.results.toString()),
                      subtitle: Text(list[index]['id_test'].toString()),
                    );
                  })
              : const CircularProgressIndicator();
        },
      ),
    );
  }
}
