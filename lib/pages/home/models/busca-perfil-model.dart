import 'package:conectatrabalho/pages/initial/models/user-model.dart';

class BuscaPerfilRetorno {
  String id;
  String nome;
  String email;
  String fotoPerfil;
  List<UserModel> usuarios;

  BuscaPerfilRetorno(
      this.id, this.nome, this.email, this.fotoPerfil, this.usuarios);

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome,
        'email': email,
        'fotoPerfil': fotoPerfil,
      };

  factory BuscaPerfilRetorno.fromJson(Map<String, dynamic> json) {
    var list = json['usuarios'] as List;
    List<UserModel> usuariosList =
        list.map((i) => UserModel.fromJson(i)).toList();

    return BuscaPerfilRetorno(
      json['id'],
      json['nome'],
      json['email'],
      json['fotoPerfil'],
      usuariosList,
    );
  }
}

class UserModel {
  String id;
  String nome;

  UserModel({
    required this.id,
    required this.nome,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      nome: json['nome'],
    );
  }
}
