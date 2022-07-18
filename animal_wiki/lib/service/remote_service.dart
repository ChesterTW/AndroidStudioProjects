import '../model/animal.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<Animal>?> getPosts() async {
    var client = http.Client();
    var url = Uri.parse("https://localhost:7036/animal/ListAnimal");
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var json = response.body;
      return animalFromJson(json);
    }
    return null;
  }
}
