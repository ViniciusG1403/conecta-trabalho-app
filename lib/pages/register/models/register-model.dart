class User {
  String name;
  String email;
  String password;
  String type;

  User(this.name, this.email, this.password, this.type);

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'type': type,
      };
}

class UserRegister {
  String name;
  String email;
  String password;
  String type;
  Localization localization;

  UserRegister(
      this.name, this.email, this.password, this.type, this.localization);

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'type': type,
        'localization': localization.toJson(),
      };
}

class Localization {
  String cep;
  String street;
  String number;
  String complement;
  String neighborhood;
  String city;
  String state;

  Localization(this.cep, this.street, this.number, this.complement,
      this.neighborhood, this.city, this.state);

  Map<String, dynamic> toJson() => {
        'cep': cep,
        'street': street,
        'number': number,
        'complement': complement,
        'neighborhood': neighborhood,
        'city': city,
        'state': state,
      };
}
