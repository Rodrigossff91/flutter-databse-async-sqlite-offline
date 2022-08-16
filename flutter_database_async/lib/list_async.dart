import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_database_async/cadastro_model.dart';
import 'package:flutter_database_async/open_connect_sqlite.dart';

class ListAsync extends StatefulWidget {
  const ListAsync({Key? key}) : super(key: key);

  @override
  State<ListAsync> createState() => _ListAsyncState();
}

class _ListAsyncState extends State<ListAsync> {
  late DatabaseHelper dbHelper;
  late var result;
  late CadastroModel cadastroModel;
  List<CadastroModel> cadastroModelList =
      List<CadastroModel>.empty(growable: true);

  @override
  void initState() {
    _database();
    cadastroModel = CadastroModel();

    super.initState();
  }

  List<CadastroModel> temp = List<CadastroModel>.empty(growable: true);

  Future<void> _database() async {
    dbHelper = DatabaseHelper.instance;
    result = await dbHelper.queryAllRows();

    var resultString = jsonEncode(result);

    var resultDynamic = json.decode(resultString);

    for (var i = 0; i < resultDynamic.length; i++) {
      CadastroModel cadastroModel = CadastroModel(
        id: resultDynamic[i]['id'].toString(),
        name: resultDynamic[i]['name'].toString(),
        codigoBene: resultDynamic[i]['codigoBene'].toString(),
        dataNasc: resultDynamic[i]['dataNasc'].toString(),
        sexo: resultDynamic[i]['sexo'].toString(),
        telefone: resultDynamic[i]['telefone'].toString(),
        cidade: resultDynamic[i]['cidade'].toString(),
      );

      cadastroModelList.add(cadastroModel);
    }

    log(cadastroModelList.toString());

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: ListView.builder(
        itemCount: cadastroModelList.length,
        shrinkWrap: true,
        itemBuilder: ((context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.black.withOpacity(0.5))),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Column(
                          children: const [
                            SizedBox(
                              height: 30,
                            ),
                            Icon(
                              Icons.person,
                              size: 50,
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                      width: 120,
                                      child: Row(
                                        children: const [
                                          Expanded(child: Text('Nome : ')),
                                        ],
                                      )),
                                  SizedBox(
                                    width: 120,
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Text(cadastroModelList[index]
                                                .name!)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                      width: 120,
                                      child: Row(
                                        children: const [
                                          Expanded(
                                              child: Text('Beneficiário : ')),
                                        ],
                                      )),
                                  SizedBox(
                                      width: 120,
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                                  cadastroModelList[index]
                                                      .codigoBene!)),
                                        ],
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                      width: 120,
                                      child: Row(
                                        children: const [
                                          Expanded(
                                              child: Text('Nascimento : ')),
                                        ],
                                      )),
                                  Row(
                                    children: [
                                      SizedBox(
                                          width: 120,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                      cadastroModelList[index]
                                                          .dataNasc!)),
                                            ],
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                      width: 120,
                                      child: Row(
                                        children: const [
                                          Expanded(child: Text('Genero : ')),
                                        ],
                                      )),
                                  SizedBox(
                                      width: 120,
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                                  cadastroModelList[index]
                                                      .sexo!)),
                                        ],
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                      width: 120,
                                      child: Row(
                                        children: const [
                                          Expanded(child: Text('Telefone : ')),
                                        ],
                                      )),
                                  SizedBox(
                                      width: 120,
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                                  cadastroModelList[index]
                                                      .telefone!)),
                                        ],
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                      width: 120,
                                      child: Row(
                                        children: const [
                                          Expanded(child: Text('Cidade : ')),
                                        ],
                                      )),
                                  SizedBox(
                                      width: 120,
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                                  cadastroModelList[index]
                                                      .cidade!)),
                                        ],
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
      bottomNavigationBar: Container(
        child: Center(
            child: Text(
          'Sincronizar informações',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )),
        color: Colors.blue,
        height: 50,
        width: double.infinity,
      ),
    );
  }
}
