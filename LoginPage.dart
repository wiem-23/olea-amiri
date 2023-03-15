import 'dart:convert';

import 'package:db_oilab/categoriesPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'ListClients.dart';
//import http package manually

extension ColorExtension on String {
  toColor() {
    var hexString = this;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage> {
  String errormsg = '';
  bool error = false, showprogress = false, success = false;
  String email = '', motdepasse = '';

  TextEditingController emailclt = TextEditingController();
  TextEditingController motdepasseclt = TextEditingController();

  startLogin() async {
    String apiurl = "http://localhost/exp/login.php"; //api url
    //dont use http://localhost , because emulator don't get that address
    //insted use your local IP address or use live URL
    //hit "ipconfig" in windows or "ip a" in linux to get you local IP
    print(email);

    var response = await http.post(Uri.parse(apiurl), body: {
      'email': email, //get the username text
      'motdepasse': motdepasse //get password text
    });

    if (response.statusCode == 200) {
      print("logée");
      var jsondata = json.decode(response.body);
      print(jsondata);
      if (jsondata["error"]) {
        setState(() {
          success = false;
          showprogress = false; //don't show progress indicator
          error = true;
          errormsg = jsondata["message"];
        });
      } else {
        if (jsondata["success"]) {
          setState(() {
            error = false;
            showprogress = false;
            success = true;
          });
          //save the data returned from server
          //and navigate to home page
          String nom_admin = jsondata["nom_admin"];
          print(nom_admin);

          //user shared preference to save data
        } else {
          showprogress = false; //don't show progress indicator
          error = true;
          success = false;
          errormsg = "Something went wrong.";
        }
      }
    } else {
      setState(() {
        showprogress = false; //don't show progress indicator
        error = true;
        errormsg = "Error during connecting to server.";
        success = true;
      });
    }
  }

  @override
  void initState() {
    emailclt.text = "";
    motdepasseclt.text = "";
    errormsg = "";
    error = false;
    showprogress = false;

    //_username.text = "defaulttext";
    //_password.text = "defaultpassword";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent
            //color set to transperent or set your own color
            ));

    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        constraints:
            BoxConstraints(minHeight: MediaQuery.of(context).size.height
                //set minimum height equal to 100% of VH
                ),
        width: MediaQuery.of(context)
            .size
            .width, //show linear gradient background of page

        padding: const EdgeInsets.all(20),
        child: Column(children: <Widget>[
          Column(children: [
            const SizedBox(
              height: 10,
            ),
            Image.asset(
              'assets/images/logo.png',
              width: 450,
              height: 300,
            ),
          ]),
          Container(
            //show error message here
            margin: const EdgeInsets.only(top: 30),
            padding: const EdgeInsets.all(10),
            child: error ? errmsg(errormsg) : Container(),
            //if error == true then show error message
            //else set empty container as child
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            margin: const EdgeInsets.only(top: 10),
            child: TextField(
              cursorColor: '#7c893a'.toColor(),
              controller: emailclt, //set username controller
              style: const TextStyle(
                  color: Color.fromARGB(255, 50, 50, 50), fontSize: 18),
              decoration: myInputDecoration(
                icon: Icons.person,
              ),
              onChanged: (value) {
                //set username  text on change
                email = value;
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              cursorColor: '#7c893a'.toColor(),
              controller: motdepasseclt, //set password controller
              style: const TextStyle(
                  color: Color.fromARGB(255, 50, 50, 50), fontSize: 18),
              obscureText: true,
              decoration: myInputDecoration(
                icon: Icons.lock,
              ),
              onChanged: (value) {
                // change password text
                motdepasse = value;
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(top: 20),
            child: SizedBox(
              height: 60,
              width: double.infinity,
              child: MaterialButton(
                onPressed: () {
                  setState(() {
                    //show progress indicator on click
                    showprogress = true;
                  });
                  startLogin();
                  print(error);
                  if (success) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoriesPage()));
                  }
                },

                // ignore: sort_child_properties_last
                child: showprogress
                    ? SizedBox(
                        height: 30, width: 30,
                        child: CircularProgressIndicator(
                          backgroundColor: '#f1ee92'.toColor(),
                          valueColor: '#7c893a'.toColor(),
                        ),
                        // ignore: prefer_const_constructors
                      )
                    : const Text(
                        "LOGIN",
                        style: TextStyle(fontSize: 18),
                      ),
                // if showprogress == true then show progress indicator
                // else show "LOGIN NOW" text
                colorBrightness: Brightness.dark,
                color: '#7c893a'.toColor(),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                    //button corner radius
                    ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(top: 8),
            child: InkResponse(
                onTap: () {
                  //action on tap
                },
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(
                      color: Color.fromARGB(255, 59, 85, 17), fontSize: 16),
                )),
          )
        ]),
      )),
    );
  }

  InputDecoration myInputDecoration({String? label, IconData? icon}) {
    return InputDecoration(
      hintText: label, //show label as placeholder
      hintStyle:
          TextStyle(color: '#7c893a'.toColor(), fontSize: 20), //hint text style
      prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 20, right: 10),
          child: Icon(
            icon,
            color: '#7c893a'.toColor(),
          )
          //padding and icon for prefix
          ),

      contentPadding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 75, 110, 18),
              width: 1)), //default border of input

      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 75, 110, 18),
              width: 1)), //focus border

      fillColor: Colors.white,
      filled: true, //set true if you want to show input background
    );
  }

  Widget errmsg(String text) {
    //error message widget.
    return Container(
      padding: const EdgeInsets.all(15.00),
      margin: const EdgeInsets.only(bottom: 10.00),
      child: Row(children: <Widget>[
        Container(
          margin: const EdgeInsets.only(right: 6.00),
          child: const Icon(Icons.info, color: Colors.red),
        ), // icon for error message

        Text(text,
            style: const TextStyle(
                color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold)),
        //show error message text
      ]),
    );
  }
}
