const String tableNotes = 'arGruppo1';

class ARGruppo1Field {
  static final List<String> values = [id, id_ditta, cd_arGruppo1, descrizione];

  static const String id = 'id';
  static const String id_ditta = 'id_ditta';
  static const String cd_arGruppo1 = 'cd_arGruppo1';
  static const String descrizione = 'descrizione';
}

class ARGruppo1 {
  final int? id;
  final String id_ditta;
  final String cd_arGruppo1;
  final String descrizione;

  const ARGruppo1(
      {this.id,
      required this.id_ditta,
      required this.cd_arGruppo1,
      required this.descrizione});

  static ARGruppo1 fromJson(Map<String, Object?> json) => ARGruppo1(
      id: json[ARGruppo1Field.id] as int?,
      id_ditta: json[ARGruppo1Field.id_ditta] as String,
      cd_arGruppo1: json[ARGruppo1Field.cd_arGruppo1] as String,
      descrizione: json[ARGruppo1Field.descrizione] as String);

  Map<String, Object?> toJson() => {
        ARGruppo1Field.id: id,
        ARGruppo1Field.id_ditta: id_ditta,
        ARGruppo1Field.cd_arGruppo1: cd_arGruppo1,
        ARGruppo1Field.descrizione: descrizione,
      };

  ARGruppo1 copy(
          {int? id,
          String? id_ditta,
          String? cd_arGruppo1,
          String? descrizione}) =>
      ARGruppo1(
        id: id ?? this.id,
        id_ditta: id_ditta ?? this.id_ditta,
        cd_arGruppo1: cd_arGruppo1 ?? this.cd_arGruppo1,
        descrizione: descrizione ?? this.descrizione,
      );
}
