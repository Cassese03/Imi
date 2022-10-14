import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:imi/model/sc.dart';
import 'package:imi/page/login.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:imi/db/databases.dart';
import 'package:imi/model/argruppo1.dart';
import 'package:imi/model/cf.dart';
import 'package:imi/model/dorig.dart';
import 'package:imi/model/dotes.dart';
import 'package:imi/model/dotes_prov.dart';
import 'package:imi/model/dototali.dart';
import 'package:imi/model/ls.dart';
import 'package:imi/model/lsarticolo.dart';
import 'package:imi/model/lsrevisione.dart';
import 'package:imi/model/lsscaglione.dart';
import 'package:imi/model/mggiac.dart';
import 'package:imi/model/agente.dart';
import 'package:imi/model/imi.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:imi/page/agente.dart';
import 'package:imi/page/ar.dart';
import 'package:imi/page/table.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/ar.dart';
import 'dart:math' as math;
import '../db/databases.dart';
import 'package:loading_animations/loading_animations.dart';

import 'cart.dart';
import 'cliente.dart';
import 'dettaglio.dart';
import 'documenti.dart';
import 'ordini.dart';

class AggiornaPage extends StatefulWidget {
  const AggiornaPage({required this.agente});
  final String? agente;
  @override
  _AggiornaPageState createState() => _AggiornaPageState();
}

