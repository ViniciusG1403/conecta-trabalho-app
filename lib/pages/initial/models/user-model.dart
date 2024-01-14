class User {
  String name;
  String email;
  int type;

  User(this.name, this.email, this.type);

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'type': type,
      };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['name'],
      json['email'],
      json['type'],
    );
  }
}
