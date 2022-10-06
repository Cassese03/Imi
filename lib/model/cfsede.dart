const String tableNotes = 'cf';

class CFSedeField {
  static final List<String> values = [
    id,
    cd_cf,
    cd_cfsede,
    id_ditta,
    descrizione,
    indirizzo,
    localita,
    cap,
    cd_nazione,
    cd_provincia,
  ];

  static const String id = 'id';
  static const String cd_cf = 'cd_cf';
  static const String cd_cfsede = 'cd_cfsede';
  static const String id_ditta = 'id_ditta';
  static const String descrizione = 'descrizione';
  static const String indirizzo = 'indirizzo';
  static const String localita = 'localita';
  static const String cap = 'cap';
  static const String cd_nazione = 'cd_nazione';
  static const String cd_provincia = 'cd_provincia';
}

class CFSede {
  final int? id;
  final String cd_cf;
  final String cd_cfsede;
  final String id_ditta;
  final String descrizione;
  final String indirizzo;
  final String localita;
  final String cap;
  final String cd_nazione;
  final String cd_provincia;

  const CFSede(
      {this.id,
      required this.cd_cf,
      required this.cd_cfsede,
      required this.id_ditta,
      required this.descrizione,
      required this.indirizzo,
      required this.localita,
      required this.cap,
      required this.cd_nazione,
      required this.cd_provincia});

  static CFSede fromJson(Map<String, Object?> json) => CFSede(
        cd_cf: json[CFSedeField.cd_cf] as String,
        cd_cfsede: json[CFSedeField.cd_cf] as String,
        id_ditta: json[CFSedeField.id_ditta] as String,
        descrizione: json[CFSedeField.descrizione] as String,
        indirizzo: json[CFSedeField.indirizzo] as String,
        localita: json[CFSedeField.localita] as String,
        cap: json[CFSedeField.cap] as String,
        cd_nazione: json[CFSedeField.cd_nazione] as String,
        cd_provincia: json[CFSedeField.cd_provincia] as String,
      );

  Map<String, Object?> toJson() => {
        CFSedeField.cd_cf: cd_cf,
        CFSedeField.cd_cfsede: cd_cfsede,
        CFSedeField.id_ditta: id_ditta,
        CFSedeField.descrizione: descrizione,
        CFSedeField.indirizzo: indirizzo,
        CFSedeField.cd_provincia: cd_provincia,
        CFSedeField.localita: localita,
        CFSedeField.cap: cap,
        CFSedeField.cd_nazione: cd_nazione,
      };

  CFSede copy({
    int? id,
    String? cd_cf,
    String? cd_cfsede,
    String? id_ditta,
    String? descrizione,
    String? indirizzo,
    String? localita,
    String? cap,
    String? cd_nazione,
    String? cd_provincia,
  }) =>
      CFSede(
        id: id ?? this.id,
        cd_cf: cd_cf ?? this.cd_cf,
        cd_cfsede: cd_cfsede ?? this.cd_cfsede,
        id_ditta: id_ditta ?? this.id_ditta,
        descrizione: descrizione ?? this.descrizione,
        indirizzo: indirizzo ?? this.indirizzo,
        localita: localita ?? this.localita,
        cap: cap ?? this.cap,
        cd_nazione: cd_nazione ?? this.cd_nazione,
        cd_provincia: cd_provincia ?? this.cd_provincia,
      );
}
