class RetornoCadastroPerfil {
  String id;
  num tipo;

  RetornoCadastroPerfil(this.id, this.tipo);

  Map<String, dynamic> toJson() => {
        'id': id,
        'tipo': tipo,
      };

  factory RetornoCadastroPerfil.fromJson(Map<String, dynamic> json) {
    return RetornoCadastroPerfil(
      json['id'],
      json['tipo'],
    );
  }
}
