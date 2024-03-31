import 'package:conectatrabalho/pages/initial/models/user-model.dart';

class VagasListaResponseModel {
  String id;
  String titulo;
  String descricao;
  String nivel;
  int status;
  String empresa;
  String cargo;

  VagasListaResponseModel(this.id, this.titulo, this.descricao, this.nivel,
      this.status, this.empresa, this.cargo);

  Map<String, dynamic> toJson() => {
        'id': id,
        'titulo': titulo,
        'descricao': descricao,
        'nivel': nivel,
        'status': status,
        'empresa': empresa,
        'cargo': cargo
      };

  factory VagasListaResponseModel.fromJson(Map<String, dynamic> json) {
    return VagasListaResponseModel(
        json['id'],
        json['titulo'],
        json['descricao'],
        json['nivel'],
        json['status'],
        json['empresa'],
        json['cargo']);
  }

  static List<VagasListaResponseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => VagasListaResponseModel.fromJson(json))
        .toList();
  }
}
