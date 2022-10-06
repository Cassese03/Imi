const String tableNotes = 'ararmisura';

class ARARMisuraField {
  static final List<String> values = [id, id_ditta, cd_ar, cd_armisura, umfatt];

  static const String id = 'id';
  static const String id_ditta = 'id_ditta';
  static const String cd_ar = 'cd_ar';
  static const String cd_armisura = 'cd_armisura';
  static const String umfatt = 'umfatt';
}

class ARARMisura {
  final int? id;
  final String id_ditta;
  final String cd_ar;
  final String cd_armisura;
  final String umfatt;

  const ARARMisura(
      {this.id,
      required this.id_ditta,
      required this.cd_ar,
      required this.cd_armisura,
      required this.umfatt});

  static ARARMisura fromJson(Map<String, Object?> json) => ARARMisura(
      id: json[ARARMisuraField.id] as int?,
      id_ditta: json[ARARMisuraField.id_ditta] as String,
      cd_ar: json[ARARMisuraField.cd_ar] as String,
      cd_armisura: json[ARARMisuraField.cd_armisura] as String,
      umfatt: json[ARARMisuraField.umfatt] as String);

  Map<String, Object?> toJson() => {
        ARARMisuraField.id: id,
        ARARMisuraField.id_ditta: id_ditta,
        ARARMisuraField.cd_ar: cd_ar,
        ARARMisuraField.cd_armisura: cd_armisura,
        ARARMisuraField.umfatt: umfatt
      };

  ARARMisura copy(
          {int? id,
          String? id_ditta,
          String? cd_ar,
          String? cd_armisura,
          String? umfatt}) =>
      ARARMisura(
        id: id ?? this.id,
        id_ditta: id_ditta ?? this.id_ditta,
        cd_ar: cd_ar ?? this.cd_ar,
        cd_armisura: cd_armisura ?? this.cd_armisura,
        umfatt: umfatt ?? this.umfatt,
      );
}
