
DateTime? checkDateTime(String? dateTime) {
  if (dateTime !=  null) {
    return DateTime.parse(dateTime);
  } else {
    return null;
  }
}