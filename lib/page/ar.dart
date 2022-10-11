import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:imi/page/aggiorna.dart';
import 'package:imi/page/login.dart';
import 'package:intl/intl.dart';
import 'package:imi/db/databases.dart';
import 'package:imi/model/cf.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:imi/model/dotes_prov.dart';
import 'package:imi/model/imi.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:imi/page/agente.dart';
import 'package:imi/page/documenti.dart';
import 'package:imi/page/table.dart';
import 'package:imi/model/dorig.dart';
import 'package:imi/model/dotes.dart';
import 'package:imi/model/dototali.dart';
import 'package:imi/model/ls.dart';
import 'package:imi/model/lsarticolo.dart';
import 'package:imi/model/lsrevisione.dart';
import 'package:imi/model/lsscaglione.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/ar.dart';
import 'dart:math' as math;
import '../db/databases.dart';
import '../model/mggiac.dart';
import 'package:loading_animations/loading_animations.dart';
import 'Home.dart';
import 'cart.dart';
import 'dettaglio.dart';
import 'ordini.dart';

class ARPage extends StatefulWidget {
  const ARPage({this.cd_cf, required this.agente});
  final String? agente;
  final String? cd_cf;
  @override
  _ARPageState createState() => _ARPageState();
}

class _ARPageState extends State<ARPage> {
  late List<AR> articoli;
  bool isLoading = false;
  bool isDownloading = false;
  bool isSending = false;
  TextEditingController textController = TextEditingController();
  late bool internet;

  @override
  void initState() {
    super.initState();

    refreshProv();
  }

  Future refreshProv() async {
    setState(() => isLoading = true);

    internet = await InternetConnectionChecker().hasConnection;

    /*final d1b = await ProvDatabase.instance.database;
    result1 = (await d1b.query('sqlite_master',
            where:
                'type = ? and name != \'android_metadata\' and name != \'sqlite_sequence\' ',
            whereArgs: ['table']))
        .map((row) => row['name'] as String)
        .toList(growable: false);*/
/*
    final d1b = await ProvDatabase.instance.database;
    articoli = (await d1b.rawQuery('SELECT * from ar'));*/

    articoli = await ProvDatabase.instance.readAllAR();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Articoli',
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
                  articoli = await ProvDatabase.instance
                      .readAllARFilter(filtro: '$ricerca');
                else
                  articoli = await ProvDatabase.instance.readAllAR();
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
                  'Home',
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
                            HomePage(agente: widget.agente.toString()),
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
                  if (widget.cd_cf == null)
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CartPage(agente: widget.agente.toString()),
                        ));
                  else
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartPage(
                            agente: widget.agente.toString(),
                            cd_cf: widget.cd_cf,
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
                      ));
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
                      : articoli.isEmpty
                          ? Stack(
                              children: [
                                Text(
                                  'Nessun Articolo',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24),
                                )
                              ],
                            )
                          : Container(
                              color: Colors.lightBlue,
                              child: GridView.builder(
                                itemCount: articoli.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      MediaQuery.of(context).orientation ==
                                              Orientation.landscape
                                          ? 3
                                          : 2,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                  childAspectRatio: (1 / 1),
                                ),
                                itemBuilder: (
                                  context,
                                  index,
                                ) {
                                  return GestureDetector(
                                      onTap: () {
                                        int prod = articoli[index].id ?? 0;
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ProductPage(
                                                  agente:
                                                      widget.agente.toString(),
                                                  image:
                                                      articoli[index].immagine,
                                                  prod: prod,
                                                  cd_cf: widget.cd_cf),
                                            ));
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(32),
                                        child: Container(
                                          color: Colors.blueAccent,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(32),
                                                child: Container(
                                                    child: articoli[index]
                                                                .immagine !=
                                                            'null'
                                                        ? internet
                                                            ? Image.network(
                                                                articoli[index]
                                                                    .immagine,
                                                                width: 120,
                                                                height: 100,
                                                                fit:
                                                                    BoxFit.fill,
                                                              )
                                                            : Image.asset(
                                                                'assets/nophoto.jpg',
                                                                width: 120,
                                                                height: 100,
                                                                fit:
                                                                    BoxFit.fill,
                                                              )
                                                        : Image.asset(
                                                            'assets/nophoto.jpg',
                                                            width: 120,
                                                            height: 100,
                                                            fit: BoxFit.fill,
                                                          )),
                                              ),
                                              Text(articoli[index].descrizione,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white),
                                                  textAlign: TextAlign.center),
                                            ],
                                          ),
                                        ),
                                      ));
                                },
                              ))));
}
