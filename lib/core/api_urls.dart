class ApiUrls {
  // Base URL — رح تتغير لما رفيقتك تخلص
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  // Auth
  static const String login = '$baseUrl/login';
  static const String logout = '$baseUrl/logout';

  // Behavior
  static const String behaviors = '$baseUrl/behaviors';

  // Report
  static const String reports = '$baseUrl/reports';

  // PECS Cards
  static const String pecsCards = '$baseUrl/pecs-cards';

  // Guidance Library
  static const String articles = '$baseUrl/articles';

  // Recommendations
  static const String recommendations = '$baseUrl/recommendations';

  // Users (Admin)
  static const String users = '$baseUrl/users';
}