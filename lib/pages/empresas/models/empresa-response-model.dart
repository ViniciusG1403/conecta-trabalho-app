class EmpresaReponseModel {
  String id;
  String nome;
  String email;
  String telefone;
  String setor;
  String descricao;
  String website;
  String linkedin;
  String endereco;

  EmpresaReponseModel(
      this.id,
      this.nome,
      this.email,
      this.telefone,
      this.setor,
      this.descricao,
      this.website,
      this.linkedin,
      this.endereco);

  factory EmpresaReponseModel.fromJson(Map<String, dynamic> json) {
    final String endereco = json['endereco']['logradouro'] +
        ', ' +
        json['endereco']['numero'] +
        ', ' +
        json['endereco']['bairro'] +
        ', ' +
        json['endereco']['cidade'] +
        ' - ' +
        json['endereco']['estado'];


    return EmpresaReponseModel(
        json['id'],
        json['nome'],
        json['email'],
        json['telefone'],
        json['setor'],
        json['descricao'],
        json['website'],
        json['linkedin'],
        endereco);
  }

  static List<EmpresaReponseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => EmpresaReponseModel.fromJson(json))
        .toList();
  }

}
