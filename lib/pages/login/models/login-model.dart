class Login {
  String email;
  String senha;

  Login(this.email, this.senha);

  Map<String, dynamic> toJson() => {
        'email': email,
        'senha': senha,
      };
}
