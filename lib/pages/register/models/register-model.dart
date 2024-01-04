class User {
  String id;
  String name;
  String email;
  String situacao;
  DateTime dhCadastro;
  DateTime dhUltimoLogin;

  User(this.id, this.name, this.email, this.dhCadastro, this.situacao,
      this.dhUltimoLogin);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'dhCadastro': dhCadastro.toString(),
        'situacao': situacao,
        'dhUltimoLogin': dhUltimoLogin.toString(),
      };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['id'],
      json['name'],
      json['email'],
      convertStringToDateTime(json['dhCadastro']),
      json['situacao'],
      convertStringToDateTime(json['dhUltimoLogin']),
    );
  }
}

class UserUpdate {
  String id;
  String name;
  String email;
  int situacao;

  UserUpdate(this.id, this.name, this.email, this.situacao);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'situacao': situacao,
      };

  factory UserUpdate.fromJson(Map<String, dynamic> json) {
    return UserUpdate(json['id'], json['name'], json['email'],
        convertToEnum(json['situacao']));
  }
}

int convertToEnum(String situacao) {
  if (situacao == 'ATIVO') {
    return 1;
  } else {
    return 0;
  }
}

DateTime convertStringToDateTime(String data) {
  return DateTime.parse(data);
}
