const String tableNotes = 'arGruppo2';

class ARGruppo2Field {
  static final List<String> values = [
    id,
    id_ditta,
    cd_arGruppo1,
    cd_arGruppo2,
    descrizione
  ];

  static const String id = 'id';
  static const String id_ditta = 'id_ditta';
  static const String cd_arGruppo1 = 'cd_arGruppo1';
  static const String cd_arGruppo2 = 'cd_arGruppo2';
  static const String descrizione = 'descrizione';
}

class ARGruppo2 {
  final int? id;
  final String id_ditta;
  final String cd_arGruppo1;
  final String cd_arGruppo2;
  final String descrizione;

  const ARGruppo2(
      {this.id,
      required this.id_ditta,
      required this.cd_arGruppo1,
      required this.cd_arGruppo2,
      required this.descrizione});

  static ARGruppo2 fromJson(Map<String, Object?> json) => ARGruppo2(
      id: json[ARGruppo2Field.id] as int?,
      id_ditta: json[ARGruppo2Field.id_ditta] as String,
      cd_arGruppo1: json[ARGruppo2Field.cd_arGruppo1] as String,
      cd_arGruppo2: json[ARGruppo2Field.cd_arGruppo2] as String,
      descrizione: json[ARGruppo2Field.descrizione] as String);

  Map<String, Object?> toJson() => {
        ARGruppo2Field.id: id,
        ARGruppo2Field.id_ditta: id_ditta,
        ARGruppo2Field.cd_arGruppo1: cd_arGruppo1,
        ARGruppo2Field.cd_arGruppo2: cd_arGruppo2,
        ARGruppo2Field.descrizione: descrizione,
      };

  ARGruppo2 copy(
          {int? id,
          String? id_ditta,
          String? cd_arGruppo1,
          String? cd_arGruppo2,
          String? descrizione}) =>
      ARGruppo2(
        id: id ?? this.id,
        id_ditta: id_ditta ?? this.id_ditta,
        cd_arGruppo1: cd_arGruppo2 ?? this.cd_arGruppo1,
        cd_arGruppo2: cd_arGruppo2 ?? this.cd_arGruppo2,
        descrizione: descrizione ?? this.descrizione,
      );
}
