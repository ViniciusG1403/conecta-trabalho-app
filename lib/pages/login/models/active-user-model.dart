class ActiveUserModel {
  String code;

  ActiveUserModel(this.code);

  Map<String, dynamic> toJson() => {
        'code': code,
      };
}
