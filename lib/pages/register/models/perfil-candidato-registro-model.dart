class Candidato {
  String idUsuario;
  String habilidades;
  String linkedin;
  String github;
  String portfolio;
  String disponibilidade;
  num pretensaoSalarial;

  Candidato(this.idUsuario, this.habilidades, this.linkedin, this.github,
      this.portfolio, this.disponibilidade, this.pretensaoSalarial);

  Map<String, dynamic> toJson() => {
        'idUsuario': idUsuario,
        'habilidades': habilidades,
        'linkedin': linkedin,
        'github': github,
        'portfolio': portfolio,
        'disponibilidade': disponibilidade,
        'pretensaoSalarial': pretensaoSalarial,
      };
}
