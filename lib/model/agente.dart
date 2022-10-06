const String tableNotes = 'agente';

class AgenteField {
  static final List<String> values = [
    id,
    id_ditta,
    cd_agente,
    descrizione,
    provvigione,
    sconto,
    xpassword
  ];

  static const String id = 'id';
  static const String id_ditta = 'id_ditta';
  static const String cd_agente = 'cd_agente';
  static const String descrizione = 'descrizione';
  static const String provvigione = 'provvigione';
  static const String sconto = 'sconto';
  static const String xpassword = 'xpassword';
}

class Agente {
  final int? id;
  final String id_ditta;
  final String cd_agente;
  final String descrizione;
  final double provvigione;
  final double sconto;
  final String xpassword;

  const Agente(
      {this.id,
      required this.id_ditta,
      required this.cd_agente,
      required this.descrizione,
      required this.provvigione,
      required this.sconto,
      required this.xpassword});

  static Agente fromJson(Map<String, Object?> json) => Agente(
      id: json[AgenteField.id] as int?,
      id_ditta: json[AgenteField.id_ditta] as String,
      cd_agente: json[AgenteField.cd_agente] as String,
      descrizione: json[AgenteField.descrizione] as String,
      provvigione: json[AgenteField.provvigione] as double,
      sconto: json[AgenteField.sconto] as double,
      xpassword: json[AgenteField.xpassword] as String);

  Map<String, Object?> toJson() => {
        AgenteField.id: id,
        AgenteField.id_ditta: id_ditta,
        AgenteField.cd_agente: cd_agente,
        AgenteField.descrizione: descrizione,
        AgenteField.provvigione: provvigione,
        AgenteField.sconto: sconto,
        AgenteField.xpassword: xpassword,
      };

  Agente copy({
    int? id,
    String? id_ditta,
    String? cd_agente,
    String? descrizione,
    double? provvigione,
    double? sconto,
    String? xpassword,
  }) =>
      Agente(
        id: id ?? this.id,
        id_ditta: id_ditta ?? this.id_ditta,
        cd_agente: cd_agente ?? this.cd_agente,
        descrizione: descrizione ?? this.descrizione,
        provvigione: provvigione ?? this.provvigione,
        sconto: sconto ?? this.sconto,
        xpassword: xpassword ?? this.xpassword,
      );
}
