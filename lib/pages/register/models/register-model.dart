class User {
  String nome;
  String email;
  String telefone;
  String senha;
  String tipo;

  User(this.nome, this.email, this.telefone, this.senha, this.tipo);

  Map<String, dynamic> toJson() => {
        'nome': nome,
        'email': email,
        'telefone': telefone,
        'senha': senha,
        'tipo': tipo,
      };
}

class UserRegister {
  String nome;
  String email;
  String telefone;
  String senha;
  String tipo;
  Endereco endereco;

  UserRegister(this.nome, this.email, this.telefone, this.senha, this.tipo,
      this.endereco);

  Map<String, dynamic> toJson() => {
        'nome': nome,
        'email': email,
        'telefone': telefone,
        'senha': senha,
        'tipo': tipo,
        'endereco': endereco.toJson(),
      };
}

class Endereco {
  String cep;
  String estado;
  String pais;
  String municipio;
  String bairro;
  String logradouro;
  String numero;
  String complemento;

  Endereco(this.cep, this.estado, this.pais, this.municipio, this.bairro,
      this.logradouro, this.numero, this.complemento);

  Map<String, dynamic> toJson() => {
        'cep': cep,
        'estado': estado,
        'pais': pais,
        'municipio': municipio,
        'bairro': bairro,
        'logradouro': logradouro,
        'numero': numero,
        'complemento': complemento,
      };
}
