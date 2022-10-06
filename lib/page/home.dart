import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List cf;
  bool isLoading = false;
  bool isDownloading = false;
  bool isSending = false;
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    refreshProv();
  }

  Future<http.Response> sendCart(cart) async {
    /* String ciao = jsonEncode(<String, String>{
      'cd_ar': cart.cd_ar.toString(),
      'id_ditta': '7',
      'cd_cf': cart.cd_cf.toString(),
      'cd_cfsede': cart.cd_cfsede.toString(),
      'cd_cfdest': cart.cd_cfdest.toString(),
      'cd_agente_1': cart.cd_agente_1.toString(),
      'qta': '${cart.qta}',
      // 'xcolli': cart.xcolli.toString(),
      // 'xbancali': cart.xbancali.toString(),
      // 'prezzo_unitario': cart.prezzo_unitario.toString(),
      'cd_aliquota': cart.cd_aliquota.toString(),
      //'aliquota': cart.aliquota.toString(),
      //'totale': cart.totale.toString(),
      //'imposta': cart.imposta.toString(),
      //'da_inviare': cart.da_inviare.toString(),
      'note': cart.note.toString(),
      //'scontoriga': cart.sconto_riga.toString(),
    });
    print(ciao);*/

    final response = await http.post(
      Uri.parse('https://bohagent.cloud/api/b2b/set_imi_cart/IMI1234'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'cd_ar': cart.cd_ar.toString(),
        'id_ditta': '8',
        'cd_cf': cart.cd_cf.toString(),
        //'cd_cfsede': cart.cd_cfsede.toString(),
        //'cd_cfdest': cart.cd_cfdest.toString(),
        //'cd_agente_1': cart.cd_agente_1.toString(),
        'qta': '${cart.qta}',
        'xcolli': '0',
        'xbancali': '0',
        'prezzo_unitario': cart.prezzo_unitario.toString(),
        'cd_aliquota': '22',
        'aliquota': '22',
        //'totale': '0',
        //'imposta': '0',
        //'da_inviare': '0',
        'note': '',
        'scontoriga': '0',
        'xconfezione': cart.confenzione.toString(),
      }),
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return response;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      return response;
    }
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

  Future refreshProv() async {
    setState(() => isLoading = true);

    /*final d1b = await ProvDatabase.instance.database;
    result1 = (await d1b.query('sqlite_master',
            where:
                'type = ? and name != \'android_metadata\' and name != \'sqlite_sequence\' ',
            whereArgs: ['table']))
        .map((row) => row['name'] as String)
        .toList(growable: false);*/
/*
    final d1b = await ProvDatabase.instance.database;
    cf = (await d1b.rawQuery('SELECT * from ar'));*/

    cf = await ProvDatabase.instance.readAllCF();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Clienti',
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.lightBlue,
        actions: [
          AnimSearchBar(
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              suffixIcon: Icon(
                Icons.send,
                color: Colors.white,
              ),
              color: Colors.lightBlue,
              width: 380,
              textController: textController,
              onSuffixTap: () async {
                String ricerca = textController.text;
                final d1b = await ProvDatabase.instance.database;
                if (ricerca != '')
                  cf = await ProvDatabase.instance
                      .readAllCFFilter(filtro: '$ricerca');
                else
                  cf = await ProvDatabase.instance.readAllCF();
                textController.clear();

                setState(() => isLoading = false);
              })
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.lightBlue,
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(
                height: 300.0,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      image: DecorationImage(
                          image: AssetImage("assets/logo.jpg"),
                          fit: BoxFit.fill)),
                  child: Text(''),
                ),
              ),
              ListTile(
                title: const Text(
                  'Articoli',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontFamily: 'helvetica_neue_light',
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ARPage(),
                      ));
                },
              ),
              ListTile(
                title: const Text(
                  'Ordini da Gestire',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontFamily: 'helvetica_neue_light',
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPage(),
                      ));
                },
              ),
              ListTile(
                title: const Text(
                  'Ordini da Sincronizzare',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontFamily: 'helvetica_neue_light',
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrdiniPage(),
                      ));
                },
              ),
              ListTile(
                title: const Text(
                  'Brogliaccio Giornaliero',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontFamily: 'helvetica_neue_light',
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DocumentiPage(
                        date: DateFormat('dd-MM-yyyy')
                            .format(DateTime.now())
                            .toString(),
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text(
                  'Invia Ordini da Sincronizzare',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontFamily: 'helvetica_neue_light',
                  ),
                ),
                onTap: () async {
                  bool internet =
                      await InternetConnectionChecker().hasConnection;
                  if (internet) {
                    Navigator.pop(context);
                    setState(() {
                      isSending = true;
                    });

                    print('Start');

                    await ProvDatabase.instance
                        .readAllCartFilter()
                        .then((value) async {
                      if (value.isNotEmpty) {
                        for (int i = 0; i < value.length; i++) {
                          await sendCart(value[i]);

                          print('Inserito correttamente riga $i');
                        }
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            var articolo;
                            var quantita;
                            var cliente;

                            TextEditingController articoloController =
                                TextEditingController();
                            TextEditingController quantitaController =
                                TextEditingController();
                            TextEditingController clienteController =
                                TextEditingController();

                            return AlertDialog(
                              content: Container(
                                width: MediaQuery.of(context).size.width / 1.3,
                                height: MediaQuery.of(context).size.height / 4,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: const Color(0xFFFFFF),
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(32.0)),
                                ),
                                // ignore: unnecessary_new
                                child: new Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('Errore!'),
                                    Text(
                                      'Nessuna riga è presente nel carrello!',
                                      textAlign: TextAlign.center,
                                    ),
                                    MaterialButton(
                                        onPressed: () async {
                                          Navigator.of(context).pop();
                                          refreshProv();
                                        },
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              12,
                                          padding: EdgeInsets.all(15.0),
                                          child: Material(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(25.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    'Ok',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18.0,
                                                      fontFamily:
                                                          'helvetica_neue_light',
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              )),
                                        )),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                      await ProvDatabase.instance.deleteallCart();
                    });

                    setState(() {
                      isSending = false;
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 30),
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
                },
              ),
              ListTile(
                title: const Text(
                  'Aggiorna Dati',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontFamily: 'helvetica_neue_light',
                  ),
                ),
                onTap: () async {
                  bool internet =
                      await InternetConnectionChecker().hasConnection;
                  if (internet) {
                    Navigator.pop(context);
                    refreshProv();
                    setState(() {
                      isDownloading = true;
                    });

                    print('Start');

                    var d1b = await ProvDatabase.instance.database;
                    String last_ar1 = '';
                    List last_ar = await d1b
                        .rawQuery('SELECT Max(id_ar) as last_ar from ar ');
                    if (last_ar[0]["last_ar"] == null)
                      last_ar1 = '1';
                    else
                      last_ar1 = last_ar[0]["last_ar"].toString();

                    await get_ar(last_ar1).then((value) async {
                      for (int i = 0; i < value.length; i++) {
                        await ProvDatabase.instance.addAR(
                            value[i].cd_AR.replaceAll('[e]', '&'),
                            value[i].descrizione.replaceAll('[e]', '&'),
                            value[i].cd_aliquota_v,
                            value[i].cd_arclasse1.replaceAll('[e]', '&'),
                            value[i].cd_arclasse2.replaceAll('[e]', '&'),
                            value[i].cd_arclasse3.replaceAll('[e]', '&'),
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
                          '8',
                          value[i]
                              .descrizione
                              .toString()
                              .replaceAll('[e]', '&'),
                          value[i].indirizzo,
                          value[i].localita,
                          value[i].cap,
                          value[i].cd_nazione,
                          value[i].cliente,
                          value[i].fornitore,
                          value[i].cd_provincia,
                          value[i].cd_agente_1.toString(),
                          value[i].cd_agente_2.toString(),
                          value[i].mail.toString().replaceAll('[e]', '&'),
                        );
                        print('CF Inserito correttamente $i');
                      }
                    });

                    await get_mggiac().then((value) async {
                      //await ProvDatabase.instance.deleteallMGGIAC();

                      for (int i = 0; i < value.length; i++) {
                        List check = [];
                        var d1b = await ProvDatabase.instance.database;
                        check = await d1b.rawQuery(
                            'SELECT * from mggiac where  cd_ar =\'${value[i].cd_ar.toString()}\' and cd_mg =\'${value[i].cd_mg.toString()}\' and giacenza =\'${value[i].giacenza.toString()}\' and disponibile = \'${value[i].disponibile.toString()}\' ');
                        if (check.isEmpty) {
                          await ProvDatabase.instance.addMGGIAC(
                              "8",
                              value[i].cd_ar,
                              value[i].disponibile,
                              value[i].giacenza,
                              value[i].cd_mg);
                          print('Giacenza Inserita correttamente $i');
                        } else
                          print('GIACENZA Già inserito');
                      }
                    });

                    await get_ls().then((value) async {
                      // await ProvDatabase.instance.deleteallLS();

                      for (int i = 0; i < value.length; i++) {
                        List check = [];
                        var d1b = await ProvDatabase.instance.database;
                        check = await d1b.rawQuery(
                            'SELECT * from ls where  cd_ls =\'${value[i].cd_ls.toString()}\' and descrizione = \'${value[i].descrizione.toString()}\' ');
                        if (check.isEmpty) {
                          await ProvDatabase.instance.addLS(
                            "8",
                            value[i].cd_ls.toString(),
                            value[i]
                                .descrizione
                                .toString()
                                .replaceAll('[e]', '&'),
                          );
                          print('LS Inserito correttamente $i');
                        } else
                          print('LS Già inserito');
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
                      //  await ProvDatabase.instance.deleteallLSRevisione();

                      for (int i = 0; i < value.length; i++) {
                        List check = [];
                        var d1b = await ProvDatabase.instance.database;
                        check = await d1b.rawQuery(
                            'SELECT * from lsrevisione where id_lsrevisione = \'${value[i].id_lsrevisione.toString()}\' and cd_ls =\'${value[i].cd_ls.toString()}\' and descrizione = \'${value[i].descrizione.toString()}\' ');
                        if (check.isEmpty) {
                          await ProvDatabase.instance.addLSRevisione(
                              "8",
                              value[i].id_lsrevisione.toString(),
                              value[i].cd_ls.toString(),
                              value[i].descrizione.toString());
                          print('LSRevisione Inserito correttamente $i');
                        } else
                          print('LSRevisione Già inserito');
                      }
                    });

                    await get_lsscaglione().then((value) async {
//                      await ProvDatabase.instance.deleteallLSScaglione();

                      for (int i = 0; i < value.length; i++) {
                        List check = [];
                        var d1b = await ProvDatabase.instance.database;
                        check = await d1b.rawQuery(
                            'SELECT * from lsscaglione where  id_lsarticolo =\'${value[i].id_lsarticolo.toString()}\' and prezzo = \'${value[i].prezzo.toString()}\'  and finoaqta = \'${value[i].finoaqta.toString()}\' ');
                        if (check.isEmpty) {
                          await ProvDatabase.instance.addLSScaglione(
                              "8",
                              value[i].id_lsarticolo.toString(),
                              value[i].prezzo.toString(),
                              value[i].finoaqta.toString());
                          print('LSArticolo Inserito correttamente $i');
                        } else
                          print('LSArticolo Già inserito');
                      }
                    });
                    String last_dotes1 = '';
                    List last_dotes = await d1b.rawQuery(
                        'SELECT Max(id_dotes) as last_dotes from dotes');
                    if (last_dotes[0]["last_dotes"] == null)
                      last_dotes1 = '1';
                    else
                      last_dotes1 = last_dotes[0]["last_dotes"].toString();
                    await get_dotes(last_dotes1).then((value) async {
                      //await ProvDatabase.instance.deleteallDOTes();
                      print(value.length);
                      print('dotes lenght');
                      for (int i = 0; i < value.length; i++) {
                        List check = [];
                        var d1b = await ProvDatabase.instance.database;
                        check = await d1b.rawQuery(
                            'SELECT * from dotes where id_dotes = \'${value[i].id_dotes.toString()}\' and cd_cf =\'${value[i].cd_cf.toString()}\' and cd_agente_2 =\'${value[i].cd_agente_2.toString()}\'   and cd_agente_1 =\'${value[i].cd_agente_1.toString()}\'   and cd_ls_1 =\'${value[i].cd_ls_1.toString()}\'  and cd_cfsede =\'${value[i].cd_cfsede.toString()}\'  and cd_cfdest = \'${value[i].cd_cfdest.toString()}\'  and cd_do = \'${value[i].cd_do.toString()}\'  and numerodoc = \'${value[i].numerodoc.toString()}\'  and datadoc = \'${value[i].datadoc.toString()}\' ');
                        if (check.isEmpty) {
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
                        } else
                          print('DOTes Già inserito');
                      }
                    });
                    String last_dorig1 = '';
                    List last_dorig = await d1b.rawQuery(
                        'SELECT Max(id_dorig) as last_dorig from dorig');
                    if (last_dorig[0]["last_dorig"] == null)
                      last_dorig1 = '1';
                    else
                      last_dorig1 = last_dorig[0]["last_dorig"].toString();
                    await get_dorig(last_dorig1).then((value) async {
                      print(value.length);
                      print('dorig lenght');
                      //await ProvDatabase.instance.deleteallDORig();

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

                    await get_dototali(last_dotes1).then((value) async {
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
                        'SELECT Max(id_dotes) as last_dotes from dotes_prov');
                    if (last_dotes_prov[0]["last_dotes"] == null)
                      last_dotes_prov1 = '1';
                    else
                      last_dotes_prov1 =
                          last_dotes_prov[0]["last_dotes"].toString();

                    await get_dotes_prov(last_dotes_prov1).then((value) async {
                      for (int i = 0; i < value.length; i++) {
                        await ProvDatabase.instance.addDOTes_Prov(
                          "8",
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
                    refreshProv();
                    setState(() {});
                    print('End');
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 30),
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
                },
              ),
              /*ListTile(
                title: const Text('Table'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TablePage(
                          tabella: 'mggiac',
                        ),
                      ));
                },
              ),*/
              /*ListTile(
                title: const Text('Logout'),
                onTap: () {
                },
              ),*/
            ],
          ),
        ),
      ),
      body: Center(
          child: isSending
              ? Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('Creazione Ordini da Carrello in corso'),
                      //Image.asset('assets/logo.png'),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                      ),
                      LoadingJumpingLine.circle()
                    ],
                  ),
                )
              : isDownloading
                  ? Container(
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
                    )
                  : isLoading
                      ? const CircularProgressIndicator()
                      : cf.isEmpty
                          ? Stack(
                              children: [
                                Text(
                                  'Nessun Cliente',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24),
                                )
                              ],
                            )
                          : Container(
                              color: Colors.white, //white70
                              child: ListView.builder(
                                itemCount: cf.length,
                                /*gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      MediaQuery.of(context).orientation ==
                                              Orientation.landscape
                                          ? 3
                                          : 2,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                  childAspectRatio: (1 / 1),
                                ),*/
                                itemBuilder: (
                                  context,
                                  index,
                                ) {
                                  return Material(
                                    type: MaterialType.transparency,
                                    child: (ListTile(
                                      /*
                                      child: GestureDetector(
                                    onTap: () {
                                      print(cf[index].id);
                                      int prod = cf[index].id;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProductPage(prod: prod),
                                          ));
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(32),
                                      child: Container(
                                        color: Colors.blueAccent,
                                        /* Color(
                                        (math.Random().nextDouble() * 0xFFFFFF)
                                            .toInt())
                                    .withOpacity(1.0),*/
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(cf[index].descrizione),
                                            /* ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(32),
                                                child: Container(
                                                    child: cf[index].immagine !=
                                                            'null'
                                                        ? Image.network(
                                                            cf[index].immagine,
                                                            width: 120,
                                                            height: 100,
                                                            fit: BoxFit.fill,
                                                          )
                                                        : Image.asset(
                                                            'assets/nophoto.jpg',
                                                            width: 120,
                                                            height: 100,
                                                            fit: BoxFit.fill,
                                                          )),
                                              ),*/
                                            Text(cf[index].descrizione,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white),
                                                textAlign: TextAlign.center),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )*/
                                      leading: Text(cf[index].cd_cf,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black),
                                          textAlign: TextAlign.center),
                                      title: Text(cf[index].descrizione,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black),
                                          textAlign: TextAlign.center),
                                      trailing: IconButton(
                                        icon: Icon(
                                          Icons.info_outline,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    (ClientePage(
                                                        cd_cf:
                                                            cf[index].cd_cf)),
                                              ));
                                        },
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => (ARPage(
                                                  cd_cf: cf[index].cd_cf)),
                                            ));
                                      },
                                    )),
                                  );
                                },
                              ))));
}
