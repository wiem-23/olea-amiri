import 'dart:convert';
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

class WriteSQLdata extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WriteSQLdataState();
  }
}

class WriteSQLdataState extends State<WriteSQLdata> {
  TextEditingController nomctl = TextEditingController();
  TextEditingController adressectl = TextEditingController();
  TextEditingController typectl = TextEditingController();
  TextEditingController telctl = TextEditingController();
  //text controller for TextField
/*   List<Widget> categories = <Widget>[
    Text('Professionnel'),
    Text('Particulier'),
  ]; */
  bool error = false, sending = false, success = false;
  String msg = "";

  String phpurl = "http://localhost/test/write.php";
  // do not use http://localhost/ for your local
  // machine, Android emulation do not recognize localhost
  // insted use your local ip address or your live URL
  // hit "ipconfig" on Windows or  "ip a" on Linux to get IP Address

  @override
  void initState() {
    error = false;
    sending = false;
    success = false;
    msg = "";
    super.initState();
  }

  Future<void> sendData() async {
    var res = await http.post(Uri.parse(phpurl), body: {
      "nom": nomctl.text,
      "adresse": adressectl.text,
      "type": typectl.text,
      "tel": telctl.text,
    });
    setState(() {
      sending = true;
      success = false;
    }); //sending post request with header data
    print(res.statusCode);
    if (res.statusCode == 200) {
      print(res.body); //print raw response on console
      var data = json.decode(res.body); //decoding json to array
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
        nomctl.text = "";
        adressectl.text = "";

        telctl.text = "";
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
          title: const Text("Ajouter un nouveau client"),
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
                    controller: nomctl,
                    decoration: const InputDecoration(
                      labelText: "Nom complet:",
                      hintText: "Saisir le nom complet du client ",
                    ),
                  )), //text input for name

                  Container(
                      child: TextField(
                    controller: adressectl,
                    decoration: const InputDecoration(
                      labelText: "Adresse:",
                      hintText: "Saisir l'adresse du client",
                    ),
                  )), //text input for address

                  Container(
                      child: TextField(
                    controller: typectl,
                    decoration: const InputDecoration(
                      labelText: "Type:",
                      hintText: "Saisir le type du client",
                    ),
                  )), //text input for class

                  Container(
                      child: TextField(
                    controller: telctl,
                    decoration: const InputDecoration(
                      labelText: "Téléphone:",
                      hintText: "Saisir le numéro de téléphone du client",
                    ),
                  )), //text input for roll no

                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: SizedBox(
                          width: double.infinity,
                          child: MaterialButton(
                            onPressed: () {
                              //if button is pressed, setstate sending = true, so that we can show "sending..."
                              setState(() {
                                sending = true;
                              });
                              sendData();
                            },
                            // ignore: sort_child_properties_last
                            child: Text(
                              !sending && success
                                  ? "Succés d'envoie"
                                  : "Ajouter",
                              style: TextStyle(color: '#f1ee92'.toColor()),
                              //if sending == true then show "Sending" else show "SEND DATA";
                            ),
                            color: '#7c893a'.toColor(),
                            colorBrightness: Brightness.dark,
                            //background of button is darker color, so set brightness to dark
                          )))
                ],
              ))),
    );
  }
}

enum Categorie { particulier, professionnel }

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State {
  Categorie? _categorie = Categorie.particulier;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text('Particulier'),
          leading: Radio(
            value: Categorie.particulier,
            groupValue: _categorie,
            fillColor: MaterialStateColor.resolveWith(
                (states) => Colors.blueAccent), //<-- SEE HERE
            onChanged: (Categorie? value) {
              setState(() {
                _categorie = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Train'),
          leading: Radio(
            value: Categorie.professionnel,
            groupValue: _categorie,
            fillColor: MaterialStateColor.resolveWith((states) => Colors.green),
            onChanged: (Categorie? value) {
              setState(() {
                _categorie = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
