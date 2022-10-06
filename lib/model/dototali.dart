const String tableNotes = 'dotatali';

class DOTotaliField {
  static final List<String> values = [
    id,
    id_dotes,
    id_ditta,
    totimponibilev,
    totimpostav,
    totdocumentov
  ];
  static const String id = 'id';
  static const String id_dotes = 'id_dotes';
  static const String id_ditta = 'id_ditta';
  static const String totimponibilev = 'totimponibilev';
  static const String totimpostav = 'totimpostav';
  static const String totdocumentov = 'totdocumentov';
}

class DOTotali {
  final int? id;
  final String id_dotes;
  final String id_ditta;
  final String totimponibilev;
  final String totimpostav;
  final String totdocumentov;

  const DOTotali(
      {this.id,
      required this.id_dotes,
      required this.id_ditta,
      required this.totimponibilev,
      required this.totimpostav,
      required this.totdocumentov});

  static DOTotali fromJson(Map<String, Object?> json) => DOTotali(
        totimponibilev: json[DOTotaliField.totimponibilev].toString(),
        id_ditta: json[DOTotaliField.id_ditta].toString(),
        id_dotes: json[DOTotaliField.id_dotes].toString(),
        totimpostav: json[DOTotaliField.totimpostav].toString(),
        totdocumentov: json[DOTotaliField.totdocumentov].toString(),
      );

  Map<String, Object?> toJson() => {
        DOTotaliField.totimponibilev: totimponibilev,
        DOTotaliField.id_ditta: id_ditta,
        DOTotaliField.totimpostav: totimpostav,
        DOTotaliField.id_dotes: id_dotes,
        DOTotaliField.totdocumentov: totdocumentov,
      };

  DOTotali copy({
    int? id,
    String? id_dotes,
    String? id_ditta,
    String? totimponibilev,
    String? totimpostav,
    String? totdocumentov,
  }) =>
      DOTotali(
        id: id ?? this.id,
        id_dotes: id_dotes ?? this.id_dotes,
        id_ditta: id_ditta ?? this.id_ditta,
        totimponibilev: totimponibilev ?? this.totimponibilev,
        totimpostav: totimpostav ?? this.totimpostav,
        totdocumentov: totdocumentov ?? this.totdocumentov,
      );
}
