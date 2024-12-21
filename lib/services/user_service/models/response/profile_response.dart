class ProfileResponse {
  String? message;
  ProfileData? data;

  ProfileResponse({
    this.message,
    this.data,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) => ProfileResponse(
    message: json['message'],
    data: json['data'] == null ? null : ProfileData.fromJson(json['data']),
  );
}

class ProfileData {
  int? id;
  String? email;
  String? name;
  String? lastname;
  int? age;
  String? country;
  String? genere;
  String? avatar;

  ProfileData({
    this.id,
    this.email,
    this.name,
    this.lastname,
    this.age,
    this.country,
    this.genere,
    this.avatar,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
    id: json['id'],
    email: json['email'],
    name: json['name'],
    lastname: json['lastname'],
    age: json['age'],
    country: json['country'],
    genere: json['genere'],
    avatar: json['avatar'],
  );
}
