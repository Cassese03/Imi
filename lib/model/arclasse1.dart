const String tableNotes = 'arclasse1';

class ARClasse1Field {
  static final List<String> values = [id, id_ditta, cd_arclasse1, descrizione];

  static const String id = 'id';
  static const String id_ditta = 'id_ditta';
  static const String cd_arclasse1 = 'cd_arclasse1';
  static const String descrizione = 'descrizione';
}

class ARClasse1 {
  final int? id;
  final String id_ditta;
  final String cd_arclasse1;
  final String descrizione;

  const ARClasse1(
      {this.id,
      required this.id_ditta,
      required this.cd_arclasse1,
      required this.descrizione});

  static ARClasse1 fromJson(Map<String, Object?> json) => ARClasse1(
      id: json[ARClasse1Field.id] as int?,
      id_ditta: json[ARClasse1Field.id_ditta] as String,
      cd_arclasse1: json[ARClasse1Field.cd_arclasse1] as String,
      descrizione: json[ARClasse1Field.descrizione] as String);

  Map<String, Object?> toJson() => {
        ARClasse1Field.id: id,
        ARClasse1Field.id_ditta: id_ditta,
        ARClasse1Field.cd_arclasse1: cd_arclasse1,
        ARClasse1Field.descrizione: descrizione,
      };

  ARClasse1 copy(
          {int? id,
          String? id_ditta,
          String? cd_arclasse1,
          String? descrizione}) =>
      ARClasse1(
        id: id ?? this.id,
        id_ditta: id_ditta ?? this.id_ditta,
        cd_arclasse1: cd_arclasse1 ?? this.cd_arclasse1,
        descrizione: descrizione ?? this.descrizione,
      );
}
