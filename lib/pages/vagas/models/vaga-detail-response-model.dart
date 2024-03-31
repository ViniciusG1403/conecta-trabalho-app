class VagasDetailResponseModel {
  String id;
  String titulo;
  String descricao;
  String nivel;
  int status;
  String empresa;
  String cargo;
  double remuneracao = 0;

  VagasDetailResponseModel(this.id, this.titulo, this.descricao, this.nivel,
      this.status, this.empresa, this.cargo, this.remuneracao);

  factory VagasDetailResponseModel.fromJson(Map<String, dynamic> json) {
    String empresa = json['empresa']['usuario']['nome'];
    return VagasDetailResponseModel(
        json['id'],
        json['titulo'],
        json['descricao'],
        json['nivel'],
        json['status'],
        empresa,
        json['cargo'],
        json['remuneracao']);
  }
}
