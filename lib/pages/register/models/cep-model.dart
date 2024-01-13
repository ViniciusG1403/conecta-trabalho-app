class Cep {
  String cep;
  String logradouro;
  String complemento;
  String bairro;
  String localidade;
  String uf;
  String ibge;
  String gia;
  String ddd;
  String siafi;

  Cep(this.cep, this.logradouro, this.complemento, this.bairro, this.localidade,
      this.uf, this.ibge, this.gia, this.ddd, this.siafi);

  factory Cep.fromJson(Map<String, dynamic> json) {
    return Cep(
        json['cep'],
        json['logradouro'],
        json['complemento'],
        json['bairro'],
        json['localidade'],
        json['uf'],
        json['ibge'],
        json['gia'],
        json['ddd'],
        json['siafi']);
  }
}
