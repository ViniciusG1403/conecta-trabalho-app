class FinalizarPausarVagaModel {
  String idVaga;
  String idEmpresa;


  FinalizarPausarVagaModel({
    required this.idVaga,
    required this.idEmpresa,
  });

  Map<String, dynamic> toJson() {
    return {
      'idVaga': idVaga,
      'idEmpresa': idEmpresa,
    };
  }
}
