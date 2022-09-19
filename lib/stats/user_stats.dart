import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class user_stats {
  final baseUrl = "https://api.henrikdev.xyz";

  Future<List<dynamic>> getUserStats(
      String name, String tag, String location) async {
    String url = "$baseUrl/valorant/v1/mmr/$location/$name/$tag";

    final uri = Uri.parse(url);

    try {
      var response = await http.get(uri);

      if (response.statusCode == 200) {
        List<dynamic> fetchedStats = jsonDecode(response.body);

        return fetchedStats;
      } else {
        return [];
      }
    } on Exception catch (e) {
      return [];
    }
  }
}
