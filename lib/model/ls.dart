const String tableNotes = 'ls';

class LSField {
  static final List<String> values = [
    id,
    cd_ls,
    id_ditta,
    descrizione,
  ];
  static const String id = 'id';
  static const String cd_ls = 'cd_ls';
  static const String id_ditta = 'id_ditta';
  static const String descrizione = 'descrizione';
}

class LS {
  final int? id;
  final String cd_ls;
  final String id_ditta;
  final String descrizione;

  const LS(
      {this.id,
      required this.cd_ls,
      required this.id_ditta,
      required this.descrizione});

  static LS fromJson(Map<String, Object?> json) => LS(
        cd_ls: json[LSField.cd_ls].toString(),
        id_ditta: json[LSField.id_ditta].toString(),
        descrizione: json[LSField.descrizione].toString(),
      );

  Map<String, Object?> toJson() => {
        LSField.cd_ls: cd_ls,
        LSField.id_ditta: id_ditta,
        LSField.descrizione: descrizione,
      };

  LS copy({
    int? id,
    String? cd_ls,
    String? id_ditta,
    String? descrizione,
  }) =>
      LS(
        id: id ?? this.id,
        cd_ls: cd_ls ?? this.cd_ls,
        id_ditta: id_ditta ?? this.id_ditta,
        descrizione: descrizione ?? this.descrizione,
      );
}
