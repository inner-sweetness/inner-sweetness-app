class RegisterRequest {
  String email;
  String password;
  String name;
  String lastname;
  int age;
  String country;
  String genere;

  RegisterRequest({
    required this.email,
    required this.password,
    required this.name,
    required this.lastname,
    required this.age,
    required this.country,
    required this.genere,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'name': name,
    'lastname': lastname,
    'age': age,
    'country': country,
    'genere': genere,
  };
}
