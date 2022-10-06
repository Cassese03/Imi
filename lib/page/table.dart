import 'dart:async';
import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../db/databases.dart';
import 'package:flutter/material.dart';
import 'package:imi/db/databases.dart';
import 'package:imi/model/imi.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:imi/page/agente.dart';
import 'package:loading_animations/loading_animations.dart';
import '../model/cart.dart';

class TablePage extends StatefulWidget {
  const TablePage({required this.tabella});

  final String tabella;
  @override
  // ignore: library_private_types_in_public_api
  _TablePageState createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  bool isLoading = true;
  late List colonne;
  late List righe;

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
        'xconfezione': cart.confezione.toString(),
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

  @override
  void initState() {
    super.initState();

    refreshProv();
  }

  Future refreshProv() async {
    setState(() => isLoading = true);

    final d1b = await ProvDatabase.instance.database;

    String tabella = widget.tabella;
    colonne = await d1b.rawQuery("PRAGMA table_info(" + tabella + ")", null);
    righe = await d1b.rawQuery("SELECT * FROM " + tabella, null);
//    print(righe);
//    print(colonne[0]['name']);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Colonne',
          style: TextStyle(fontSize: 24),
        ),
        actions: [Icon(Icons.search), SizedBox(width: 12)],
      ),
      body: Stack(
        children: [
          isLoading
              ? Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      //Image.asset('assets/logo.png'),
                      SizedBox(
                        height: 50,
                        width: screenWidth,
                      ),
                      LoadingJumpingLine.circle()
                    ],
                  ),
                )
              : colonne.isEmpty
                  ? const Text(
                      'Nessuna Colonna',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  : righe.isEmpty
                      ? SafeArea(
                          child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            color: Colors.grey,
                            padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                            width: screenWidth,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                        width: 2.0,
                                        color: Theme.of(context).dividerColor),
                                  ),
                                  headingRowColor:
                                      MaterialStateColor.resolveWith(
                                          (states) => Colors.green),
                                  border: TableBorder.symmetric(
                                    outside: BorderSide(width: 1),
                                    inside: BorderSide(width: 1),
                                  ),
                                  dataRowColor:
                                      MaterialStateProperty.all(Colors.white),
                                  columns: [
                                    for (var element in colonne)
                                      DataColumn(
                                          label: Text(
                                        element["name"],
                                        style: TextStyle(color: Colors.black),
                                        textAlign: TextAlign.center,
                                      )),
                                  ],
                                  rows: [
                                    for (var element in righe)
                                      DataRow(cells: [
                                        for (var i = 0; i < colonne.length; i++)
                                          DataCell(
                                            Text(
                                              'Ciao',
                                              style: TextStyle(
                                                  color: Colors.black),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                      ]),
                                  ]),
                            ),
                          ),
                        ))
                      : SafeArea(
                          child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            color: Colors.grey,
                            padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                            width: screenWidth,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                        width: 2.0,
                                        color: Theme.of(context).dividerColor),
                                  ),
                                  headingRowColor:
                                      MaterialStateColor.resolveWith(
                                          (states) => Colors.green),
                                  border: TableBorder.symmetric(
                                    outside: BorderSide(width: 1),
                                    inside: BorderSide(width: 1),
                                  ),
                                  dataRowColor:
                                      MaterialStateProperty.all(Colors.white),
                                  columns: [
                                    for (var element in colonne)
                                      DataColumn(
                                          label: Text(
                                        element["name"],
                                        style: TextStyle(color: Colors.black),
                                        textAlign: TextAlign.center,
                                      )),
                                  ],
                                  rows: [
                                    //for (var element in righe)
                                    /*DataRow(cells: [
                                        for (var i = 0; i < colonne.length; i++)
                                          DataCell(
                                            Text(
                                              element[colonne[i]["name"]]
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.black),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                      ]),*/
                                  ]),
                            ),
                          ),
                        )),
          ButtonTheme(
            child: Positioned(
              bottom: 0,
              left: 0,
              child: FloatingActionButton(
                heroTag: "btn2",
                backgroundColor: Colors.black,
                child: const Icon(Icons.add),
                onPressed: () async {
                  isLoading = true;
                  /*
                  final db = await ProvDatabase.instance.database;
                  final maps = await db.rawQuery(
                      '''SELECT * FROM imi ORDER BY number DESC''');

                  if (maps.isEmpty) {
                    await ProvDatabase.instance.addimi(1);
                  } else {
                    await ProvDatabase.instance
                        .addimi((maps[0]['number'] as int) + 1);
                  }*/

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
                          height: MediaQuery.of(context).size.height / 2.5,
                          decoration: new BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: const Color(0xFFFFFF),
                            borderRadius:
                                new BorderRadius.all(new Radius.circular(32.0)),
                          ),
                          // ignore: unnecessary_new
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              TextFormField(
                                controller: articoloController,
                                keyboardType: TextInputType.name,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Inserisci il codice Articolo',
                                  labelText: 'Codice Articolo',
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              TextFormField(
                                controller: quantitaController,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Inserisci la quantità desiderata',
                                  labelText: 'Quantita',
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              TextFormField(
                                controller: clienteController,
                                keyboardType: TextInputType.name,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Inserisci il codice Cliente',
                                  labelText: 'Cliente',
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              MaterialButton(
                                  onPressed: () async {
                                    print('Articolo : ' +
                                        articoloController.text.toString() +
                                        ' - Quantita : ' +
                                        quantitaController.text.toString() +
                                        ' - Cliente : ' +
                                        clienteController.text.toString());
                                    await ProvDatabase.instance.addCart(
                                        clienteController.text.toString(),
                                        articoloController.text.toString(),
                                        quantitaController.text.toString(),
                                        "null".toString(),
                                        "null".toString(),
                                        "null".toString(),
                                        "null".toString(),
                                        "null".toString(),
                                        "null".toString(),
                                        "null".toString(),
                                        "null".toString(),
                                        "null".toString(),
                                        "null".toString(),
                                        "null".toString(),
                                        "null".toString(),
                                        "null".toString(),
                                        "0");

                                    Navigator.of(context).pop();
                                    refreshProv();
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height:
                                        MediaQuery.of(context).size.height / 12,
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
                                              'Inserisci',
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

                  refreshProv();
                },
              ),
            ),
          ),
          ButtonTheme(
            child: Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: FloatingActionButton(
                  heroTag: "btn3",
                  backgroundColor: Colors.black,
                  child: const Icon(Icons.delete),
                  onPressed: () async {
                    /*
                  final db = await ProvDatabase.instance.database;
                  final maps = await db.rawQuery(
                      '''SELECT * FROM imi ORDER BY number DESC''');

                  if (maps.isEmpty) {
                    await ProvDatabase.instance.addimi(1);
                  } else {
                    await ProvDatabase.instance
                        .addimi((maps[0]['number'] as int) + 1);
                  }*/

                    isLoading = true;
                    await ProvDatabase.instance.deleteallCart();
                    isLoading = false;
                    refreshProv();
                  }),
            ),
          ),
          ButtonTheme(
            child: Positioned(
              bottom: 0,
              right: 0,
              child: FloatingActionButton(
                heroTag: "btn1",
                backgroundColor: Colors.black,
                child: const Icon(Icons.send),
                onPressed: () async {
                  isLoading = true;

                  print('Start');

                  await ProvDatabase.instance.readAllCart().then((value) async {
                    for (int i = 0; i < value.length; i++) {
                      await sendCart(value[i]);

                      print('Inserito correttamente riga $i');
                    }
                  });
                  await ProvDatabase.instance.deleteallCart();
                  print('End');

                  /*
            final db = await ProvDatabase.instance.database;
            final maps = await db
                .rawQuery('''SELECT * FROM imi ORDER BY number DESC''');

            if (maps.isEmpty) {
              await ProvDatabase.instance.addimi(1);
            } else {
              await ProvDatabase.instance
                  .addimi((maps[0]['number'] as int) + 1);
            }*/
                  refreshProv();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*SafeArea(
                        child: SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              childAspectRatio: 1 / 1.80,
                            ),
                            itemCount: colonne.length,
                            itemBuilder: (context, index) {
                              final dati = colonne[index];
                              return TableCardWidget(
                                  note: dati['name'].toString(), index: index);
                            },
                          ),
                        ),
                      ),
            isLoading
                ? const CircularProgressIndicator()
                : righe.isEmpty
                    ? SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 110.0),
                          child: SizedBox(
                              width: double.infinity,
                              height: 100,
                              child: Text(
                                '  Nessuna Riga',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              )),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 90.0),
                            child: SizedBox(
                              width: double.infinity,
                              height: 100,
                              child: GridView.count(
                                childAspectRatio: 1 / 1.80,
                                crossAxisCount: 3,
                                children: [
                                  
                                  Container(
                                    width: 160.0,
                                    color: Colors.red,
                                  ),
                                  Container(
                                    width: 160.0,
                                    color: Colors.blue,
                                  ),
                                  Container(
                                    width: 160.0,
                                    color: Colors.green,
                                  ),
                                  Container(
                                    width: 160.0,
                                    color: Colors.yellow,
                                  ),
                                  Container(
                                    width: 160.0,
                                    color: Colors.orange,
                                  ),
                                  for (var element2 in righe)
                                    for (var element in colonne)
                                      buildNotes(element2, element),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: const Icon(Icons.add),
          onPressed: () async {
            isLoading = true;

            refreshProv();
          },
        ),
      );

  Widget buildNotes() => GridView.count(
        padding: const EdgeInsets.all(8),
        //itemCount: colonne.length,
        /*staggeredTileBuilder: (int index) =>
            StaggeredTile.extent(colonne.length, 100),*/
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      //  itemBuilder: (context, index) {
        children: [
          final note = colonne[index];

          return GestureDetector(
            onTap: () async {
              /*
                await Navigator.of(context).push(MaterialPageRoute(
                 builder: (context) => TablePage(tabella: note),
                ));
              */
              refreshProv();
            },
            onLongPress: () async {
              /*
                int? ciao = result1[index].id;

                (ciao) != null ? await ProvDatabase.instance.delete(ciao) : '';
              */
              refreshProv();
            },
            child: TableCardWidget(note: note["name"], index: index),
          );
        ],
      );

  Widget buildNotes(var element2, var element) {
    return Container(
      child: TableCardWidget(
          note: righe[element2["_id"] - 1][element["name"]].toString(),
          index: righe.length),
    );

    return Container();
  }

  
    double i = 0.00;

    for (var element in colonne) {
      i = i + 90.0;
      return SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: i),
          child: SizedBox(
            width: double.infinity,
            height: 100,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 1 / 1.80,
              ),
              itemCount: righe.length,
              itemBuilder: (context, index) {*/
                      //              String colonna = colonne[index]["name"];
                      /*colonne.forEach((element) {
                  return TableCardWidget(
                      note: righe[index][element["name"]].toString(),
                      index: index);
                  print(righe[index][element["name"]].toString());
                });
*/ /*
                for (var element2 in righe) {
                  return TableCardWidget(
                      note: element2[element["name"].toString()].toString(),
                      index: index);
                }
                return SafeArea(child: SizedBox());
              },
            ),
          ),
        ),
      );
    }
    return SafeArea(child: SizedBox());
  }*/ /*SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 90.0),
          child: SizedBox(
            width: double.infinity,
            height: 100,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 1 / 1.80,
              ),
              itemCount: righe.length,
              itemBuilder: (context, index) {
                //              String colonna = colonne[index]["name"];
                /*colonne.forEach((element) {
                  return TableCardWidget(
                      note: righe[index][element["name"]].toString(),
                      index: index);
                  print(righe[index][element["name"]].toString());
                });
*/
                for (var element in colonne) {
                  print(righe[index][element["name"]].toString());

                  return TableCardWidget(
                      note: righe[index][element["name"]].toString(),
                      index: index);
                }
                return SafeArea(child: SizedBox());
              },
            ),
          ),
        ),
      );*/