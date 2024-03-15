import 'package:conectatrabalho/pages/initial/models/user-model.dart';

class VagasRetornoModel {
  String id;
  String titulo;
  String descricao;
  String nivel;
  int status;
  String empresa;

  VagasRetornoModel(this.id, this.titulo, this.descricao, this.nivel,
      this.status, this.empresa);

  Map<String, dynamic> toJson() => {
        'id': id,
        'titulo': titulo,
        'descricao': descricao,
        'nivel': nivel,
        'status': status,
        'empresa': empresa,
      };

  factory VagasRetornoModel.fromJson(Map<String, dynamic> json) {
    return VagasRetornoModel(json['id'], json['titulo'], json['descricao'],
        json['nivel'], json['status'], json['empresa']);
  }

  static List<VagasRetornoModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => VagasRetornoModel.fromJson(json)).toList();
  }
}
