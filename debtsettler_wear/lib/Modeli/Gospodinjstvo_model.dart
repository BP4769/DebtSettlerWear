class Gospodinjstvo {
  String imeGospodinjstva;
  String gsToken;
  bool isAdmin;

  Gospodinjstvo({
    required this.imeGospodinjstva,
    required this.gsToken,
    this.isAdmin = false,
  });

  factory Gospodinjstvo.fromJson(Map<String, dynamic> parsedJson) {
    return Gospodinjstvo(
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