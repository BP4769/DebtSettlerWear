class GospodinjstvoModel {
  String imeGospodinjstva;
  String gsToken;
  bool isAdmin;

  GospodinjstvoModel({
    required this.imeGospodinjstva,
    required this.gsToken,
    this.isAdmin = false,
  });

  factory GospodinjstvoModel.fromJson(Map<String, dynamic> parsedJson) {
    return GospodinjstvoModel(
      imeGospodinjstva: parsedJson['imeGospodinjstva'],
      gsToken: parsedJson['GStoken'],
      isAdmin: parsedJson['isAdmin'],
    );
  }

  Map<String, dynamic> toJson() => {
    "imeGospodinjstva": imeGospodinjstva,
    "GStoken": gsToken,
    "isAdmin": isAdmin,
  };
}