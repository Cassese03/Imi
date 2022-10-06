const String tableNotes = 'dotes';

class DOTes_ProvField {
  static final List<String> values = [
    id,
    id_ditta,
    id_dotes,
    xcd_xveicolo,
    xautista,
    ximb,
    xacconto,
    xsettimana,
    xtipoveicolo,
    xmodifica,
    xurgente,
    xpagata,
    xriford,
    xriffatra,
    ximpfat,
    ximppag,
    xpagatat,
    xclidest
  ];

  static const String xcd_xveicolo = 'xcd_xveicolo';
  static const String id = 'id';
  static const String id_dotes = 'id_dotes';
  static const String id_ditta = 'id_ditta';
  static const String xriffatra = 'xriffatra';
  static const String ximppag = 'ximppag';
  static const String xautista = 'xautista';
  static const String ximpfat = 'ximpfat';
  static const String ximb = 'ximb';
  static const String xsettimana = 'xsettimana';
  static const String xacconto = 'xacconto';
  static const String xtipoveicolo = 'xtipoveicolo';
  static const String xmodifica = 'xmodifica';
  static const String xurgente = 'xurgente';
  static const String xpagata = 'xpagata';
  static const String xriford = 'xriford';
  static const String xpagatat = 'xpagatat';
  static const String xclidest = 'xclidest';
}

class DOTes_Prov {
  final int? id;
  final String id_ditta;
  final String id_dotes;
  final String xriffatra;
  final String xcd_xveicolo;
  final String ximppag;
  final String xautista;
  final String ximpfat;
  final String xsettimana;
  final String ximb;
  final String xacconto;
  final String xtipoveicolo;
  final String xmodifica;
  final String xurgente;
  final String xpagata;
  final String xriford;
  final String xpagatat;
  final String xclidest;

  const DOTes_Prov(
      {this.id,
      required this.id_ditta,
      required this.id_dotes,
      required this.xriffatra,
      required this.xcd_xveicolo,
      required this.ximppag,
      required this.xautista,
      required this.ximpfat,
      required this.xsettimana,
      required this.ximb,
      required this.xacconto,
      required this.xtipoveicolo,
      required this.xmodifica,
      required this.xurgente,
      required this.xpagata,
      required this.xriford,
      required this.xpagatat,
      required this.xclidest});

  static DOTes_Prov fromJson(Map<String, Object?> json) => DOTes_Prov(
        id_ditta: json[DOTes_ProvField.id_ditta].toString(),
        id_dotes: json[DOTes_ProvField.id_dotes].toString(),
        xriffatra: json[DOTes_ProvField.xriffatra].toString(),
        xcd_xveicolo: json[DOTes_ProvField.xcd_xveicolo].toString(),
        ximppag: json[DOTes_ProvField.ximppag].toString(),
        xautista: json[DOTes_ProvField.xautista].toString(),
        ximpfat: json[DOTes_ProvField.ximpfat].toString(),
        xsettimana: json[DOTes_ProvField.xsettimana].toString(),
        ximb: json[DOTes_ProvField.ximb].toString(),
        xacconto: json[DOTes_ProvField.xacconto].toString(),
        xtipoveicolo: json[DOTes_ProvField.xtipoveicolo].toString(),
        xmodifica: json[DOTes_ProvField.xmodifica].toString(),
        xurgente: json[DOTes_ProvField.xurgente].toString(),
        xpagata: json[DOTes_ProvField.xpagata].toString(),
        xriford: json[DOTes_ProvField.xriford].toString(),
        xpagatat: json[DOTes_ProvField.xpagatat].toString(),
        xclidest: json[DOTes_ProvField.xclidest].toString(),
      );

  Map<String, Object?> toJson() => {
        DOTes_ProvField.id_ditta: id_ditta,
        DOTes_ProvField.id_dotes: id_dotes,
        DOTes_ProvField.xriffatra: xriffatra,
        DOTes_ProvField.xcd_xveicolo: xcd_xveicolo,
        DOTes_ProvField.ximppag: ximppag,
        DOTes_ProvField.xautista: xautista,
        DOTes_ProvField.ximpfat: ximpfat,
        DOTes_ProvField.xsettimana: xsettimana,
        DOTes_ProvField.ximb: ximb,
        DOTes_ProvField.xacconto: xacconto,
        DOTes_ProvField.xtipoveicolo: xtipoveicolo,
        DOTes_ProvField.xmodifica: xmodifica,
        DOTes_ProvField.xurgente: xurgente,
        DOTes_ProvField.xpagata: xpagata,
        DOTes_ProvField.xpagatat: xpagatat,
        DOTes_ProvField.xriford: xriford,
        DOTes_ProvField.xclidest: xclidest,
      };

  DOTes_Prov copy({
    int? id,
    String? id_ditta,
    String? id_dotes,
    String? xriffatra,
    String? xcd_xveicolo,
    String? ximppag,
    String? xautista,
    String? ximpfat,
    String? xsettimana,
    String? ximb,
    String? xacconto,
    String? xtipoveicolo,
    String? xmodifica,
    String? xurgente,
    String? xpagata,
    String? xpagatat,
    String? xriford,
    String? xclidest,
  }) =>
      DOTes_Prov(
        id: id ?? this.id,
        id_ditta: id_ditta ?? this.id_ditta,
        id_dotes: id_dotes ?? this.id_dotes,
        xriffatra: xriffatra ?? this.xriffatra,
        xautista: xautista ?? this.xautista,
        ximpfat: ximpfat ?? this.ximpfat,
        xsettimana: xsettimana ?? this.xsettimana,
        ximb: ximb ?? this.ximb,
        xacconto: xacconto ?? this.xacconto,
        xtipoveicolo: xtipoveicolo ?? this.xtipoveicolo,
        xmodifica: xmodifica ?? this.xmodifica,
        xurgente: xurgente ?? this.xurgente,
        xpagata: xpagata ?? this.xpagata,
        xpagatat: xpagatat ?? this.xpagatat,
        xriford: xriford ?? this.xriford,
        xclidest: xclidest ?? this.xclidest,
        xcd_xveicolo: xcd_xveicolo ?? this.xcd_xveicolo,
        ximppag: ximppag ?? this.ximppag,
      );
}
