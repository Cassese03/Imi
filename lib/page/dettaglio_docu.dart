import 'dart:async';
import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:imi/page/home.dart';
import 'package:imi/page/table.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';

import '../db/databases.dart';
import 'cart.dart';

String prezzo = '1.00';
String prezzototale = '0.00';
bool isLoading = false;
String cd_cf = '';

class DocuPage extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const DocuPage({required this.id_dotes, required this.agente
      //required this.Testa,
      });
  final String id_dotes;
  final String? agente;

  @override
  State<DocuPage> createState() => _DocuPageState();
}

class _DocuPageState extends State<DocuPage>
    with SingleTickerProviderStateMixin {
  late List documento = [];
  late List righe = [];
  late List colonne = [];
  bool isLoading = true;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    refreshDORig();

    _tabController = TabController(vsync: this, length: 1);
  }

  Future refreshDORig() async {
    setState(() {
      isLoading = true;
    });

    final d1b = await ProvDatabase.instance.database;

    var id = widget.id_dotes;

    documento = await d1b.rawQuery(
        'SELECT * from dotes where id_ditta = \'8\' and id_dotes  = \'$id\'');

    righe = await d1b.rawQuery(
        'SELECT * from dorig where id_ditta = \'8\' and id_dotes  = \'$id\'');

    colonne = await d1b.rawQuery(
        "SELECT 'cd_ar' AS name UNION ALL  SELECT 'qta' AS name UNION ALL SELECT 'prezzounitariov' AS name ",
        null);
    print(colonne);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onTap: () {
                  if (mounted) {
                    Navigator.pop(context);
                  }
                },
              ),
              centerTitle: true,
              title: Text(
                '${documento[0]["cd_do"]}  N° ${documento[0]["numerodoc"]}',
                style: const TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.lightBlue,
              actions: [
                16.widthBox,
              ],
            ),
            body: isLoading
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : DefaultTabController(
                    length: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.white, Colors.grey.shade200],
                      )),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MainTestaPageTestaCard(
                              id_dotes: documento[0]['id_dotes'],
                            ).px(24),
                            Container(
                              child: TabBar(
                                controller: _tabController,
                                tabs: [
                                  Tab(
                                    child: Text(
                                      'Righe',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: TabBarView(
                                  controller: _tabController,
                                  children: [
                                    righe.isEmpty
                                        ? Tab(
                                            text: 'NESSUNA RIGA INSERITA.',
                                          )
                                        : Tab(
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              child: DataTable(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                    border: Border.all(
                                                        width: 2.0,
                                                        color: Theme.of(context)
                                                            .dividerColor),
                                                  ),
                                                  headingRowColor:
                                                      MaterialStateColor
                                                          .resolveWith(
                                                              (states) => Colors
                                                                  .lightBlue),
                                                  border: TableBorder.symmetric(
                                                    outside:
                                                        BorderSide(width: 1),
                                                    inside:
                                                        BorderSide(width: 1),
                                                  ),
                                                  dataRowColor:
                                                      MaterialStateProperty.all(
                                                          Colors.white),
                                                  columns: [
                                                    DataColumn(
                                                        label: Text(
                                                      "Cd_AR",
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                      textAlign:
                                                          TextAlign.center,
                                                    )),
                                                    DataColumn(
                                                        label: Text(
                                                      "Quantità",
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                      textAlign:
                                                          TextAlign.center,
                                                    )),
                                                    DataColumn(
                                                        label: Text(
                                                      "Prezzo Unitario",
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                      textAlign:
                                                          TextAlign.center,
                                                    )),
                                                  ],
                                                  rows: [
                                                    for (var element in righe)
                                                      DataRow(cells: [
                                                        for (var i = 0;
                                                            i < 3;
                                                            i++)
                                                          DataCell(
                                                            Text(
                                                              element[colonne[i]
                                                                      ["name"]]
                                                                  .toString()
                                                                  .trim(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                      ]),
                                                  ]),
                                            ),
                                          )
                                  ]),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
          );
  }
}

class PrimaryShadowedButton extends StatelessWidget {
  const PrimaryShadowedButton(
      {Key? key,
      required this.child,
      required this.onPressed,
      required this.borderRadius,
      required this.color})
      : super(key: key);

  final Widget child;
  final double borderRadius;
  final Color color;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          gradient: const RadialGradient(
              colors: [Colors.black54, Colors.black],
              center: Alignment.topLeft,
              radius: 2),
          boxShadow: [
            BoxShadow(
                color: color.withOpacity(0.25),
                offset: const Offset(3, 2),
                spreadRadius: 1,
                blurRadius: 8)
          ]),
      child: MaterialButton(
        padding: const EdgeInsets.all(0),
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            child,
          ],
        ),
      ),
    );
  }
}

class MainTestaPageTestaCard extends StatefulWidget {
  const MainTestaPageTestaCard({
    Key? key,
    required this.id_dotes,
  }) : super(key: key);

  final String? id_dotes;

  @override
  State<MainTestaPageTestaCard> createState() => _MainTestaPageTestaCardState();
}

class _MainTestaPageTestaCardState extends State<MainTestaPageTestaCard> {
  int _selectedColor = 0;
  int _selectedImageIndex = 0;
  late List Testa;
  bool isLoading = false;
  String data = '';
  String id_dotes = '';
  //String id_dotes_prov = '';

  void _updateColor(int index) {
    setState(() {
      _selectedColor = index;
    });
  }

  @override
  void initState() {
    super.initState();

    refreshDORig();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future refreshDORig() async {
    setState(() {
      isLoading = true;
    });

    final d1b = await ProvDatabase.instance.database;
    var id = widget.id_dotes;
    Testa = await d1b.rawQuery(
        'SELECT * from dotes where id_ditta = \'8\' and id_dotes  = \'$id\'');

    data = Testa[0]["datadoc"];
    id_dotes = Testa[0]["id_dotes"];

/*    List prov = await d1b.rawQuery(
        'SELECT * from dotes_prov where id_ditta = \'8\' and id_dotes  = \'$id_dotes\'');

    if (prov.isNotEmpty) id_dotes_prov = prov[0]["id_dotes"].toString();
*/
    setState(() {
      isLoading = false;
    });
  }

  final Documento = _DocuPageState();
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                height: 100,
                width: double.infinity,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: 'Codice Cliente/Fornitore :'
                                .text
                                .size(16)
                                .semiBold
                                .maxLines(2)
                                .softWrap(false)
                                .make(),
                          ),
                          '${Testa[0]["cd_cf"]}'
                              .text
                              .size(16)
                              .semiBold
                              .maxLines(2)
                              .softWrap(false)
                              .make(),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: 'Tipo Documento :'
                                .text
                                .size(16)
                                .semiBold
                                .maxLines(2)
                                .softWrap(false)
                                .make(),
                          ),
                          '${Testa[0]["cd_do"]}'
                              .text
                              .size(8)
                              .semiBold
                              .maxLines(2)
                              .softWrap(false)
                              .make(),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: 'Data Documento :'
                                .text
                                .size(16)
                                .semiBold
                                .maxLines(2)
                                .softWrap(false)
                                .make(),
                          ),
                          data
                              .substring(0, data.indexOf('00:'))
                              .toString()
                              .text
                              .size(8)
                              .semiBold
                              .maxLines(2)
                              .softWrap(false)
                              .make(),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  )
                ],
              ),
            ],
          );
  }
}
