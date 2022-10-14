import 'package:imi/page/dettaglio.dart';

const String tableNotes = 'sc';

class SCField {
  static final List<String> values = [
    id,
    id_ditta,
    cd_cf,
    datascadenza,
    importoe,
    numfattura,
    datafattura,
    datapagamento,
    pagata,
    insoluta,
  ];
  static const String id = 'id';
  static const String id_ditta = 'id_ditta';
  static const String cd_cf = 'cd_cf';
  static const String datascadenza = 'datascadenza';
  static const String importoe = 'importoe';
  static const String numfattura = 'numfattura';
  static const String datafattura = 'datafattura';
  static const String datapagamento = 'datapagamento';
  static const String pagata = 'pagata';
  static const String insoluta = 'insoluta';
}

class SC {
  final int? id;
  final String id_ditta;
  final String cd_cf;
  final String datascadenza;
  final String importoe;
  final String numfattura;
  final String datafattura;
  final String? datapagamento;
  final String pagata;
  final String insoluta;

  const SC(
      {this.id,
        required this.id_ditta,
        required this.cd_cf,
        required this.datascadenza,
        required this.importoe,
        required this.numfattura,
        required this.datafattura,
        required this.datapagamento,
        required this.pagata,
        required this.insoluta});

  static SC fromJson(Map<String, Object?> json) => SC(
    cd_cf: json[SCField.cd_cf].toString(),
    datascadenza: json[SCField.datascadenza].toString(),
    importoe: json[SCField.importoe].toString(),
    id_ditta: json[SCField.id_ditta].toString().toString(),
    numfattura: json[SCField.numfattura].toString(),
    datafattura: json[SCField.datafattura].toString(),
    datapagamento: json[SCField.datapagamento].toString(),
    pagata: json[SCField.pagata].toString(),
    insoluta: json[SCField.insoluta].toString(),
  );

  Map<String, Object?> toJson() => {
    SCField.cd_cf: cd_cf,
    SCField.id_ditta: id_ditta,
    SCField.datascadenza: datascadenza,
    SCField.importoe: importoe,
    SCField.numfattura: numfattura,
    SCField.datafattura: datafattura,
    SCField.datapagamento: datapagamento,
    SCField.pagata: pagata,
    SCField.insoluta: insoluta,
  };

  SC copy({
    int? id,
    String? id_ditta,
    String? cd_cf,
    String? datascadenza,
    String? importoe,
    String? numfattura,
    String? datafattura,
    String? datapagamento,
    String? pagata,
    String? insoluta,
  }) =>
      SC(
        id: id ?? this.id,
        cd_cf: cd_cf ?? this.cd_cf,
        datascadenza: datascadenza ?? this.datascadenza,
        id_ditta: id_ditta ?? this.id_ditta,
        importoe: importoe ?? this.importoe,
        numfattura: numfattura ?? this.numfattura,
        datafattura: datafattura ?? this.datafattura,
        datapagamento: datapagamento ?? this.datapagamento,
        pagata: pagata ?? this.pagata,
        insoluta: insoluta ?? this.insoluta,
      );
}
