import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:imi/page/dettaglio_docu.dart';
import 'package:imi/page/home.dart';
import 'package:imi/page/table.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';

import '../db/databases.dart';
import 'cart.dart';

bool isLoading = false;

class DocumentiPage extends StatefulWidget {
  static const String id = '/DocumentiPage';

  DocumentiPage({required this.date, required this.agente});
  final String? agente;

  final String date;

  @override
  State<DocumentiPage> createState() => _DocumentiPageState();
}

class _DocumentiPageState extends State<DocumentiPage>
    with SingleTickerProviderStateMixin {
  late List ovc = [];
  late List ove = [];
  late List oaf = [];
  late List ftv = [];
  bool isLoading = true;
  late TabController _tabController;
  String Data = '';
  @override
  void initState() {
    super.initState();

    Data = widget.date.toString();

    refreshDocumenti();

    _tabController = TabController(vsync: this, length: 2);
  }

  Future refreshDocumenti() async {
    setState(() {
      isLoading = true;
    });

    final d1b = await ProvDatabase.instance.database;

    var trans = DateFormat("dd-MM-yyyy").parse('$Data').toString();

    String id = trans.substring(0, 19);

    ovc = await d1b.rawQuery(
        'SELECT *, (SELECT descrizione from cf where cd_cf = d.cd_cf ) as descrizione from dotes d where d.datadoc  = \'$id\' and d.cd_do = \'OVC\' ');

    ove = await d1b.rawQuery(
        'SELECT *, (SELECT descrizione from cf where cd_cf = d.cd_cf ) as descrizione from dotes d where d.id_ditta = \'8\' and d.datadoc  = \'$id\' and d.cd_do = \'OVE\'');

    oaf = await d1b.rawQuery(
        'SELECT *, (SELECT descrizione from cf where cd_cf = d.cd_cf ) as descrizione from dotes d where d.id_ditta = \'8\' and d.datadoc  = \'$id\' and d.cd_do = \'OAF\' ');

    ftv = await d1b.rawQuery(
        'SELECT *, (SELECT descrizione from cf where cd_cf = d.cd_cf ) as descrizione from dotes d where d.id_ditta = \'8\' and d.datadoc  = \'$id\' and d.cd_do LIKE \'F%\'');

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateFormat("dd-MM-yyyy").parse('$Data'),
        firstDate: DateTime(2022, 1),
        lastDate: DateTime(2023));
    if (picked != null) {
      setState(() {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DocumentiPage(
                      agente: widget.agente.toString(),
                      date: DateFormat('dd-MM-yyyy').format(picked).toString(),
                    )));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading == true) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    } else {
      return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onTap: () {
              if (mounted) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          HomePage(agente: widget.agente.toString()),
                    ));
              }
            },
          ),
          centerTitle: true,
          title: Text(
            widget.date,
            style: const TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.lightBlue,
          actions: [
            IconButton(
              icon: Icon(Icons.calendar_month),
              color: Colors.white,
              onPressed: () {
                _selectDate(context);
              },
            ),
          ],
        ),
        body: isLoading
            ? const CircularProgressIndicator()
            : DefaultTabController(
                length: 2,
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
                        Container(
                          child: TabBar(
                            controller: _tabController,
                            tabs: [
                              Tab(
                                /*icon: IconButton(
                                      icon: Icon(Icons.calendar_month),
                                      color: Colors.lightBlue,
                                      onPressed: () {
                                        _selectDate(context);
                                      },
                                    ),*/
                                child: RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.lightBlue,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: (ovc.isEmpty)
                                              ? 'OVC'
                                              : 'OVC (${ovc.length})',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
                              Tab(
                                child: RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.lightBlue,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: (ove.isEmpty)
                                              ? 'OVE'
                                              : 'OVE (${ove.length})',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
                              /*Tab(
                                child: RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.lightBlue,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: (oaf.isEmpty)
                                              ? 'OAF'
                                              : 'OAF (${oaf.length})',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),*/
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              ovc.isEmpty
                                  ? Tab(
                                      text: 'NESSUN OVC IN QUESTA GIORNATA .',
                                    )
                                  : Tab(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        child: ListView(
                                          children: [
                                            for (var element in ovc)
                                              ListTile(
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        DocuPage(
                                                            agente: widget
                                                                .agente
                                                                .toString(),
                                                            id_dotes: element[
                                                                    "id_dotes"]
                                                                .toString()),
                                                  ));
                                                },
                                                leading:
                                                    Icon(Icons.feed_outlined),
                                                title: RichText(
                                                  text: TextSpan(
                                                    style: const TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black,
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text:
                                                              '${element["cd_do"]} ',
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      TextSpan(
                                                          text:
                                                              ' N° ${element["numerodoc"]} - ${element["descrizione"]}'),
                                                    ],
                                                  ),
                                                ),
                                                trailing: IconButton(
                                                  icon:
                                                      Icon(Icons.info_outline),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          DocuPage(
                                                              agente: widget
                                                                  .agente
                                                                  .toString(),
                                                              id_dotes: element[
                                                                  "id_dotes"]),
                                                    ));
                                                  },
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                              ove.isEmpty
                                  ? Tab(
                                      text: 'NESSUN OVE IN QUESTA GIORNATA .',
                                    )
                                  : Tab(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        child: ListView(
                                          children: [
                                            for (var element in ove)
                                              ListTile(
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        DocuPage(
                                                            agente: widget
                                                                .agente
                                                                .toString(),
                                                            id_dotes: element[
                                                                    "id_dotes"]
                                                                .toString()),
                                                  ));
                                                },
                                                leading:
                                                    Icon(Icons.feed_outlined),
                                                title: RichText(
                                                  text: TextSpan(
                                                    style: const TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black,
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text:
                                                              '${element["cd_do"]} ',
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      TextSpan(
                                                          text:
                                                              ' N° ${element["numerodoc"]} - ${element["descrizione"]}'),
                                                    ],
                                                  ),
                                                ),
                                                trailing: IconButton(
                                                  icon:
                                                      Icon(Icons.info_outline),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          DocuPage(
                                                              agente: widget
                                                                  .agente
                                                                  .toString(),
                                                              id_dotes: element[
                                                                  "id_dotes"]),
                                                    ));
                                                  },
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ), /*
                              oaf.isEmpty
                                  ? Tab(
                                      text: 'NESSUN OAF IN QUESTA GIORNATA .',
                                    )
                                  : Tab(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        child: ListView(
                                          children: [
                                            for (var element in oaf)
                                              ListTile(
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        DocuPage(
                                                            id_dotes: element[
                                                                    "id_dotes"]
                                                                .toString()),
                                                  ));
                                                },
                                                leading:
                                                    Icon(Icons.feed_outlined),
                                                title: RichText(
                                                  text: TextSpan(
                                                    style: const TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black,
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text:
                                                              '${element["cd_do"]} ',
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      TextSpan(
                                                          text:
                                                              ' N° ${element["numerodoc"]} - ${element["descrizione"]}'),
                                                    ],
                                                  ),
                                                ),
                                                trailing: IconButton(
                                                  icon:
                                                      Icon(Icons.info_outline),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          DocuPage(
                                                              id_dotes: element[
                                                                  "id_dotes"]),
                                                    ));
                                                  },
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),*/
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      );
    }
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
