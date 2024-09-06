class AplicacaoDetailResponseModel {
  String id;
  String descricaoVaga;
  DateTime dataAplicacao;
  String nomeEmpresa;
  int statusAplicacao;
  String nomeCandidato;
  String idCandidato;

  AplicacaoDetailResponseModel(this.id, this.descricaoVaga, this.dataAplicacao,
      this.nomeEmpresa, this.statusAplicacao, this.nomeCandidato, this.idCandidato);

  factory AplicacaoDetailResponseModel.fromJson(Map<String, dynamic> json) {
    return AplicacaoDetailResponseModel(
        json['id'],
        json['descricaoVaga'],
        DateTime.parse(json['dataAplicacao']),
        json['nomeEmpresa'],
        json['statusAplicacao'],
        json['nomeCandidato'],
        json['idCandidato']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descricaoVaga': descricaoVaga,
      'dataAplicacao': dataAplicacao.toIso8601String(),
      'nomeEmpresa': nomeEmpresa,
      'statusAplicacao': statusAplicacao,
      'nomeCandidato': nomeCandidato,
      'idCandidato': idCandidato
    };
  }
}

class AplicacaoCompletaModel {
  String id;
  String tituloVaga;
  String idVaga;
  DateTime dataAplicacao;
  String nomeEmpresa;
  int statusAplicacao;
  String feedbackCandidato;
  String feedbackEmpresa;
    String idCandidato;

  AplicacaoCompletaModel(
      this.id,
      this.tituloVaga,
      this.idVaga,
      this.dataAplicacao,
      this.nomeEmpresa,
      this.statusAplicacao,
      this.feedbackCandidato,
      this.feedbackEmpresa,
      this.idCandidato);

  factory AplicacaoCompletaModel.fromJson(Map<String, dynamic> json) {

    String idVaga = json['vaga']['id'];
    String empresa = json['vaga']['empresa']['setor'];
    String tituloVaga = json['vaga']['titulo'];
    String idCandidato = json['candidato']['id'];

    return AplicacaoCompletaModel(
        json['id'],
        tituloVaga,
        idVaga,
        DateTime.parse(json['dataAplicacao'] ?? DateTime.now().toIso8601String()),
        empresa,
        json['status'],
        json['feedbackCandidato'] ?? "Sem feedback",
        json['feedbackEmpresa'] ?? "Sem feedback",
        idCandidato);
  }
}
