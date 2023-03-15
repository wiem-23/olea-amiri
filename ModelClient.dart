/* class Client {
  final int id;
  final int tel;
  final String nom, adresse, type;

  Client(
      {required this.id,
      required this.nom,
      required this.adresse,
      required this.type,
      required this.tel});

  factory Client.fromJson(Map<String, dynamic> map) => Client(
        id: map['id'] ?? 0,
        nom: map['nom'] ?? "",
        adresse: map['adresse'] ?? "",
        type: map['type'] ?? "",
        tel: map['tel'] ?? "",
      );
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nom": nom,
      "adresse": adresse,
      "type": type,
      "tel": tel,
    };
  }
}
 */