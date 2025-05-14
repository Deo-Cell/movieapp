import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movieapp/core/constants/api_constant.dart';
import 'package:movieapp/features/chat/data/models/chat_model.dart';

abstract class ChatRemoteDataSource {
  Future<List<ChatResponseModel>> getRecommendation(String prompt);
}

@LazySingleton(as: ChatRemoteDataSource)
class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final Dio dio;

  ChatRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ChatResponseModel>> getRecommendation(String prompt) async {
    final url = ApiConstant.getRecommendationApi;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${ApiConstant.chatApiKey}",
    };
    final data = {
      "model": "gpt-3.5-turbo",
      "messages": [
        {
          "role": "system",
          "content": """
You are a movie expert assistant. Your task is to extract the search criteria mentioned by the user to recommend movies from the TMDB API.

You must return only a JSON object with the following fields **if available** :
- "genre" : the movie genre (ex: action, comedy, horror)
- "langue" : ISO 639-1 language code (ex: fr, en)
- "date_min" : release date minimum (format AAAA-MM-JJ)
- "date_max" : release date maximum (format AAAA-MM-JJ)
- "durée_max" : maximum duration in minutes (int)
- "vote_average_min" : minimum average rating (float or int)

⚠️ Your response must be **exclusively** a valid JSON, **without any explanatory text**.
"""
        },
        {"role": "user", "content": prompt.trim()}
      ],
    };

    try {
      // Appel à l'API d'OpenAI 
      final response = await dio.post(
        url,
        options: Options(headers: headers),
        data: data,
      );

      if (response.statusCode == 200) {
        final content = response.data['choices'][0]['message']['content'];

        // 🔍 Convertir la réponse texte en JSON
        final jsonCriteria = jsonDecode(content);
        final criteria = ChatCriteriaModel.fromJson(jsonCriteria);

        // 🎭 Mapper le genre en ID TMDB
        final genreMap = {
          "action": 28,
          "animation": 16,
          "adventure": 12,
          "comedy": 35,
          "crime": 80,
          "documentary": 99,
          "drama": 18,
          "family": 10751,
          "fantasy": 14,
          "war": 10752,
          "history": 36,
          "horror": 27,
          "music": 10402,
          "mystery": 9648,
          "romance": 10749,
          "sci-fi": 878,
          "thriller": 53,
          "tv": 10770,
          "western": 37,
        };

        final genreId = criteria.genre != null
            ? genreMap[criteria.genre!.toLowerCase()]?.toString()
            : null;

        // 📦 Paramètres pour l’API TMDB
        final tmdbParams = {
          'api_key': ApiConstant.apiKey,
          if (genreId != null) 'with_genres': genreId,
          if (criteria.dateMin != null) 'primary_release_date.gte': criteria.dateMin!,
          if (criteria.dateMax != null) 'primary_release_date.lte': criteria.dateMax!,
          if (criteria.voteAverageMin != null) 'vote_average.gte': criteria.voteAverageMin.toString(),
          if (criteria.dureeMax != null) 'with_runtime.lte': criteria.dureeMax.toString(),
          'language': criteria.langue ?? 'fr',
        };

        // 🔥 Appel à TMDB
        final tmdbUrl = Uri.https('api.themoviedb.org', '/3/discover/movie', tmdbParams);
        final tmdbResponse = await dio.get(tmdbUrl.toString());

        final results = tmdbResponse.data['results'] as List<dynamic>;

        return results.map((json) => ChatResponseModel.fromJson(json)).toList();
      } else {
        throw Exception('Échec requête OpenAI: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Erreur Dio : ${e.message}');
    } catch (e) {
      throw Exception('Erreur inattendue : $e');
    }
  }
}