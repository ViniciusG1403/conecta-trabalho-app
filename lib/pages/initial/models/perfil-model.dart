import 'dart:ffi';

class Perfil {
  String id;
  String nome;
  String email;
  int tipoUsuario;
  String fotoPerfil;

  Perfil(this.id, this.nome, this.email, this.tipoUsuario, this.fotoPerfil);

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome,
        'email': email,
        'tipoUsuario': tipoUsuario,
        'fotoPerfil': fotoPerfil,
      };

  factory Perfil.fromJson(Map<String, dynamic> json) {
    return Perfil(
      json['id'],
      json['nome'],
      json['email'],
      json['tipoUsuario'],
      json['fotoPerfil'],
    );
  }
}
