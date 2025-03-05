import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


final String apiKey = dotenv.env['NEWS_API_KEY'] ?? "";
final String apiUrl = "https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey";

class NewsController extends GetxController {
  var newsList = [].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchNews();
    super.onInit();
  }

  Future<void> fetchNews() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        newsList.value = data['articles'];
      } else {
        throw Exception("Failed to load news");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }
}
