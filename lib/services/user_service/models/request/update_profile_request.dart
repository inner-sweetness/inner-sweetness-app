class UpdateProfileRequest {
  String? name;
  String? lastname;
  int? age;
  String? country;
  String? email;
  String? genere;

  UpdateProfileRequest({
    this.name,
    this.lastname,
    this.age,
    this.country,
    this.email,
    this.genere,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'lastname': lastname,
    'age': age,
    'country': country,
    'email': email,
    'genere': genere,
  };
}
