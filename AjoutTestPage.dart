import 'dart:convert';
import 'package:db_oilab/ResultatWidgetPage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

extension ColorExtension on String {
  toColor() {
    var hexString = this;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

class AjoutTest extends StatefulWidget {
  final int id_client;

  const AjoutTest({super.key, required this.id_client});

  @override
  State<StatefulWidget> createState() {
    return AjoutTestState();
  }
}

TextEditingController aciditectl = TextEditingController();
TextEditingController fruitectl = TextEditingController();
TextEditingController defautctl = TextEditingController();

TextEditingController polyphenolctl = TextEditingController();
TextEditingController tocopherolctl = TextEditingController();
TextEditingController solctl = TextEditingController();
TextEditingController regionctl = TextEditingController();
TextEditingController degustectl = TextEditingController();
TextEditingController varietectl = TextEditingController();

bool error = false, sending = false, success = false;
String msg = "";

String phpurl = "http://localhost/exp/add-test.php";
String resultat = "";

class AjoutTestState extends State<AjoutTest> {
// ignore: non_constant_identifier_names

  @override
  void initState() {
    error = false;
    sending = false;
    success = false;
    msg = "";
    super.initState();
  }

  Future<void> sendData() async {
    print(widget.id_client);
    var res = await http.post(Uri.parse(phpurl), body: {
      // "id_client": widget.id_client.toString(),
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
    setState(() {
      sending = true;
      success = false;
    }); //sending post request with header data
    print(res.statusCode);
    if (res.statusCode == 200) {
      print(res.body); //print raw response on console
      var data = json.decode(res.body);
      print('AJOUTé');
      //decoding json to array
      setState(() {
        sending = false;
        success = true;
      });

      if (data["error"]) {
        setState(() {
          //refresh the UI when error is recieved from server
          sending = false;
          error = true;
          success = false;
          msg = data["message"]; //error message from server
        });
      } else {
        solctl.text = "";
        regionctl.text = "";
        varietectl.text = "";
        degustectl.text = "";
        polyphenolctl.text = "";
        tocopherolctl.text = "";
        defautctl.text = "";
        fruitectl.text = "";
        aciditectl.text = "";
        //after write success, make fields empty
      }
    } else {
      //there is error
      setState(() {
        error = true;
        msg = "Erreur lors de l'envoie.";
        sending = false;
        success = false;

        //mark error and refresh UI with setState
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Tester"),
          backgroundColor: '#7c893a'.toColor()), //appbar

      body: SingleChildScrollView(
          //enable scrolling, when keyboard appears,
          // hight becomes small, so prevent overflow
          child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Container(
                      child: TextField(
                    controller: fruitectl,
                    decoration: const InputDecoration(
                      labelText: "Fruité:",
                    ),
                  )), //text input for address
                  //text input for name

                  Container(
                      child: TextField(
                    controller: aciditectl,
                    decoration: const InputDecoration(
                      labelText: "Acidité:",
                    ),
                  )), //text input for address
                  //text input for name

                  Container(
                      child: TextField(
                    controller: polyphenolctl,
                    decoration: const InputDecoration(
                      labelText: "Polyphénol:",
                    ),
                  )), //text input for address
                  //text input for name

                  Container(
                      child: TextField(
                    controller: defautctl,
                    decoration: const InputDecoration(
                      labelText: "Médiane de défaut:",
                    ),
                  )), //text input for address
                  //text input for name

                  Container(
                      child: TextField(
                    controller: tocopherolctl,
                    decoration: const InputDecoration(
                      labelText: "Tocophérol:",
                    ),
                  )), //text input for address

                  Container(
                      child: TextField(
                    controller: regionctl,
                    decoration: const InputDecoration(
                      labelText: "Région:",
                    ),
                  )), //text input for name

                  Container(
                      child: TextField(
                    controller: solctl,
                    decoration: const InputDecoration(
                      labelText: "Sol:",
                    ),
                  )), //text input for address

                  Container(
                      child: TextField(
                    controller: varietectl,
                    decoration: const InputDecoration(
                      labelText: "Variété:",
                    ),
                  )), //text input for class

                  Container(
                      child: TextField(
                    controller: degustectl,
                    decoration: const InputDecoration(
                      labelText: "Dégusté:",
                    ),
                  )), //text input for roll no

                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: SizedBox(
                          width: double.infinity,
                          child: MaterialButton(
                            onPressed: () {
                              sendData();
                              //if button is pressed, setstate sending = true, so that we can show "sending..."
                              setState(() {
                                sending = true;
                              });
                            },
                            // ignore: sort_child_properties_last
                            child: Text(
                              !sending && success
                                  ? "Succés d'envoie"
                                  : "Ajouter",
                              style: const TextStyle(color: Colors.white),
                              //if sending == true then show "Sending" else show "SEND DATA";
                            ),
                            color: '#7c893a'.toColor(),
                            colorBrightness: Brightness.dark,
                            //background of button is darker color, so set brightness to dark
                          ))),
                  /*  Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: SizedBox(
                          width: double.infinity,
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ResultatWidget()));
                            },
                            // ignore: sort_child_properties_last
                            child: Text(
                              "Résultat",
                              style: TextStyle(color: '#f1ee92'.toColor()),
                              //if sending == true then show "Sending" else show "SEND DATA";
                            ),
                            color: '#7c893a'.toColor(),
                            colorBrightness: Brightness.dark,
                            //background of button is darker color, so set brightness to dark
                          ))), */
                  //text input for roll no
                ],
              ))),
    );
  }
}
