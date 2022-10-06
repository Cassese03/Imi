const String tableNotes = 'lsrevisione';

class LSRevisioneField {
  static final List<String> values = [
    id,
    cd_ls,
    id_ditta,
    id_lsrevisione,
    descrizione,
  ];
  static const String id = 'id';
  static const String cd_ls = 'cd_ls';
  static const String id_ditta = 'id_ditta';
  static const String id_lsrevisione = 'id_lsrevisione';
  static const String descrizione = 'descrizione';
}

class LSRevisione {
  final int? id;
  final String cd_ls;
  final String id_lsrevisione;
  final String id_ditta;
  final String descrizione;

  const LSRevisione(
      {this.id,
      required this.cd_ls,
      required this.id_lsrevisione,
      required this.id_ditta,
      required this.descrizione});

  static LSRevisione fromJson(Map<String, Object?> json) => LSRevisione(
        cd_ls: json[LSRevisioneField.cd_ls].toString(),
        id_ditta: json[LSRevisioneField.id_ditta].toString(),
        id_lsrevisione: json[LSRevisioneField.id_lsrevisione].toString(),
        descrizione: json[LSRevisioneField.descrizione].toString(),
      );

  Map<String, Object?> toJson() => {
        LSRevisioneField.cd_ls: cd_ls,
        LSRevisioneField.id_ditta: id_ditta,
        LSRevisioneField.descrizione: descrizione,
        LSRevisioneField.id_lsrevisione: id_lsrevisione,
      };

  LSRevisione copy({
    int? id,
    String? cd_ls,
    String? id_ditta,
    String? id_lsrevisione,
    String? descrizione,
  }) =>
      LSRevisione(
        id: id ?? this.id,
        cd_ls: cd_ls ?? this.cd_ls,
        id_lsrevisione: id_lsrevisione ?? this.id_lsrevisione,
        id_ditta: id_ditta ?? this.id_ditta,
        descrizione: descrizione ?? this.descrizione,
      );
}
