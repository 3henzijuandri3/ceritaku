class CeritaDetailModel {
  final bool? error;
  final String? message;
  final CeritaModel? detailCerita;

  CeritaDetailModel({
    this.error,
    this.message,
    this.detailCerita
  });

  factory CeritaDetailModel.fromJson(Map<String, dynamic> json)
  =>
      CeritaDetailModel(
          error: json['error'],
          message: json['message'],
          detailCerita: json['story'] != null
              ? new CeritaModel.fromJson(json['story'])
              : null
      );
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