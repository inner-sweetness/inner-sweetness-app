extension StringExtension on String {
  String get audioFileExtension {
    var lastIndex = lastIndexOf('/');
    if (lastIndex != -1) {
      var filenameWithQuery = substring(lastIndex + 1);
      var filename = Uri.decodeFull(filenameWithQuery.split('?').first);
      var dotIndex = filename.lastIndexOf('.');
      if (dotIndex != -1) {
        var fileExtension = filename.substring(dotIndex + 1);

        return '.$fileExtension';
      }
    }

    return '.mp3';
  }
}