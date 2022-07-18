import 'dart:convert';

List<Animal> animalFromJson(String str) =>
    List<Animal>.from(json.decode(str).map((x) => Animal.fromJson(x)));

String animalToJson(List<Animal> data) =>
    json.encode(List<dynamic>.from(data.map((e) => e.toJson())));

/// Animal 類型
class Animal {
  /// 類型 Animal 的建構式
  Animal({
    required this.id,
    required this.chName,
    required this.enName,
    required this.description,
    required this.content,
    required this.img,
    required this.saved,
    required this.loved,
    required this.loveCount,
  });

  final int id;

  /// 宣告 String 類型的 chName，負責儲存「中文名稱」。
  final String chName;

  /// 宣告 String 類型的 enName，負責儲存「英文名稱」。
  final String enName;

  /// 宣告 String 類型的 description，負責儲存「簡介」。
  final String description;

  /// 宣告 String 類型的 img，負責儲存「內容」。
  final String content;

  /// 宣告 String 類型的 img，負責儲存「圖片路徑」。
  final String img;

  /// 宣告 bool 類型的 saved，負責儲存「是否存儲的狀態」。
  bool saved;

  /// 宣告 bool 類型的 loved，負責儲存「是否愛了」。
  bool loved;

  /// 宣告 int 類型的 loveCount，負責儲存「愛心數量」。
  int loveCount;

  /// 接收 Json 檔，將裡頭的數值定義給對應的「變數」。
  factory Animal.fromJson(Map<String, dynamic> json) => Animal(
      id: json["id"],
      chName: json["chName"],
      enName: json["enName"],
      description: json["description"],
      content: json["content"],
      img: json["img"],
      saved: json["saved"],
      loved: json["loved"],
      loveCount: json["loveCount"]);

  /// 發送 Json 檔，將「變數的值」輸入於對應的欄位中。
  Map<String, dynamic> toJson() => {
        "id": id,
        "chName": chName,
        "enName": enName,
        "description": description,
        "content": content,
        "img": img,
        "saved": saved,
        "loved": loved,
        "loveCount": loveCount,
      };
}
