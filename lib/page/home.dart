import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

import 'aggiorna.dart';
import 'cart.dart';
import 'cliente.dart';
import 'dettaglio.dart';
import 'documenti.dart';
import 'ordini.dart';

class HomePage extends StatefulWidget {
  const HomePage({required this.agente});
  final String? agente;
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
    print(widget.agente);

    refreshProv();
  }

  Future<http.Response> sendCart(cart) async {
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

    cf = await ProvDatabase.instance.readAllCF(widget.agente.toString());
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
                  cf = await ProvDatabase.instance
                      .readAllCF(widget.agente.toString());
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
                        builder: (context) => ARPage(
                          agente: widget.agente.toString(),
                        ),
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
                        builder: (context) => CartPage(
                          agente: widget.agente.toString(),
                        ),
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
                        builder: (context) =>
                            OrdiniPage(agente: widget.agente.toString()),
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
                        agente: widget.agente.toString(),
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
                  'Aggiorna Dati',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontFamily: 'helvetica_neue_light',
                  ),
                ),
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AggiornaPage(
                          agente: widget.agente.toString(),
                        ),
                      ));
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
              ListTile(
                title: const Text(
                  'Logout',
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
                        builder: (context) => LoginPage(),
                      ));
                },
              ),
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
                                                        agente: widget.agente
                                                            .toString(),
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
                                                  cd_cf: cf[index].cd_cf,
                                                  agente: widget.agente
                                                      .toString())),
                                            ));
                                      },
                                    )),
                                  );
                                },
                              ))));
}
