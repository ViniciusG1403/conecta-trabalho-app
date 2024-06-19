class AplicarParaVagaModel {
  String idVaga;
  String? candidato;

  AplicarParaVagaModel (this.idVaga, this.candidato);

  Map<String, dynamic> toJson() => {
        'idVaga': idVaga,
        'candidato': candidato,
      };
}