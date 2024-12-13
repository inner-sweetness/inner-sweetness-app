class RegisterResponse {
  String email;
  String name;
  String lastname;
  int age;
  String country;
  String genere;
  int id;

  RegisterResponse({
    required this.email,
    required this.name,
    required this.lastname,
    required this.age,
    required this.country,
    required this.genere,
    required this.id,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) => RegisterResponse(
    email: json['email'],
    name: json['name'],
    lastname: json['lastname'],
    age: json['age'],
    country: json['country'],
    genere: json['genere'],
    id: json['id'],
  );
}
