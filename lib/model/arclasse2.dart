const String tableNotes = 'arclasse2';

class ARClasse2Field {
  static final List<String> values = [
    id,
    id_ditta,
    cd_ARClasse1,
    cd_ARClasse2,
    descrizione
  ];

  static const String id = 'id';
  static const String id_ditta = 'id_ditta';
  static const String cd_ARClasse1 = 'cd_ARClasse1';
  static const String cd_ARClasse2 = 'cd_ARClasse2';
  static const String descrizione = 'descrizione';
}

class ARClasse2 {
  final int? id;
  final String id_ditta;
  final String cd_ARClasse1;
  final String cd_ARClasse2;
  final String descrizione;

  const ARClasse2(
      {this.id,
      required this.id_ditta,
      required this.cd_ARClasse1,
      required this.cd_ARClasse2,
      required this.descrizione});

  static ARClasse2 fromJson(Map<String, Object?> json) => ARClasse2(
      id: json[ARClasse2Field.id] as int?,
      id_ditta: json[ARClasse2Field.id_ditta] as String,
      cd_ARClasse1: json[ARClasse2Field.cd_ARClasse1] as String,
      cd_ARClasse2: json[ARClasse2Field.cd_ARClasse2] as String,
      descrizione: json[ARClasse2Field.descrizione] as String);

  Map<String, Object?> toJson() => {
        ARClasse2Field.id: id,
        ARClasse2Field.id_ditta: id_ditta,
        ARClasse2Field.cd_ARClasse1: cd_ARClasse1,
        ARClasse2Field.cd_ARClasse2: cd_ARClasse2,
        ARClasse2Field.descrizione: descrizione,
      };

  ARClasse2 copy(
          {int? id,
          String? id_ditta,
          String? cd_ARClasse1,
          String? cd_ARClasse2,
          String? descrizione}) =>
      ARClasse2(
        id: id ?? this.id,
        id_ditta: id_ditta ?? this.id_ditta,
        cd_ARClasse1: cd_ARClasse1 ?? this.cd_ARClasse1,
        cd_ARClasse2: cd_ARClasse2 ?? this.cd_ARClasse2,
        descrizione: descrizione ?? this.descrizione,
      );
}
