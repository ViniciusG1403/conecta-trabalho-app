class Empresa {
  String idUsuario;
  String setor;
  String descricao;
  String website;
  String linkedin;

  Empresa(
      this.idUsuario, this.setor, this.descricao, this.website, this.linkedin);

  Map<String, dynamic> toJson() => {
        'idUsuario': idUsuario,
        'setor': setor,
        'descricao': descricao,
        'website': website,
        'linkedin': linkedin,
      };
}
