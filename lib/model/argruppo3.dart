const String tableNotes = 'arGruppo3';

class ARGruppo3Field {
  static final List<String> values = [
    id,
    id_ditta,
    cd_arGruppo1,
    cd_arGruppo2,
    cd_arGruppo3,
    descrizione
  ];

  static const String id = 'id';
  static const String id_ditta = 'id_ditta';
  static const String cd_arGruppo1 = 'cd_arGruppo1';
  static const String cd_arGruppo2 = 'cd_arGruppo2';
  static const String cd_arGruppo3 = 'cd_arGruppo3';
  static const String descrizione = 'descrizione';
}

class ARGruppo3 {
  final int? id;
  final String id_ditta;
  final String cd_arGruppo1;
  final String cd_arGruppo2;
  final String cd_arGruppo3;
  final String descrizione;

  const ARGruppo3(
      {this.id,
      required this.id_ditta,
      required this.cd_arGruppo1,
      required this.cd_arGruppo2,
      required this.cd_arGruppo3,
      required this.descrizione});

  static ARGruppo3 fromJson(Map<String, Object?> json) => ARGruppo3(
      id: json[ARGruppo3Field.id] as int?,
      id_ditta: json[ARGruppo3Field.id_ditta] as String,
      cd_arGruppo1: json[ARGruppo3Field.cd_arGruppo1] as String,
      cd_arGruppo2: json[ARGruppo3Field.cd_arGruppo2] as String,
      cd_arGruppo3: json[ARGruppo3Field.cd_arGruppo3] as String,
      descrizione: json[ARGruppo3Field.descrizione] as String);

  Map<String, Object?> toJson() => {
        ARGruppo3Field.id: id,
        ARGruppo3Field.id_ditta: id_ditta,
        ARGruppo3Field.cd_arGruppo1: cd_arGruppo1,
        ARGruppo3Field.cd_arGruppo2: cd_arGruppo2,
        ARGruppo3Field.cd_arGruppo3: cd_arGruppo3,
        ARGruppo3Field.descrizione: descrizione,
      };

  ARGruppo3 copy(
          {int? id,
          String? id_ditta,
          String? cd_arGruppo1,
          String? cd_arGruppo2,
          String? cd_arGruppo3,
          String? descrizione}) =>
      ARGruppo3(
        id: id ?? this.id,
        id_ditta: id_ditta ?? this.id_ditta,
        cd_arGruppo1: cd_arGruppo3 ?? this.cd_arGruppo1,
        cd_arGruppo2: cd_arGruppo2 ?? this.cd_arGruppo2,
        cd_arGruppo3: cd_arGruppo3 ?? this.cd_arGruppo3,
        descrizione: descrizione ?? this.descrizione,
      );
}
