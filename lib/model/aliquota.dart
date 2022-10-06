const String tableNotes = 'aliquota';

class AliquotaField {
  static final List<String> values = [id, id_ditta, cd_aliquota, aliquota];

  static const String id = 'id';
  static const String id_ditta = 'id_ditta';
  static const String cd_aliquota = 'cd_aliquota';
  static const String aliquota = 'aliquota';
}

class Aliquota {
  final int? id;
  final String id_ditta;
  final String cd_aliquota;
  final String aliquota;

  const Aliquota(
      {this.id,
      required this.id_ditta,
      required this.cd_aliquota,
      required this.aliquota});

  static Aliquota fromJson(Map<String, Object?> json) => Aliquota(
      id: json[AliquotaField.id] as int?,
      id_ditta: json[AliquotaField.id_ditta] as String,
      cd_aliquota: json[AliquotaField.cd_aliquota] as String,
      aliquota: json[AliquotaField.aliquota] as String);

  Map<String, Object?> toJson() => {
        AliquotaField.id: id,
        AliquotaField.id_ditta: id_ditta,
        AliquotaField.cd_aliquota: cd_aliquota,
        AliquotaField.aliquota: aliquota,
      };

  Aliquota copy(
          {int? id, String? id_ditta, String? cd_aliquota, String? aliquota}) =>
      Aliquota(
        id: id ?? this.id,
        id_ditta: id_ditta ?? this.id_ditta,
        cd_aliquota: cd_aliquota ?? this.cd_aliquota,
        aliquota: aliquota ?? this.aliquota,
      );
}
