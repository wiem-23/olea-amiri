// ignore_for_file: sort_child_properties_last

import 'dart:convert';
import 'package:db_oilab/particuliers.dart';
import 'package:db_oilab/professionnels.dart';
import 'package:http/http.dart' as http;
import 'package:db_oilab/AjoutClientPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Color.dart';
import 'ModelClient.dart';

class CategoriesPage extends StatefulWidget {
  @override
  State<CategoriesPage> createState() {
    return CategoriesPageState();
  }
}

class CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/images/icon-oilab.png",
              ),
              fit: BoxFit.contain,
              opacity: 0.2),
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: const Text(
                'Catégories des clients',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: const Color.fromRGBO(124, 137, 58, 1),
            ),
            body: Center(
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MaterialButton(
                          // ignore: sort_child_properties_last

                          child: const Text('Particuliers',
                              style: TextStyle(color: Colors.white)),
                          padding: const EdgeInsets.only(left: 160, right: 160),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ListeParticuliers()));
                          },
                          color: const Color.fromRGBO(124, 137, 58, 1)),
                      const SizedBox(
                        height: 50,
                      ),
                      MaterialButton(
                        child: const Text(
                          'Professionnels',
                          style: TextStyle(color: Colors.white),
                        ),
                        padding: const EdgeInsets.only(left: 150, right: 150),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PageProfessionnels()));
                        },
                        color: const Color.fromRGBO(124, 137, 58, 1),
                      ),
                    ],
                  ),
                ]))));
  }
}
