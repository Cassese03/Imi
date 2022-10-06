const String tableNotes = 'lsarticolo';

class LSArticoloField {
  static final List<String> values = [
    id,
    provvigione,
    id_ditta,
    cd_ar,
    provvigione,
    id_lsrevisione,
    prezzo,
    sconto,
  ];
  static const String id = 'id';
  static const String provvigione = 'provvigione';
  static const String id_ditta = 'id_ditta';
  static const String cd_ar = 'cd_ar';
  static const String id_lsrevisione = 'id_lsrevisione';
  static const String prezzo = 'prezzo';
  static const String sconto = 'sconto';
}

class LSArticolo {
  final int? id;
  final String provvigione;
  final String id_ditta;
  final String cd_ar;
  final String id_lsrevisione;
  final String prezzo;
  final String sconto;

  const LSArticolo(
      {this.id,
      required this.id_ditta,
      required this.id_lsrevisione,
      required this.cd_ar,
      required this.prezzo,
      required this.sconto,
      required this.provvigione});

  static LSArticolo fromJson(Map<String, Object?> json) => LSArticolo(
        provvigione: json[LSArticoloField.provvigione].toString(),
        id_lsrevisione: json[LSArticoloField.id_lsrevisione].toString(),
        id_ditta: json[LSArticoloField.id_ditta].toString(),
        sconto: json[LSArticoloField.sconto].toString(),
        cd_ar: json[LSArticoloField.cd_ar].toString(),
        prezzo: json[LSArticoloField.prezzo].toString(),
      );

  Map<String, Object?> toJson() => {
        LSArticoloField.provvigione: provvigione,
        LSArticoloField.id_ditta: id_ditta,
        LSArticoloField.sconto: sconto,
        LSArticoloField.id_lsrevisione: id_lsrevisione,
        LSArticoloField.cd_ar: cd_ar,
        LSArticoloField.prezzo: prezzo,
      };

  LSArticolo copy({
    int? id,
    String? provvigione,
    String? id_ditta,
    String? sconto,
    String? cd_ar,
    String? prezzo,
    String? id_lsrevisione,
  }) =>
      LSArticolo(
        id: id ?? this.id,
        id_lsrevisione: id_lsrevisione ?? this.id_lsrevisione,
        provvigione: provvigione ?? this.provvigione,
        id_ditta: id_ditta ?? this.id_ditta,
        sconto: sconto ?? this.sconto,
        prezzo: prezzo ?? this.prezzo,
        cd_ar: cd_ar ?? this.cd_ar,
      );
}
