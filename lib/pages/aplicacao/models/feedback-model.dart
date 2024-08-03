class FeedbackModel {
  String idAplicacao;
  String usuario;
  String feedback;

  FeedbackModel (this.idAplicacao, this.usuario, this.feedback);

  Map<String, dynamic> toJson() => {
        'idAplicacao': idAplicacao,
        'usuario': usuario,
        'feedback': feedback,
      };
}