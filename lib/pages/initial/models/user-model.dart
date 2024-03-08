class User {
  String nome;
  String email;
  int tipo;

  User(this.nome, this.email, this.tipo);

  Map<String, dynamic> toJson() => {
        'name': nome,
        'email': email,
        'tipo': tipo,
      };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['nome'],
      json['email'],
      json['tipo'],
    );
  }
}
