import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:imi/db/databases.dart';
import 'package:imi/model/agente.dart';
import 'package:imi/model/ar.dart';
import 'package:imi/model/cf.dart';
import 'package:imi/model/dotes.dart';
import 'package:imi/model/dototali.dart';
import 'package:imi/model/ls.dart';
import 'package:imi/model/lsarticolo.dart';
import 'package:imi/model/lsrevisione.dart';
import 'package:imi/model/lsscaglione.dart';
import 'package:http/http.dart' as http;
import 'package:imi/page/ar.dart';
import 'package:imi/page/home.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:loading_animations/loading_animations.dart';

import '../model/dorig.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

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
  var url = 'https://bohagent.cloud/api/b2b/get_imi/dotes/IMI1234/$last_dotes';

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

Future<List<DORig>> get_dorig(String last_dorig) async {
  print('https://bohagent.cloud/api/b2b/get_imi/dorig/IMI1234/$last_dorig');
  var url = 'https://bohagent.cloud/api/b2b/get_imi/dorig/IMI1234/$last_dorig';

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
  print('https://bohagent.cloud/api/b2b/get_imi/dototali/IMI1234/$last_dotes');
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

class _LoginPageState extends State<LoginPage> {
  bool isDownloading = false;
  bool isDownloaded = false;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    super.initState();
    check();
  }

  Future check() async {
    final d1b = await ProvDatabase.instance.database;
    List checkDB = await d1b.rawQuery('SELECT * from agente');
    if (checkDB.isNotEmpty)
      setState(() {
        isDownloaded = true;
      });
  }

  @override
  Widget build(BuildContext context) {
    return isDownloading == true
        ? Center(
            child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/logo.jpg'),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                ),
                LoadingJumpingLine.circle()
              ],
            ),
          ))
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
                title: !isDownloaded
                    ? InkWell(
                        onTap: () async {
                          bool internet =
                              await InternetConnectionChecker().hasConnection;
                          if (internet) {
                            //Navigator.of(context).push(MaterialPageRoute(builder: (context) => ,))

                            setState(() {
                              isDownloading = true;
                            });

                            print('Start');

                            var d1b = await ProvDatabase.instance.database;
                            String last_ar1 = '';
                            List last_ar = await d1b.rawQuery(
                                'SELECT Max(id_ar) as last_ar from ar ');
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
                                    value[i]
                                        .cd_arclasse1
                                        .replaceAll('[e]', '&'),
                                    value[i]
                                        .cd_arclasse2
                                        .replaceAll('[e]', '&'),
                                    value[i]
                                        .cd_arclasse3
                                        .replaceAll('[e]', '&'),
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
                                  value[i]
                                      .mail
                                      .toString()
                                      .replaceAll('[e]', '&'),
                                );
                                print('CF Inserito correttamente $i');
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
                                  print(
                                      'LSRevisione Inserito correttamente $i');
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
                              last_dotes1 =
                                  last_dotes[0]["last_dotes"].toString();
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
                              last_dorig1 =
                                  last_dorig[0]["last_dorig"].toString();
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
                            setState(() {
                              isDownloading = false;
                              check();
                            });
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
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
                                          const Text(
                                              "Non sei connesso ad Internet.",
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
                                            color: Color.fromARGB(
                                                174, 140, 235, 123),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            minWidth: double.infinity,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          }
                        },
                        child: Text(
                          "Aggiorna Dati",
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                    : Text('')),
            body: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: Center(
                    child: Container(
                        width: 200,
                        height: 150,
                        /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                        child: Image.asset('assets/logo.jpg')),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: username,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                        hintText: 'Inserisci il tuo Nome Utente'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Inserisci la tua Password'),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20)),
                  child: FlatButton(
                    onPressed: () async {
                      var d1b = await ProvDatabase.instance.database;

                      List login = await d1b.rawQuery(
                          'SELECT * from agente where cd_agente = \'${username.text.toString()}\' and xpassword = \'${password.text.toString()}\' ');
                      if (login.isNotEmpty)
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(
                                agente: username.text.toString(),
                              ),
                            ));
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
