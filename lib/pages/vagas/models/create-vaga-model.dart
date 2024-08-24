class VagaCreateRequestModel {
  String titulo;
  String descricao;
  String? nivel;
  int status;
  int tipo;
  String cargo;
  double remuneracao;
  String idEmpresa;

  VagaCreateRequestModel({
    required this.titulo,
    required this.descricao,
    required this.nivel,
    required this.status,
    required this.cargo,
    required this.tipo,
    required this.remuneracao,
    required this.idEmpresa,
  });

  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'descricao': descricao,
      'nivel': nivel,
      'status': status,
      'cargo': cargo,
      'tipo': tipo,
      'remuneracao': remuneracao,
      'idEmpresa': idEmpresa,
    };
  }
}
