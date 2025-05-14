import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstant {
  static const String baseUrl = "https://api.themoviedb.org/3";
  static String apiKey = dotenv.env['TMDB_API_KEY']!;
  static String chatApiKey = dotenv.env['CHAT_API_KEY']!;
  static String token = dotenv.env['TMDB_TOKEN']!;
  static const String getRecommendationApi = "https://openrouter.ai/api/v1/chat/completions";
  static const String getrequestToken = "$baseUrl/authentication/token/new";
  static const String createSessionId = "$baseUrl/authentication/session/new";
  static const String getNowPlayingMovie = "$baseUrl/movie/now_playing";
  static const String getUpcomingMovie = "$baseUrl/movie/upcoming";
  static const String getPopularMovie = "$baseUrl/movie/popular";
  static const String getTopRatedMovie = "$baseUrl/movie/top_rated";
  static String getMovieDetails(int movieId) {
    return "$baseUrl/movie/$movieId";
  }
  static String getMovieVideo(int movieId) {
    return "$baseUrl/movie/$movieId/videos";
  }

  static String getMovieCast(int movieId) {
    return "$baseUrl/movie/$movieId/credits";
  }

}
