import 'package:imi/page/dettaglio.dart';

const String tableNotes = 'mggiac';

class MGGiacField {
  static final List<String> values = [
    id,
    id_ditta,
    cd_ar,
    cd_mg,
    giacenza,
    disponibile,
  ];
  static const String id = 'id';
  static const String cd_ar = 'cd_ar';
  static const String id_ditta = 'id_ditta';
  static const String cd_mg = 'cd_mg';
  static const String giacenza = 'giacenza';
  static const String disponibile = 'disponibile';
}

class MGGiac {
  final int? id;
  final String id_ditta;
  final String cd_mg;
  final String cd_ar;
  final String giacenza;
  final String disponibile;

  const MGGiac(
      {this.id,
      required this.disponibile,
      required this.cd_ar,
      required this.cd_mg,
      required this.giacenza,
      required this.id_ditta});

  static MGGiac fromJson(Map<String, Object?> json) => MGGiac(
        cd_ar: json[MGGiacField.cd_ar] as String,
        giacenza: json[MGGiacField.giacenza] as String,
        disponibile: json[MGGiacField.disponibile] as String,
        id_ditta: json[MGGiacField.id_ditta].toString() as String,
        cd_mg: json[MGGiacField.cd_mg] as String,
      );

  Map<String, Object?> toJson() => {
        MGGiacField.giacenza: giacenza,
        MGGiacField.id_ditta: id_ditta,
        MGGiacField.disponibile: disponibile,
        MGGiacField.cd_mg: cd_mg,
        MGGiacField.cd_ar: cd_ar,
      };

  MGGiac copy({
    int? id,
    String? id_ditta,
    String? giacenza,
    String? disponibile,
    String? cd_mg,
    String? cd_ar,
  }) =>
      MGGiac(
        id: id ?? this.id,
        giacenza: giacenza ?? this.giacenza,
        disponibile: disponibile ?? this.disponibile,
        id_ditta: id_ditta ?? this.id_ditta,
        cd_mg: cd_mg ?? this.cd_mg,
        cd_ar: cd_ar ?? this.cd_ar,
      );
}
