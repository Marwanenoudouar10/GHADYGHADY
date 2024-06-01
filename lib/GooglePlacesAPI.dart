import 'package:http/http.dart' as http;
import 'dart:convert';

class GooglePlacesAPI {
  static const String apiKey = 'AIzaSyASpbw3M5M50lkG7k9Evcmsa-8jO0Sgt80';

  static Future<List<dynamic>> getSuggestions(String query) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['predictions'];
    } else {
      throw Exception('Failed to load suggestions');
    }
  }

  static Future<Map<String, dynamic>> getPlaceDetails(String placeId) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['result'];
    } else {
      throw Exception('Failed to load place details');
    }
  }
}
