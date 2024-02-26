class Photos {
  int? id;
  String? url;
  String? photographer_url;
  int? photographer_id;
  String? photographer;
  bool? liked;
  int? height;
  String? avg_color;
  String? alt;
  int? width;
  Model? src;
  Photos({
    required this.id,
    required this.url,
    required this.photographer_url,
    required this.photographer_id,
    required this.photographer,
    required this.liked,
    required this.height,
    required this.avg_color,
    required this.alt,
    required this.width,
    required this.src,
  });
  factory Photos.fromJason(Map<String, dynamic> json) {
    return Photos(
        id: json["id"],
        url: json["url"],
        photographer_url: json["photographer_url"],
        photographer_id: json["photographer_id"],
        photographer: json["photographer"],
        liked: json["liked"],
        height: json["height"],
        avg_color: json["avg_color"],
        alt: json["alt"],
        width: json["width"],
        src: Model.fromJason(json["src"]));
  }
}

class Model {
  String? tiny;
  String? small;
  String? portrait;
  String? original;
  String? medium;
  String? large2x;
  String? large;
  String? landscape;
  Model(
      {required this.tiny,
      required this.small,
      required this.portrait,
      required this.original,
      required this.medium,
      required this.large2x,
      required this.large,
      required this.landscape});
  factory Model.fromJason(Map<String, dynamic> json) {
    return Model(
        tiny: json["tiny"],
        small: json["small"],
        portrait: json["portrait"],
        original: json["original"],
        medium: json["medium"],
        large2x: json["large2x"],
        large: json["large"],
        landscape: json["landscape"]);
  }
}

class FinalModel {
  int? total_results;
  int? per_page;
  int? page;
  String? next_page;
  List<Photos>? photos;
  FinalModel(
      {required this.total_results,
      required this.per_page,
      required this.page,
      required this.next_page,
      required this.photos});
  factory FinalModel.fromJason(Map<String, dynamic> json) {
    List<Photos>? listData = [];
    for (Map<String, dynamic> eachNote in json["photos"]) {
      var eachModel = Photos.fromJason(eachNote);
      listData.add(eachModel);
    }

    return FinalModel(
        total_results: json["total_results"],
        per_page: json["per_page"],
        page: json["page"],
        next_page: json["next_page"],
        photos: listData);
  }
}
