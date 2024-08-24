class CandidatoListaResponseModel {
  String id;
  String nome;
  String habilidades;
  String cidadeEstado;

  CandidatoListaResponseModel(this.id, this.nome, this.habilidades,
      this.cidadeEstado);

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome,
        'habilidades': habilidades,
        'cidadeEstado': cidadeEstado
      };

  factory CandidatoListaResponseModel.fromJson(Map<String, dynamic> json) {
    return CandidatoListaResponseModel(
        json['id'],
        json['nome'],
        json['habilidades'],
        json['cidadeEstado']);
  }

  static List<CandidatoListaResponseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => CandidatoListaResponseModel.fromJson(json))
        .toList();
  }
}
