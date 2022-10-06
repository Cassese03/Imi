const String tableNotes = 'ARClasse3';

class ARClasse3Field {
  static final List<String> values = [
    id,
    id_ditta,
    cd_ARClasse3,
    cd_ARClasse2,
    cd_ARClasse1,
    descrizione
  ];

  static const String id = 'id';
  static const String id_ditta = 'id_ditta';
  static const String cd_ARClasse3 = 'cd_ARClasse3';
  static const String cd_ARClasse2 = 'cd_ARClasse2';
  static const String cd_ARClasse1 = 'cd_ARClasse1';
  static const String descrizione = 'descrizione';
}

class ARClasse3 {
  final int? id;
  final String id_ditta;
  final String cd_ARClasse3;
  final String cd_ARClasse2;
  final String cd_ARClasse1;
  final String descrizione;

  const ARClasse3(
      {this.id,
      required this.id_ditta,
      required this.cd_ARClasse3,
      required this.cd_ARClasse2,
      required this.cd_ARClasse1,
      required this.descrizione});

  static ARClasse3 fromJson(Map<String, Object?> json) => ARClasse3(
      id: json[ARClasse3Field.id] as int?,
      id_ditta: json[ARClasse3Field.id_ditta] as String,
      cd_ARClasse3: json[ARClasse3Field.cd_ARClasse3] as String,
      cd_ARClasse2: json[ARClasse3Field.cd_ARClasse2] as String,
      cd_ARClasse1: json[ARClasse3Field.cd_ARClasse1] as String,
      descrizione: json[ARClasse3Field.descrizione] as String);

  Map<String, Object?> toJson() => {
        ARClasse3Field.id: id,
        ARClasse3Field.id_ditta: id_ditta,
        ARClasse3Field.cd_ARClasse3: cd_ARClasse3,
        ARClasse3Field.cd_ARClasse2: cd_ARClasse2,
        ARClasse3Field.cd_ARClasse1: cd_ARClasse1,
        ARClasse3Field.descrizione: descrizione,
      };

  ARClasse3 copy(
          {int? id,
          String? id_ditta,
          String? cd_ARClasse3,
          String? cd_ARClasse2,
          String? cd_ARClasse1,
          String? descrizione}) =>
      ARClasse3(
        id: id ?? this.id,
        id_ditta: id_ditta ?? this.id_ditta,
        cd_ARClasse3: cd_ARClasse3 ?? this.cd_ARClasse3,
        cd_ARClasse2: cd_ARClasse2 ?? this.cd_ARClasse2,
        cd_ARClasse1: cd_ARClasse1 ?? this.cd_ARClasse1,
        descrizione: descrizione ?? this.descrizione,
      );
}
