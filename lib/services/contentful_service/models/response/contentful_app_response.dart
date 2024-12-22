class ContentfulAppResponse {
  String? message;
  AppResponse? data;

  ContentfulAppResponse({
    this.message,
    this.data,
  });

  factory ContentfulAppResponse.fromJson(Map<String, dynamic> json) => ContentfulAppResponse(
    message: json['message'],
    data: json['data'] == null ? null : AppResponse.fromJson(json['data']),
  );
}

class AppResponse {
  String? version;
  String? termsUrl;
  String? privacyUrl;

  AppResponse({
    this.version,
    this.termsUrl,
    this.privacyUrl,
  });

  factory AppResponse.fromJson(Map<String, dynamic> json) => AppResponse(
    version: json['version'],
    termsUrl: json['termsUrl'],
    privacyUrl: json['privacyUrl'],
  );
}
