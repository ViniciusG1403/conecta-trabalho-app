class Perfil {
  String id;
  String nome;
  String email;
  String fotoPerfil;

  Perfil(this.id, this.nome, this.email, this.fotoPerfil);

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome,
        'email': email,
        'fotoPerfil': fotoPerfil,
      };

  factory Perfil.fromJson(Map<String, dynamic> json) {
    return Perfil(
      json['id'],
      json['nome'],
      json['email'],
      json['fotoPerfil'],
    );
  }
}
