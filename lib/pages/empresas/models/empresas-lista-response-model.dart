class EmpresasListaResponseModel {
  String id;
  String nome;
  String descricao;
  String setor;
  String cidadeEstado;

  EmpresasListaResponseModel(this.id, this.nome, this.descricao, this.setor,
      this.cidadeEstado);

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome,
        'descricao': descricao,
        'setor': setor,
        'cidadeEstado': cidadeEstado
      };

  factory EmpresasListaResponseModel.fromJson(Map<String, dynamic> json) {
    return EmpresasListaResponseModel(
        json['id'],
        json['nome'],
        json['descricao'],
        json['setor'],
        json['cidadeEstado']);
  }

  static List<EmpresasListaResponseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => EmpresasListaResponseModel.fromJson(json))
        .toList();
  }
}
