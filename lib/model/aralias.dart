const String tableNotes = 'aralias';

class ARAliasField {
  static final List<String> values = [id, id_ditta, cd_ar, alias];

  static const String id = 'id';
  static const String id_ditta = 'id_ditta';
  static const String cd_ar = 'cd_ar';
  static const String alias = 'alias';
}

class ARAlias {
  final int? id;
  final String id_ditta;
  final String cd_ar;
  final String alias;

  const ARAlias(
      {this.id,
      required this.id_ditta,
      required this.cd_ar,
      required this.alias});

  static ARAlias fromJson(Map<String, Object?> json) => ARAlias(
      id: json[ARAliasField.id] as int?,
      id_ditta: json[ARAliasField.id_ditta] as String,
      cd_ar: json[ARAliasField.cd_ar] as String,
      alias: json[ARAliasField.alias] as String);

  Map<String, Object?> toJson() => {
        ARAliasField.id: id,
        ARAliasField.id_ditta: id_ditta,
        ARAliasField.cd_ar: cd_ar,
        ARAliasField.alias: alias,
      };

  ARAlias copy({int? id, String? id_ditta, String? cd_ar, String? alias}) =>
      ARAlias(
        id: id ?? this.id,
        id_ditta: id_ditta ?? this.id_ditta,
        cd_ar: cd_ar ?? this.cd_ar,
        alias: alias ?? this.alias,
      );
}
