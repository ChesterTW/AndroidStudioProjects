import '../model/animal.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  /// 創建非同步的方法 getPosts()，負責讀取 API 資料，
  /// 以 List<Animal> 類型回傳，且數值可能為 null。
  Future<List<Animal>?> getAnimals() async {
    // http.Client() as client
    var client = http.Client();

    // 定義 url 為 API 的 URL。
    var url = Uri.parse("https://localhost:7036/animal/ListAnimal");

    // 宣告 response，並定義為 client.get(url) 的回傳值。
    var response = await client.get(url);

    // 判斷式：response.statusCode 是否等於 200。（確認是否成功）
    if (response.statusCode == 200) {
      // 宣告 json，並給予 response.body 中的數值。
      var json = response.body;
      // 呼叫類別 Animal 的方法 animalFromJson，給予 json，以 decode 並回傳。
      return animalFromJson(json);
    }
    // 若 response.statusCode 不等於 200，將回傳 null。
    return null;
  }
}
