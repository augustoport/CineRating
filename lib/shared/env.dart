class Environment {
  static const String apiBaseUrl = 'https://api.themoviedb.org/3';

  static const String mediaUrl = 'https://media.themoviedb.org/t/p/w400';

  static const String token = String.fromEnvironment('TOKEN');

  static const String apikey = String.fromEnvironment('API_KEY');
}
