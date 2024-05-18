enum RequestType { popular, upcoming }


extension IssuerTypeExtension on RequestType {
  String get value {
    switch (this) {
      case RequestType.popular:
        return 'popular';
      case RequestType.upcoming:
        return 'upcoming';
    }
  }
}
