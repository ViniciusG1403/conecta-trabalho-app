class Login {
  String email;
  String password;

  Login(this.email, this.password);

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}
