class ListCeritaModel {
  final bool? error;
  final String? message;
  final List<CeritaModel>? listCerita;

  ListCeritaModel({
    this.error,
    this.message,
    this.listCerita
  });

  factory ListCeritaModel.fromJson(Map<String, dynamic> json)
  =>
      ListCeritaModel(
        error: json['error'],
        message: json['message'],
        listCerita: (json['listStory'] as List<dynamic>?)
              ?.map((cerita) => CeritaModel.fromJson(cerita))
              .toList()
      );

  Map<String, dynamic> toJson(){
    return{
      'error' : error,
      'message' : message,
      'listStory' : listCerita?.map((cerita) => cerita.toJson()).toList()
    };
  }
}

class CeritaModel {
  final String? id;
  final String? name;
  final String? description;
  final String? photoUrl;
  final String? createdAt;
  final num? lat;
  final num? lon;

  CeritaModel({
    this.id,
    this.name,
    this.description,
    this.photoUrl,
    this.createdAt,
    this.lat,
    this.lon
  });

  factory CeritaModel.fromJson(Map<String, dynamic> json)
  =>
      CeritaModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        photoUrl: json['photoUrl'],
        createdAt: json['createdAt'],
        lat: json['lat'],
        lon: json['lon'],
      );

  Map<String, dynamic> toJson(){
    return{
      'id' : id,
      'name' : name,
      'description' : description,
      'photoUrl' : photoUrl,
      'createdAt' : createdAt,
      'lat' : lat,
      'lon' : lon
    };
  }
}





















