class ResponseCityList {
  ResponseCityList({
      this.data,});

  ResponseCityList.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(CityData.fromJson(v));
      });
    }
  }
  List<CityData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class CityData {
  CityData({
      this.id, 
      this.wikiDataId, 
      this.type, 
      this.city, 
      this.name, 
      this.country, 
      this.countryCode, 
      this.region, 
      this.regionCode, 
      this.regionWdId, 
      this.latitude, 
      this.longitude, 
      this.population,});

  CityData.fromJson(dynamic json) {
    id = json['id'];
    wikiDataId = json['wikiDataId'];
    type = json['type'];
    city = json['city'];
    name = json['name'];
    country = json['country'];
    countryCode = json['countryCode'];
    region = json['region'];
    regionCode = json['regionCode'];
    regionWdId = json['regionWdId'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    population = json['population'];
  }
  int? id;
  String? wikiDataId;
  String? type;
  String? city;
  String? name;
  String? country;
  String? countryCode;
  String? region;
  String? regionCode;
  String? regionWdId;
  double? latitude;
  double? longitude;
  int? population;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['wikiDataId'] = wikiDataId;
    map['type'] = type;
    map['city'] = city;
    map['name'] = name;
    map['country'] = country;
    map['countryCode'] = countryCode;
    map['region'] = region;
    map['regionCode'] = regionCode;
    map['regionWdId'] = regionWdId;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['population'] = population;
    return map;
  }

}