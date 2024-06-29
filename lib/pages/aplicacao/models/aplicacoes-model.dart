class AplicacaoDetailResponseModel {
  String id;
  String descricaoVaga;
  DateTime dataAplicacao;
  String nomeEmpresa;
  int statusAplicacao;
  String nomeCandidato;

  AplicacaoDetailResponseModel(this.id, this.descricaoVaga, this.dataAplicacao,
      this.nomeEmpresa, this.statusAplicacao, this.nomeCandidato);

  factory AplicacaoDetailResponseModel.fromJson(Map<String, dynamic> json) {
    return AplicacaoDetailResponseModel(
        json['id'],
        json['descricaoVaga'],
        DateTime.parse(json['dataAplicacao']),
        json['nomeEmpresa'],
        json['statusAplicacao'],
        json['nomeCandidato']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descricaoVaga': descricaoVaga,
      'dataAplicacao': dataAplicacao.toIso8601String(),
      'nomeEmpresa': nomeEmpresa,
      'statusAplicacao': statusAplicacao,
      'nomeCandidato': nomeCandidato
    };
  }
}

class AplicacaoCompletaModel {
  
}
