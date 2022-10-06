const String tableNotes = 'lsscaglione';

class LSScaglioneField {
  static final List<String> values = [
    id,
    id_ditta,
    id_lsarticolo,
    finoaqta,
    prezzo,
  ];
  static const String id = 'id';
  static const String id_lsarticolo = 'id_lsarticolo';
  static const String id_ditta = 'id_ditta';
  static const String finoaqta = 'finoaqta';
  static const String prezzo = 'prezzo';
}

class LSScaglione {
  final int? id;
  final String id_ditta;
  final String id_lsarticolo;
  final String finoaqta;
  final String prezzo;

  const LSScaglione(
      {this.id,
      required this.id_lsarticolo,
      required this.prezzo,
      required this.finoaqta,
      required this.id_ditta});

  static LSScaglione fromJson(Map<String, Object?> json) => LSScaglione(
        finoaqta: json[LSScaglioneField.finoaqta].toString(),
        id_lsarticolo: json[LSScaglioneField.id_lsarticolo].toString(),
        prezzo: json[LSScaglioneField.prezzo].toString(),
        id_ditta: json[LSScaglioneField.prezzo].toString(),
      );

  Map<String, Object?> toJson() => {
        LSScaglioneField.finoaqta: finoaqta,
        LSScaglioneField.id_ditta: id_ditta,
        LSScaglioneField.id_lsarticolo: id_lsarticolo,
        LSScaglioneField.prezzo: prezzo,
      };

  LSScaglione copy({
    int? id,
    String? provvigione,
    String? id_ditta,
    String? sconto,
    String? prezzo,
    String? finoaqta,
    String? id_lsarticolo,
  }) =>
      LSScaglione(
        id: id ?? this.id,
        id_lsarticolo: id_lsarticolo ?? this.id_lsarticolo,
        id_ditta: id_ditta ?? this.id_ditta,
        prezzo: prezzo ?? this.prezzo,
        finoaqta: finoaqta ?? this.finoaqta,
      );
}
