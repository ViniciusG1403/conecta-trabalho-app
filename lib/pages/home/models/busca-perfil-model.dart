class BuscaPerfilRetorno {
  String id;
  String nome;
  String email;
  String fotoPerfil;

  BuscaPerfilRetorno(this.id, this.nome, this.email, this.fotoPerfil);

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome,
        'email': email,
        'fotoPerfil': fotoPerfil,
      };

  factory BuscaPerfilRetorno.fromJson(Map<String, dynamic> json) {
    return BuscaPerfilRetorno(
      json['id'],
      json['nome'],
      json['email'],
      json['fotoPerfil'],
    );
  }
}
