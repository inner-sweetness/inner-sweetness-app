class AppApiException implements Exception {
  final String message;

  const AppApiException(this.message);
}