class PerfilEmpresaEdicaoModel {
  String id;
  String setor;
  String descricao;
  String website;
  String linkedin;

  PerfilEmpresaEdicaoModel(
      this.id,
      this.setor,
      this.descricao,
      this.website,
      this.linkedin);



  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'setor': setor,
      'descricao': descricao,
      'website': website,
      'linkedin': linkedin,
    };
  }

  factory PerfilEmpresaEdicaoModel.fromJson(Map<String, dynamic> json) {

    return PerfilEmpresaEdicaoModel(
        json['id'],
        json['setor'],
        json['descricao'],
        json['website'],
        json['linkedin']);
  }

  static List<PerfilEmpresaEdicaoModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => PerfilEmpresaEdicaoModel.fromJson(json))
        .toList();
  }

}