class _AggiornaPageState extends State<AggiornaPage> {
  late List cf;
  bool isLoading = false;
  bool isDownloading = false;
  bool isSending = false;
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    aggiornaDati();
  }

  // ignore: non_constant_identifier_names
  Future<List<AR>> get_ar(String last_ar) async {
    print('https://bohagent.cloud/api/b2b/get_imi/ar/IMI1234/$last_ar');
    var url = 'https://bohagent.cloud/api/b2b/get_imi/ar/IMI1234/$last_ar';

    var response = await http.get(Uri.parse(url));

    var notes = <AR>[];

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        notes.add(AR.fromJson(noteJson));
      }
    }
    return notes;
  }


  Future<List<SC>> get_sc() async {
    var url = 'https://bohagent.cloud/api/b2b/get_provvisiero/sc/IMI1234';

    var response = await http.get(Uri.parse(url));

    var notes = <SC>[];

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        notes.add(SC.fromJson(noteJson));
      }
    }
    return notes;
  }

  Future<List<CF>> get_cf() async {
    var url = 'https://bohagent.cloud/api/b2b/get_imi/cf/IMI1234';

    var response = await http.get(Uri.parse(url));

    var notes = <CF>[];

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        notes.add(CF.fromJson(noteJson));
      }
    }
    return notes;
  }

  Future<List<MGGiac>> get_mggiac() async {
    var url = 'https://bohagent.cloud/api/b2b/get_imi/mggiacenza/IMI1234';

    var response = await http.get(Uri.parse(url));

    var notes = <MGGiac>[];

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        notes.add(MGGiac.fromJson(noteJson));
      }
    }
    return notes;
  }

  Future<List<LS>> get_ls() async {
    var url = 'https://bohagent.cloud/api/b2b/get_imi/ls/IMI1234';

    var response = await http.get(Uri.parse(url));

    var notes = <LS>[];

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        notes.add(LS.fromJson(noteJson));
      }
    }

    return notes;
  }

  Future<List<LSArticolo>> get_lsarticolo() async {
    var url = 'https://bohagent.cloud/api/b2b/get_imi/lsarticolo/IMI1234';

    var response = await http.get(Uri.parse(url));

    var notes = <LSArticolo>[];

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        notes.add(LSArticolo.fromJson(noteJson));
      }
    }

    return notes;
  }

  Future<List<LSRevisione>> get_lsrevisione() async {
    var url = 'https://bohagent.cloud/api/b2b/get_imi/lsrevisione/IMI1234';

    var response = await http.get(Uri.parse(url));

    var notes = <LSRevisione>[];

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        notes.add(LSRevisione.fromJson(noteJson));
      }
    }

    return notes;
  }

  Future<List<LSScaglione>> get_lsscaglione() async {
    var url = 'https://bohagent.cloud/api/b2b/get_imi/lsscaglione/IMI1234';

    var response = await http.get(Uri.parse(url));

    var notes = <LSScaglione>[];

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        notes.add(LSScaglione.fromJson(noteJson));
      }
    }

    return notes;
  }

  Future<List<DOTes>> get_dotes(String last_dotes) async {
    print('https://bohagent.cloud/api/b2b/get_imi/dotes/IMI1234/$last_dotes');
    var url =
        'https://bohagent.cloud/api/b2b/get_imi/dotes/IMI1234/$last_dotes';

    var response = await http.get(Uri.parse(url));

    var notes = <DOTes>[];

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        notes.add(DOTes.fromJson(noteJson));
      }
    }

    return notes;
  }

  Future<List<DOTes_Prov>> get_dotes_prov(String last_dotes_prov) async {
    print(
        'https://bohagent.cloud/api/b2b/get_imi/dotes_imi/IMI1234/$last_dotes_prov');
    var url =
        'https://bohagent.cloud/api/b2b/get_imi/dotes_imi/IMI1234/$last_dotes_prov';

    var response = await http.get(Uri.parse(url));

    var notes = <DOTes_Prov>[];

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        notes.add(DOTes_Prov.fromJson(noteJson));
      }
    }

    return notes;
  }

  Future<List<DORig>> get_dorig(String last_dorig) async {
    print('https://bohagent.cloud/api/b2b/get_imi/dorig/IMI1234/$last_dorig');
    var url =
        'https://bohagent.cloud/api/b2b/get_imi/dorig/IMI1234/$last_dorig';

    var response = await http.get(Uri.parse(url));

    var notes = <DORig>[];

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        notes.add(DORig.fromJson(noteJson));
      }
    }

    return notes;
  }


  Future<List<Agente>> get_agente(String last_agente) async {
    print('https://bohagent.cloud/api/b2b/get_imi/agente/IMI1234/$last_agente');
    var url =
        'https://bohagent.cloud/api/b2b/get_imi/agente/IMI1234/$last_agente';

    var response = await http.get(Uri.parse(url));

    var notes = <Agente>[];

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        notes.add(Agente.fromJson(noteJson));
      }
    }
    return notes;
  }

  Future<List<DOTotali>> get_dototali(String last_dotes) async {
    print(
        'https://bohagent.cloud/api/b2b/get_imi/dototali/IMI1234/$last_dotes');
    var url =
        'https://bohagent.cloud/api/b2b/get_imi/dototali/IMI1234/$last_dotes';

    var response = await http.get(Uri.parse(url));

    var notes = <DOTotali>[];

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        notes.add(DOTotali.fromJson(noteJson));
      }
    }

    return notes;
  }

  Future aggiornaDati() async {
    setState(() => isDownloading = true);

    bool internet = await InternetConnectionChecker().hasConnection;
    if (internet) {
      setState(() {
        isDownloading = true;
      });

      print('Start');
      var d1b = await ProvDatabase.instance.database;

      String last_agente1 = '';
      List last_agente = await d1b.rawQuery(
          'SELECT Max(id) as last_agente from agente ');
      if (last_agente[0]["last_agente"] == null)
        last_agente1 = '1';
      else
        last_agente1 =
            last_agente[0]["last_ar"].toString();

      await get_agente(last_agente1).then((value) async {
        //await ProvDatabase.instance.deleteallAgente();

        for (int i = 0; i < value.length; i++) {
          await ProvDatabase.instance.addAgente(
              '8'.toString(),
              value[i].cd_agente.toString(),
              value[i].descrizione.toString(),
              value[i].provvigione.toString(),
              value[i].sconto.toString(),
              value[i].xpassword.toString());
          print('Agente Inserito correttamente $i');
        }
      });

      List last_ar = await d1b.rawQuery(
          'SELECT Max(id_ar) as last_ar from ar where ');

      String last_ar_1 = '0';

      if (last_ar[0]["last_ar"] == null)
        last_ar_1 = '0';
      else
        last_ar_1 = last_ar[0]["last_ar"];


      await get_ar(last_ar_1).then((value) async {
        for (int i = 0; i < value.length; i++) {
          await ProvDatabase.instance.addAR(
              value[i].cd_AR,
              value[i].descrizione,
              value[i].cd_aliquota_v,
              value[i].cd_arclasse1,
              value[i].cd_arclasse2,
              value[i].cd_arclasse3,
              value[i].cd_argruppo1,
              value[i].cd_argruppo2,
              value[i].cd_argruppo3,
              value[i].immagine,
              value[i].xcd_xvarieta,
              value[i].xcd_xcalibro,
              value[i].disponibile,
              value[i].id_ar,
              value[i].dms);
          print('AR Inserito correttamente $i');
        }
      });

      await get_cf().then((value) async {
        await ProvDatabase.instance.deleteallCF();

        for (int i = 0; i < value.length; i++) {
          await ProvDatabase.instance.addCF(
              value[i].cd_cf,
              '7',
              value[i].descrizione.toString(),
              value[i].indirizzo,
              value[i].localita,
              value[i].cap,
              value[i].cd_nazione,
              value[i].cliente,
              value[i].fornitore,
              value[i].cd_provincia,
              value[i].cd_agente_1.toString(),
              value[i].cd_agente_2.toString(),
              value[i].mail.toString());
          print('CF Inserito correttamente $i');
        }
      });

      await get_mggiac().then((value) async {
        await ProvDatabase.instance.deleteallMGGIAC();

        for (int i = 0; i < value.length; i++) {
          await ProvDatabase.instance.addMGGIAC("8", value[i].cd_ar,
              value[i].disponibile, value[i].giacenza, value[i].cd_mg);
          print('Giacenza Inserita correttamente $i');
        }
      });

      await get_ls().then((value) async {
        await ProvDatabase.instance.deleteallLS();

        for (int i = 0; i < value.length; i++) {
          await ProvDatabase.instance.addLS(
              "8", value[i].cd_ls.toString(), value[i].descrizione.toString());
          print('LS Inserito correttamente $i');
        }
      });

      await get_lsarticolo().then((value) async {
        await ProvDatabase.instance.deleteallLSArticolo();

        for (int i = 0; i < value.length; i++) {
          await ProvDatabase.instance.addLSArticolo(
              "8",
              value[i].id_lsrevisione.toString(),
              value[i].cd_ar.toString(),
              value[i].prezzo.toString(),
              value[i].sconto.toString(),
              value[i].provvigione.toString());
          print('LSArticolo Inserito correttamente $i');
        }
      });

      await get_lsrevisione().then((value) async {
        await ProvDatabase.instance.deleteallLSRevisione();

        for (int i = 0; i < value.length; i++) {
          await ProvDatabase.instance.addLSRevisione(
              "8",
              value[i].id_lsrevisione.toString(),
              value[i].cd_ls.toString(),
              value[i].descrizione.toString());
          print('LSRevisione Inserito correttamente $i');
        }
      });

      await get_sc().then((value) async {
        await ProvDatabase.instance.deleteallSC();

        for (int i = 0; i < value.length; i++) {
          await ProvDatabase.instance.addSC(
            "8",
            value[i].cd_cf.toString(),
            value[i].datascadenza.toString(),
            value[i].importoe.toString(),
            value[i].numfattura.toString(),
            value[i].datafattura.toString(),
            value[i].datapagamento.toString(),
            value[i].pagata.toString(),
            value[i].insoluta.toString(),
          );
          print('Scadenza Inserita correttamente $i');
        }
      });

      await get_lsscaglione().then((value) async {
        await ProvDatabase.instance.deleteallLSScaglione();

        for (int i = 0; i < value.length; i++) {
          await ProvDatabase.instance.addLSScaglione(
              "8",
              value[i].id_lsarticolo.toString(),
              value[i].prezzo.toString(),
              value[i].finoaqta.toString());
          print('LSRevisione Inserito correttamente $i');
        }
      });

      String last_dotes_1 = '0';
      List last_dotes = await d1b.rawQuery(
          'SELECT Max(id_dotes) as last_dotes from dotes where ');
      if (last_dotes[0]["last_dotes"] == null)
        last_dotes_1 = '0';
      else
        last_dotes_1 = last_dotes[0]["last_dotes"];

      await get_dotes(last_dotes_1).then((value) async {
       // await ProvDatabase.instance.deleteallDOTes();

        for (int i = 0; i < value.length; i++) {
          await ProvDatabase.instance.addDOTes(
            value[i].cd_cf.toString(),
            value[i].cd_do.toString(),
            "8",
            value[i].id_dotes.toString(),
            value[i].numerodoc.toString(),
            value[i].datadoc.toString(),
            value[i].cd_cfdest.toString(),
            value[i].cd_cfsede.toString(),
            value[i].cd_ls_1.toString(),
            value[i].cd_agente_1.toString(),
            value[i].cd_agente_2.toString(),
          );
          print('DOTes Inserito correttamente $i');
        }
      });

      String last_dorig_1 = '0';
      List last_dorig= await d1b.rawQuery(
          'SELECT Max(id_dorig) as last_dorig from dorig');
      if (last_dorig[0]["last_dorig"] == null)
        last_dorig_1 = '0';
      else
        last_dorig_1 = last_dorig[0]["last_dorig"];

      await get_dorig(last_dorig_1).then((value) async {
       // await ProvDatabase.instance.deleteallDORig();

        for (int i = 0; i < value.length; i++) {
          await ProvDatabase.instance.addDorig(
              value[i].id_dotes.toString(),
              value[i].id_dorig.toString(),
              "8",
              value[i].cd_cf.toString(),
              value[i].cd_ar.toString(),
              value[i].qta.toString(),
              value[i].descrizione.toString(),
              value[i].prezzounitariov.toString(),
              value[i].cd_aliquota.toString(),
              value[i].scontoriga.toString(),
              value[i].prezzounitarioscontatov.toString(),
              value[i].prezzototalev.toString());
          print('DORig Inserito correttamente $i');
        }
      });
      await get_dototali(last_dotes_1).then((value) async {
        //await ProvDatabase.instance.deleteallDOTotali();

        for (int i = 0; i < value.length; i++) {
          await ProvDatabase.instance.addDOTotali(
              value[i].id_dotes.toString(),
              "8",
              value[i].totimponibilev.toString(),
              value[i].totimpostav.toString(),
              value[i].totdocumentov.toString());
          print('DOTotali Inserito correttamente $i');
        }
      });

      String last_dotes_prov1 = '';
      List last_dotes_prov = await d1b.rawQuery(
          'SELECT Max(id_dotes) as last_dotes from dotes_prov where ');
      if (last_dotes_prov[0]["last_dotes"] == null)
        last_dotes_prov1 = '1';
      else
        last_dotes_prov1 = last_dotes_prov[0]["last_dotes"].toString();

      await get_dotes_prov(last_dotes_prov1).then((value) async {
        for (int i = 0; i < value.length; i++) {
          await ProvDatabase.instance.addDOTes_Prov(
            value[i].id_ditta.toString(),
            value[i].id_dotes.toString(),
            value[i].xriffatra.toString(),
            value[i].xcd_xveicolo.toString(),
            value[i].ximppag.toString(),
            value[i].xautista.toString(),
            value[i].ximpfat.toString(),
            value[i].xsettimana.toString(),
            value[i].ximb.toString(),
            value[i].xacconto.toString(),
            value[i].xtipoveicolo.toString(),
            value[i].xmodifica.toString(),
            value[i].xurgente.toString(),
            value[i].xpagata.toString(),
            value[i].xriford.toString(),
            value[i].xpagatat.toString(),
            value[i].xclidest.toString(),
          );
          print('DOTes_Prov Inserito correttamente $i');
        }
      });

      setState(() {
        isDownloading = false;
      });
      setState(() {
        Navigator.pop(context);
      });
      print('End');
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text("Errore!",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                    const Text("Non sei connesso ad Internet.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(
                      height: 16,
                    ),
                    MaterialButton(
                      onPressed: () async {
                        setState(() {});
                        Navigator.pop(context);
                      },
                      child: const Text("Riprova"),
                      color: Color.fromARGB(174, 140, 235, 123),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      minWidth: double.infinity,
                    ),
                  ],
                ),
              ),
            );
          });
    }

    setState(() => isDownloading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Builder(
          builder: (context) {
            if (isDownloading) {
              return content();
            } else {
              return test();
            }
          },
        ),
      );

  Container test() {
    return Container(
      child: Text(''),
    );
  }

  Container content() {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('Download dati da Online'),
          //Image.asset('assets/logo.png'),
          SizedBox(
            height: 50,
            width: double.infinity,
          ),
          LoadingJumpingLine.circle()
        ],
      ),
    );
  }
}
