import 'dart:convert';

const String tableNotes = 'ar';

class ARField {
  static final List<String> values = [
    id,
    id_ditta,
    cd_AR,
    descrizione,
    cd_aliquota_v,
    cd_arclasse1,
    cd_arclasse2,
    cd_arclasse3,
    cd_argruppo1,
    cd_argruppo2,
    cd_argruppo3,
    immagine,
    xcd_xcalibro,
    xcd_xvarieta,
    disponibile,
    id_ar,
    dms,
  ];

  static const String id = 'id';
  static const String id_ditta = 'id_ditta';
  static const String cd_AR = 'cd_AR';
  static const String descrizione = 'descrizione';
  static const String cd_aliquota_v = 'cd_aliquota_v';
  static const String cd_arclasse1 = 'cd_arclasse1';
  static const String cd_arclasse2 = 'cd_arclasse2';
  static const String cd_arclasse3 = 'cd_arclasse3';
  static const String cd_argruppo1 = 'cd_argruppo1';
  static const String cd_argruppo2 = 'cd_argruppo2';
  static const String cd_argruppo3 = 'cd_argruppo3';
  static const String immagine = 'immagine';
  static const String xcd_xcalibro = 'xcd_xcalibro';
  static const String xcd_xvarieta = 'xcd_xvarieta';
  static const String disponibile = 'disponibile';
  static const String id_ar = 'id_ar';
  static const String dms = 'dms';
}

class AR {
  final int? id;
  final String id_ditta;
  final String cd_AR;
  final String descrizione;
  final String cd_aliquota_v;
  final String cd_arclasse1;
  final String cd_arclasse2;
  final String cd_arclasse3;
  final String cd_argruppo1;
  final String cd_argruppo2;
  final String cd_argruppo3;
  final String immagine;
  final String xcd_xcalibro;
  final String xcd_xvarieta;
  final String disponibile;
  final String id_ar;
  final String dms;

  const AR(
      {this.id,
      required this.id_ditta,
      required this.cd_AR,
      required this.descrizione,
      required this.cd_aliquota_v,
      required this.cd_arclasse1,
      required this.cd_arclasse2,
      required this.cd_arclasse3,
      required this.cd_argruppo1,
      required this.cd_argruppo2,
      required this.cd_argruppo3,
      required this.immagine,
      required this.xcd_xcalibro,
      required this.xcd_xvarieta,
      required this.disponibile,
      required this.id_ar,
      required this.dms});

  static AR fromJson(Map<String, Object?> json) => AR(
      id: json[ARField.id] as int?,
      id_ditta: json[ARField.id_ditta].toString() as String,
      cd_AR: json[ARField.cd_AR].toString() as String,
      descrizione: json[ARField.descrizione].toString() as String,
      cd_aliquota_v: json[ARField.cd_aliquota_v].toString() as String,
      cd_arclasse1: json[ARField.cd_arclasse1].toString() as String,
      cd_arclasse2: json[ARField.cd_arclasse2].toString() as String,
      cd_arclasse3: json[ARField.cd_arclasse3].toString() as String,
      cd_argruppo1: json[ARField.cd_argruppo1].toString() as String,
      cd_argruppo2: json[ARField.cd_argruppo2].toString() as String,
      cd_argruppo3: json[ARField.cd_argruppo3].toString() as String,
      immagine: json[ARField.immagine].toString() as String,
      xcd_xcalibro: json[ARField.xcd_xcalibro].toString() as String,
      xcd_xvarieta: json[ARField.xcd_xvarieta].toString() as String,
      disponibile: json[ARField.disponibile].toString() as String,
      id_ar: json[ARField.id_ar].toString() as String,
      dms: json[ARField.dms].toString() as String);

  Map<String, Object?> toJson() => {
        ARField.id: id,
        ARField.id_ditta: id_ditta,
        ARField.cd_AR: cd_AR,
        ARField.descrizione: descrizione,
        ARField.cd_aliquota_v: cd_aliquota_v,
        ARField.cd_arclasse1: cd_arclasse1,
        ARField.cd_arclasse2: cd_arclasse2,
        ARField.cd_arclasse3: cd_arclasse3,
        ARField.cd_argruppo1: cd_argruppo1,
        ARField.cd_argruppo2: cd_argruppo2,
        ARField.cd_argruppo3: cd_argruppo3,
        ARField.immagine: immagine,
        ARField.xcd_xcalibro: xcd_xcalibro,
        ARField.xcd_xvarieta: xcd_xvarieta,
        ARField.disponibile: disponibile,
        ARField.id_ar: id_ar,
        ARField.dms: dms,
      };

  AR copy(
          {int? id,
          String? id_ditta,
          String? cd_AR,
          String? descrizione,
          String? cd_aliquota_v,
          String? cd_arclasse1,
          String? cd_arclasse2,
          String? cd_arclasse3,
          String? cd_argruppo1,
          String? cd_argruppo2,
          String? cd_argruppo3,
          String? immagine,
          String? xcd_xcalibro,
          String? xcd_xvarieta,
          String? disponibile,
          String? id_ar,
          String? dms}) =>
      AR(
        id: id ?? this.id,
        id_ditta: id_ditta ?? this.id_ditta,
        cd_AR: cd_AR ?? this.cd_AR,
        descrizione: descrizione ?? this.descrizione,
        cd_aliquota_v: cd_aliquota_v ?? this.cd_aliquota_v,
        cd_arclasse1: cd_arclasse1 ?? this.cd_arclasse1,
        cd_arclasse2: cd_arclasse2 ?? this.cd_arclasse2,
        cd_arclasse3: cd_arclasse3 ?? this.cd_arclasse3,
        cd_argruppo1: cd_argruppo1 ?? this.cd_argruppo1,
        cd_argruppo2: cd_argruppo2 ?? this.cd_argruppo2,
        cd_argruppo3: cd_argruppo3 ?? this.cd_argruppo3,
        immagine: immagine ?? this.immagine,
        xcd_xcalibro: xcd_xcalibro ?? this.xcd_xcalibro,
        xcd_xvarieta: xcd_xvarieta ?? this.xcd_xvarieta,
        disponibile: disponibile ?? this.disponibile,
        id_ar: id_ar ?? this.id_ar,
        dms: dms ?? this.dms,
      );
}
