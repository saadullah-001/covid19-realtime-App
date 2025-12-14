import 'dart:convert';
import 'package:crona_app/Services/Utilities/world_api.dart';
import 'package:http/http.dart' as http;
import 'package:crona_app/Models/world_stats_model.dart';

class StateServices {
  Future<WorldStatsModel> fetchWorldStatsModelAPi() async {
    var response = await http.get(Uri.parse(WorldApi.worldStatesAPi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return WorldStatsModel.fromJson(data);
    } else {
      throw Exception('error');
    }
  }

  Future<List<dynamic>> fetchCountriesApi() async {
    var response = await http.get(Uri.parse(WorldApi.countriesList));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      print('good');
      return data;
    } else {
      throw Exception('error');
    }
  }
}
