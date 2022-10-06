const String tableNotes = 'dorig';

class DORigField {
  static final List<String> values = [
    id,
    id_dotes,
    id_dorig,
    id_ditta,
    cd_cf,
    cd_ar,
    qta,
    descrizione,
    prezzounitariov,
    cd_aliquota,
    scontoriga,
    prezzounitarioscontatov,
    prezzototalev,
  ];

  static const String id = 'id';
  static const String id_dotes = 'id_dotes';
  static const String id_dorig = 'id_dorig';
  static const String id_ditta = 'id_ditta';
  static const String cd_cf = 'cd_cf';
  static const String cd_ar = 'cd_ar';
  static const String qta = 'qta';
  static const String descrizione = 'descrizione';
  static const String prezzounitariov = 'prezzounitariov';
  static const String cd_aliquota = 'cd_aliquota';
  static const String scontoriga = 'scontoriga';
  static const String prezzounitarioscontatov = 'prezzounitarioscontatov';
  static const String prezzototalev = 'prezzototalev';
}

class DORig {
  final int? id;
  final String id_dotes;
  final String id_dorig;
  final String id_ditta;
  final String cd_cf;
  final String cd_ar;
  final String qta;
  final String descrizione;
  final String prezzounitariov;
  final String cd_aliquota;
  final String scontoriga;
  final String prezzounitarioscontatov;
  final String prezzototalev;

  const DORig({
    this.id,
    required this.id_dotes,
    required this.id_dorig,
    required this.id_ditta,
    required this.cd_cf,
    required this.cd_ar,
    required this.qta,
    required this.descrizione,
    required this.prezzounitariov,
    required this.cd_aliquota,
    required this.scontoriga,
    required this.prezzounitarioscontatov,
    required this.prezzototalev,
  });

  static DORig fromJson(Map<String, Object?> json) => DORig(
        cd_cf: json[DORigField.cd_cf].toString(),
        id_ditta: json[DORigField.id_ditta].toString(),
        descrizione: json[DORigField.descrizione].toString(),
        id_dotes: json[DORigField.id_dotes].toString(),
        id_dorig: json[DORigField.id_dorig].toString(),
        qta: json[DORigField.qta].toString(),
        prezzounitariov: json[DORigField.prezzounitariov].toString(),
        cd_aliquota: json[DORigField.cd_aliquota].toString(),
        scontoriga: json[DORigField.scontoriga].toString(),
        prezzounitarioscontatov:
            json[DORigField.prezzounitarioscontatov].toString(),
        prezzototalev: json[DORigField.prezzototalev].toString(),
        cd_ar: json[DORigField.cd_ar].toString(),
      );

  Map<String, Object?> toJson() => {
        DORigField.cd_cf: cd_cf,
        DORigField.id_ditta: id_ditta,
        DORigField.descrizione: descrizione,
        DORigField.cd_ar: cd_ar,
        DORigField.prezzototalev: prezzototalev,
        DORigField.prezzounitarioscontatov: prezzounitarioscontatov,
        DORigField.scontoriga: scontoriga,
        DORigField.cd_aliquota: cd_aliquota,
        DORigField.prezzounitariov: prezzounitariov,
        DORigField.qta: qta,
        DORigField.id_dotes: id_dotes,
        DORigField.id_dorig: id_dorig,
      };

  DORig copy({
    int? id,
    String? id_dotes,
    String? id_dorig,
    String? id_ditta,
    String? cd_cf,
    String? cd_ar,
    String? qta,
    String? descrizione,
    String? prezzounitariov,
    String? cd_aliquota,
    String? scontoriga,
    String? prezzounitarioscontatov,
    String? prezzototalev,
  }) =>
      DORig(
        id: id ?? this.id,
        cd_cf: cd_cf ?? this.cd_cf,
        id_ditta: id_ditta ?? this.id_ditta,
        id_dotes: id_dotes ?? this.id_dotes,
        id_dorig: id_dorig ?? this.id_dorig,
        descrizione: descrizione ?? this.descrizione,
        prezzototalev: prezzototalev ?? this.prezzototalev,
        prezzounitarioscontatov:
            prezzounitarioscontatov ?? this.prezzounitarioscontatov,
        scontoriga: scontoriga ?? this.scontoriga,
        cd_aliquota: cd_aliquota ?? this.cd_aliquota,
        prezzounitariov: prezzounitariov ?? this.prezzounitariov,
        qta: qta ?? this.qta,
        cd_ar: cd_ar ?? this.cd_ar,
      );
}
