import 'dart:convert';

class CandidatoResponse {
  String nome;
  String email;
  String telefone;
  String habilidades;
  String linkedin;
  String github;
  String portfolio;
  String disponibilidade;
  double pretensaoSalarial;
  EnderecoDTO endereco;

  CandidatoResponse({
    required this.nome,
    required this.email,
    this.telefone = '',
    this.habilidades = '',
    this.linkedin = '',
    this.github = '',
    this.portfolio = '',
    this.disponibilidade = '',
    this.pretensaoSalarial = 0.0,
    required this.endereco,
  });

  factory CandidatoResponse.fromJson(Map<String, dynamic> json) {
    return CandidatoResponse(
      nome: json['nome'],
      email: json['email'],
      telefone: json['telefone'] ?? '',
      habilidades: json['habilidades'] ?? '',
      linkedin: json['linkedin'] ?? '',
      github: json['github'] ?? '',
      portfolio: json['portfolio'] ?? '',
      disponibilidade: json['disponibilidade'] ?? '',
      pretensaoSalarial: (json['pretensaoSalarial'] ?? 0.0).toDouble(),
      endereco: EnderecoDTO.fromJson(json['endereco']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'habilidades': habilidades,
      'linkedin': linkedin,
      'github': github,
      'portfolio': portfolio,
      'disponibilidade': disponibilidade,
      'pretensaoSalarial': pretensaoSalarial,
      'endereco': endereco.toJson(),
    };
  }
}

class EnderecoDTO {
  String municipio;
  String estado;

  EnderecoDTO({
    required this.municipio,
    required this.estado,
  });

  factory EnderecoDTO.fromJson(Map<String, dynamic> json) {
    return EnderecoDTO(
      municipio: json['municipio'] ?? '',
      estado: json['estado'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'endereco': '$municipio, $estado', // Concatenar municipio e estado
    };
  }
}
