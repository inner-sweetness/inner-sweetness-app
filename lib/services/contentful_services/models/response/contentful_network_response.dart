class ContentfulNetworksResponse {
  String? message;
  List<NetworkResponse> data;

  ContentfulNetworksResponse({
    this.message,
    this.data = const <NetworkResponse>[],
  });

  factory ContentfulNetworksResponse.fromJson(Map<String, dynamic> json) => ContentfulNetworksResponse(
    message: json['message'],
    data: json['data'] == null ? <NetworkResponse>[] : List<NetworkResponse>.from(json['data']!.map((x) => NetworkResponse.fromJson(x))),
  );
}

class NetworkResponse {
  String? name;
  String? url;
  String? image;

  NetworkResponse({
    this.name,
    this.url,
    this.image,
  });

  factory NetworkResponse.fromJson(Map<String, dynamic> json) => NetworkResponse(
    name: json['name'],
    url: json['url'],
    image: json['image'],
  );
}
