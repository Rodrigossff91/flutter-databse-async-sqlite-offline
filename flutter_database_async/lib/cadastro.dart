import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_database_async/open_connect_sqlite.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:sqflite/sqflite.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  late DatabaseHelper dbHelper;
  late TextEditingController nome;
  late TextEditingController sobrenome;
  late TextEditingController email;
  late TextEditingController cfm;

  late Database connection;

  @override
  void initState() {
    _database();
    nome = TextEditingController();
    sobrenome = TextEditingController();
    email = TextEditingController();
    cfm = TextEditingController();

    super.initState();
  }

  insertDataBase(
      {required String nome,
      required String sobrenome,
      required String email,
      required String cfm}) async {
    dbHelper.insert(nome: nome, sobrenome: sobrenome, email: email, cfm: cfm);

    var result = await dbHelper.queryAllRows();
    log(result.toList().toString());
  }

  Future<void> _database() async {
    dbHelper = DatabaseHelper.instance;
  }

  @override
  void dispose() {
    nome.dispose();
    sobrenome.dispose();
    email.dispose();
    cfm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Cadastro'),
        ),
        body: OfflineBuilder(
            connectivityBuilder: (
              BuildContext context,
              ConnectivityResult connectivity,
              Widget child,
            ) {
              final bool connected = connectivity != ConnectivityResult.none;
              return Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(
                    height: 24.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      color: connected
                          ? const Color(0xFF00EE44)
                          : const Color(0xFFEE4400),
                      child: Center(
                        child: Text("${connected ? 'ONLINE' : 'OFFLINE'}"),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: nome,
                            decoration: const InputDecoration(hintText: 'Name'),
                            onChanged: (text) {
                              // do something with text
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: sobrenome,
                          decoration:
                              const InputDecoration(hintText: 'Sobrenome'),
                          onChanged: (text) {
                            // do something with text
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: email,
                          decoration: const InputDecoration(hintText: 'Email'),
                          onChanged: (text) {
                            // do something with text
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: cfm,
                          decoration: const InputDecoration(hintText: 'CFM'),
                          onChanged: (text) {
                            // do something with text
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          insertDataBase(
                              nome: nome.text,
                              sobrenome: sobrenome.text,
                              email: email.text,
                              cfm: cfm.text);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.blue),
                            child: const Center(
                                child: Text(
                              'Salvar',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              );
            },
            child: SizedBox.shrink()));
  }
}
