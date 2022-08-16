// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CadastroModel {
  String? id;
  String? name;
  String? codigoBene;
  String? dataNasc;
  String? sexo;
  String? telefone;
  String? cidade;
  CadastroModel({
    this.id,
    this.name,
    this.codigoBene,
    this.dataNasc,
    this.sexo,
    this.telefone,
    this.cidade,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'codigoBene': codigoBene,
      'dataNasc': dataNasc,
      'sexo': sexo,
      'telefone': telefone,
      'cidade': cidade,
    };
  }

  factory CadastroModel.fromMap(Map<String, dynamic> map) {
    return CadastroModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      codigoBene:
          map['codigoBene'] != null ? map['codigoBene'] as String : null,
      dataNasc: map['dataNasc'] != null ? map['dataNasc'] as String : null,
      sexo: map['sexo'] != null ? map['sexo'] as String : null,
      telefone: map['telefone'] != null ? map['telefone'] as String : null,
      cidade: map['cidade'] != null ? map['cidade'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CadastroModel.fromJson(String source) =>
      CadastroModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
