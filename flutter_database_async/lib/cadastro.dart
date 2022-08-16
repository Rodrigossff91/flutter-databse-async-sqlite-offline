import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_database_async/open_connect_sqlite.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sqflite/sqflite.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  late DatabaseHelper dbHelper;
  late TextEditingController nome;
  late TextEditingController cdBenefi;
  late TextEditingController dataNasc;
  late TextEditingController cidade;
  late TextEditingController telefone;

  late Database connection;
  late bool sexoMasc;

  var maskFormatterPhone = MaskTextInputFormatter(
      mask: '(##) #####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  var maskDateBorn = MaskTextInputFormatter(
      mask: '##/##/####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  void initState() {
    _database();
    nome = TextEditingController();
    cdBenefi = TextEditingController();
    dataNasc = TextEditingController();
    cidade = TextEditingController();
    telefone = TextEditingController();
    sexoMasc = true;

    super.initState();
  }

  insertDataBase(
      {required String nome,
      required String codigoBene,
      required String dataNasc,
      required String sexo,
      required String telefone,
      required String cidade}) async {
    await dbHelper.insert(
        nome: nome,
        codigoBene: codigoBene,
        dataNasc: dataNasc,
        sexo: sexo,
        telefone: telefone,
        cidade: cidade);

    var result = await dbHelper.queryAllRows();
    log(result.toList().toString());
  }

  Future<void> _database() async {
    dbHelper = DatabaseHelper.instance;
  }

  @override
  void dispose() {
    nome.dispose();
    cdBenefi.dispose();
    dataNasc.dispose();
    cidade.dispose();
    telefone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //  FocusScope.of(context).unfocus();
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Cadastro'),
          leading: ClipOval(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Image.asset(
                'assets/carrefy.png',
                color: Colors.white,
              ),
            ),
          ),
          actions: [
            InkWell(
              onTap: (() {
                Navigator.of(context).pushNamed("/listAsync");
              }),
              child: const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(Icons.autorenew_rounded),
              ),
            ),
          ],
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
                  ListView(
                    shrinkWrap: true,
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 31, right: 29, top: 0),
                        child: TextFormField(
                          cursorColor: Colors.black,
                          //   focusNode: sobrenome,
                          textInputAction: TextInputAction.done,
                          controller: nome,
                          onChanged: (_) {},
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.sentences,
                          //inputFormatters: [UpperCaseTextFormatter()],
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: const BorderSide(
                                  width: 2, color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xFFE5E5E5)),
                                borderRadius: BorderRadius.circular(12.0)),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 19, horizontal: 20),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            hintText: '',
                            labelText: 'Nome',
                          ),
                          onSaved: (String? value) {},
                          validator: (String? value) {
                            return (value != null && value.contains('@'))
                                ? 'Do not use the @ char.'
                                : null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 31, right: 29, top: 20),
                        child: TextFormField(
                          cursorColor: Colors.black,
                          //   focusNode: sobrenome,
                          textInputAction: TextInputAction.done,
                          controller: cdBenefi,
                          onChanged: (_) {},
                          keyboardType: TextInputType.number,
                          textCapitalization: TextCapitalization.sentences,
                          //inputFormatters: [UpperCaseTextFormatter()],
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: const BorderSide(
                                  width: 2, color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xFFE5E5E5)),
                                borderRadius: BorderRadius.circular(12.0)),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 19, horizontal: 20),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            hintText: '',
                            labelText: 'Código Beneficiário',
                          ),
                          onSaved: (String? value) {},
                          validator: (String? value) {
                            return (value != null && value.contains('@'))
                                ? 'Do not use the @ char.'
                                : null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 31, right: 29, top: 20),
                        child: TextFormField(
                          cursorColor: Colors.black,
                          //   focusNode: sobrenome,
                          textInputAction: TextInputAction.done,
                          controller: dataNasc,
                          inputFormatters: [maskDateBorn],
                          onChanged: (_) {},
                          keyboardType: TextInputType.number,
                          textCapitalization: TextCapitalization.sentences,
                          //inputFormatters: [UpperCaseTextFormatter()],
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: const BorderSide(
                                  width: 2, color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xFFE5E5E5)),
                                borderRadius: BorderRadius.circular(12.0)),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 19, horizontal: 20),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            hintText: '',
                            labelText: 'Data de Nascimento',
                          ),
                          onSaved: (String? value) {},
                          validator: (String? value) {
                            return (value != null && value.contains('@'))
                                ? 'Do not use the @ char.'
                                : null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(
                          thickness: 1,
                          color: Color(0xFFE5E5E5),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 35,
                        ),
                        child: Row(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Visibility(
                                  visible: sexoMasc == true,
                                  child: Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(100))),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      sexoMasc = true;
                                    });
                                  },
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border:
                                            Border.all(color: Colors.black)),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text('Masculino'),
                            const Spacer(),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Visibility(
                                  visible: sexoMasc == false,
                                  child: Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(100))),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      sexoMasc = false;
                                    });
                                  },
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border:
                                            Border.all(color: Colors.black)),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text('Feminino')
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(
                          thickness: 1,
                          color: Color(0xFFE5E5E5),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 31, right: 29, top: 20),
                        child: TextFormField(
                          cursorColor: Colors.black,
                          //   focusNode: sobrenome,
                          textInputAction: TextInputAction.done,
                          controller: telefone,
                          inputFormatters: [maskFormatterPhone],
                          onChanged: (_) {},
                          keyboardType: TextInputType.number,
                          textCapitalization: TextCapitalization.sentences,
                          //inputFormatters: [UpperCaseTextFormatter()],
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: const BorderSide(
                                  width: 2, color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xFFE5E5E5)),
                                borderRadius: BorderRadius.circular(12.0)),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 19, horizontal: 20),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            hintText: '',
                            labelText: 'Tel',
                          ),
                          onSaved: (String? value) {},
                          validator: (String? value) {
                            return (value != null && value.contains('@'))
                                ? 'Do not use the @ char.'
                                : null;
                          },
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 31, right: 29, top: 20),
                        child: TextFormField(
                          cursorColor: Colors.black,
                          //   focusNode: sobrenome,
                          textInputAction: TextInputAction.done,
                          controller: cidade,
                          onChanged: (_) {},
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.sentences,
                          //inputFormatters: [UpperCaseTextFormatter()],
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: const BorderSide(
                                  width: 2, color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xFFE5E5E5)),
                                borderRadius: BorderRadius.circular(12.0)),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 19, horizontal: 20),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            hintText: '',
                            labelText: 'Cidade',
                          ),
                          onSaved: (String? value) {},
                          validator: (String? value) {
                            return (value != null && value.contains('@'))
                                ? 'Do not use the @ char.'
                                : null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.0),
                        child: GestureDetector(
                          onTap: () async {
                            await insertDataBase(
                                nome: nome.text,
                                codigoBene: cdBenefi.text,
                                dataNasc: dataNasc.text,
                                sexo:
                                    sexoMasc == true ? 'Masculino' : 'Feminino',
                                telefone: telefone.text,
                                cidade: cidade.text);

                            setState(() {
                              nome.text = '';
                              cdBenefi.text = '';
                              dataNasc.text = '';
                              telefone.text = '';
                              cidade.text = '';
                            });
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
                        ),
                      )
                    ],
                  ),
                ],
              );
            },
            child: const SizedBox.shrink()));
  }
}
