class ResendActivateCode {
  String id;
  String subject;
  String email;

  ResendActivateCode(this.id, this.subject, this.email);

  Map<String, dynamic> toJson() => {
        'id': id,
        'subject': subject,
        'email': email,
      };
}
