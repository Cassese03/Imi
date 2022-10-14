import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:imi/page/dettaglio_docu.dart';
import 'package:imi/page/home.dart';
import 'package:imi/page/table.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';

import '../db/databases.dart';
import 'cart.dart';

String prezzo = '1.00';
String prezzototale = '0.00';
bool isLoading = false;
String cd_cf = '';

class ClientePage extends StatefulWidget {
  static const String id = '/ClientePage';
  // ignore: use_key_in_widget_constructors
  const ClientePage({required this.cd_cf, required this.agente});
  final String cd_cf;
  final String? agente;
  @override
  State<ClientePage> createState() => _ClientePageState();
}

class _ClientePageState extends State<ClientePage>
    with SingleTickerProviderStateMixin {
  int _quantity = 1;
  late List cliente = [];
  List doc = [];
  List sc = [];
  bool isLoading = true;
  late Timer timer;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    refreshCF();
    if (mounted) {
      timer = Timer.periodic(
          const Duration(seconds: 1), (Timer t) => _prezzototale());
    }
    _tabController = TabController(vsync: this, length: 2);
  }

  Future _prezzototale() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    prezzototale = (_quantity.toDouble() * double.parse(prezzo)).toString();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future refreshCF() async {
    setState(() {
      isLoading = true;
    });

    final d1b = await ProvDatabase.instance.database;
    var id = widget.cd_cf;

    doc = await d1b.rawQuery(
        'SELECT *, (SELECT descrizione from cf where cd_cf = d.cd_cf ) as descrizione from dotes d where d.cd_cf  = \'$id\'');

    sc = await d1b.rawQuery(
        'SELECT * from sc s where s.cd_cf  = \'$id\'');
    print(sc);

    cliente = await d1b.rawQuery(
        'SELECT * from cf where cd_cf  = \'$id\'');

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? const CircularProgressIndicator()
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
                cliente.isNotEmpty ? cliente[0]["descrizione"]:'',
                style: const TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.lightBlue,
              actions: [
                /*
                GestureDetector(

                  child: Icon(
                    Icons.shopping_bag,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CartPage(cd_cf: widget.cd_cf),
                    ));
                  },
                    ),*/
                /*
                GestureDetector(
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const TablePage(
                        tabella: 'cart',
                      ),
                    ));
                  },
                ),*/

                /*
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text(articolo[0]["cd_ar"]),
        actions: [
          FloatingActionButton(
            child: Icon(
              Icons.shopping_bag,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const TablePage(tabella: 'cart'),
              ));
            },
          )*/

                /*
          const BagButton(
            numberOfItemsPurchased: 3,
          ),*/

                16.widthBox,
              ],
            ),
            body: isLoading
                ? const CircularProgressIndicator()
                : DefaultTabController(
                    length:2,
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
                            MainClientePageClienteCard(
                              cd_cf: widget.cd_cf,
                            ).px(24),
                            16.heightBox,
                            Container(
                              child: TabBar(
                                controller: _tabController,
                                tabs: const [
                                  Tab(
                                      icon: Icon(
                                    Icons.lock_clock,
                                    color: Colors.lightBlue,
                                  )),
                                  Tab(
                                      icon: Icon(
                                          Icons.document_scanner_outlined,
                                          color: Colors.lightBlue)),
                                  ],
                              ),
                            ),
                            Container(
                              width: double.maxFinite,
                              height: 450,
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                              sc.isEmpty
                              ? Tab(text: 'NESSUNA SCADENZA INSERITA.')
                                    : Tab(child: Container(
                                width: MediaQuery.of(context)
                                    .size
                                    .width,
                                height: MediaQuery.of(context)
                                    .size
                                    .height,
                                child: ListView(
                                  children: [
                                    for (var element in sc)
                                      ListTile(
                                        onTap: () {/*

                                          Navigator.of(context)
                                              .push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DocuPage(
                                                        agente: widget.agente,
                                                        id_dotes: element[
                                                        "id_dotes"]
                                                            .toString()),
                                              ));*/
                                        },
                                        leading: Icon(
                                            Icons.feed_outlined),
                                        title: Column(
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                style: const TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.black,
                                                ),
                                                children: <TextSpan>[


                                                  TextSpan(
                                                      text:
                                                      ' N° '),
                                                  TextSpan(
                                                      text:
                                                      '${element["numfattura"]}',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                          FontWeight
                                                              .bold)),

                                                ],
                                              ),
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                style: const TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.black,
                                                ),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text:
                                                      'Importo :'),
                                                  TextSpan(
                                                      text:  '${element["importoe"]}',
                                                      style: TextStyle(
                                                          fontWeight:
                                                          FontWeight
                                                              .bold, color: ((element["pagata"] as String) == "0")  ? Colors.red : Colors.blue)
                                                  ),
                                                ],
                                              ),
                                            ),

                                            RichText(
                                              text: TextSpan(
                                                style: const TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.black,
                                                ),
                                                children: <TextSpan>[


                                                  TextSpan(
                                                      text:
                                                      'Scade il '),
                                                  TextSpan(text: '${element["datascadenza"].substring(0, element["datascadenza"].indexOf("00:")).toString()}',style: const TextStyle(
                                                      fontWeight:
                                                      FontWeight
                                                          .bold)),

                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        trailing: IconButton(
                                          icon: Icon(
                                              Icons.info_outline),
                                          onPressed: () {/*

                                            Navigator.of(context)
                                                .push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DocuPage(
                                                          agente: widget.agente,
                                                          id_dotes: element[
                                                          "id_dotes"]),
                                                ));*/
                                          },
                                        ),
                                      ),
                                  ],
                                ),
                              ),),
                                  doc.isEmpty
                                      ? Tab(text: 'NESSUN DOCUMENTO INSERITO.')
                                      : Tab(
                                    child: Container(
                                      width: MediaQuery.of(context)
                                          .size
                                          .width,
                                      height: MediaQuery.of(context)
                                          .size
                                          .height,
                                      child: ListView(
                                        children: [
                                          for (var element in doc)
                                            ListTile(
                                              onTap: () {

                                                Navigator.of(context)
                                                    .push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          DocuPage(
                                                              agente: widget.agente,
                                                              id_dotes: element[
                                                              "id_dotes"]
                                                                  .toString()),
                                                    ));
                                              },
                                              leading: Icon(
                                                  Icons.feed_outlined),
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
                                                icon: Icon(
                                                    Icons.info_outline),
                                                onPressed: () {

                                                  Navigator.of(context)
                                                      .push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            DocuPage(
                                                                agente: widget.agente,
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

class MainClientePageClienteCard extends StatefulWidget {
  const MainClientePageClienteCard({
    Key? key,
    required this.cd_cf,
  }) : super(key: key);

  final String? cd_cf;

  @override
  State<MainClientePageClienteCard> createState() =>
      _MainClientePageClienteCardState();
}

class _MainClientePageClienteCardState
    extends State<MainClientePageClienteCard> {
  int _selectedColor = 0;
  int _selectedImageIndex = 0;
  late List cliente;
  bool isLoading = false;

  void _updateColor(int index) {
    setState(() {
      _selectedColor = index;
    });
  }

  @override
  void initState() {
    super.initState();

    refreshCF();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future refreshCF() async {
    setState(() {
      isLoading = true;
    });

    final d1b = await ProvDatabase.instance.database;
    var id = widget.cd_cf;
    cliente = await d1b.rawQuery(
        'SELECT * from cf where  cd_cf  = \'$id\'');

    //print(articolo);

    setState(() {
      isLoading = false;
    });
  }

  final Cliente = _ClientePageState();
  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? const CircularProgressIndicator()
        : Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                height: 150,
                width: double.infinity,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      cliente.isNotEmpty
                      ?Row(
                        children: [
                          Expanded(
                            child: 'Codice Fornitore :'
                                .text
                                .size(16)
                                .semiBold
                                .maxLines(2)
                                .softWrap(false)
                                .make(),
                          ),
                          '${cliente[0]["cd_cf"]}'
                              .text
                              .size(16)
                              .semiBold
                              .maxLines(2)
                              .softWrap(false)
                              .make(),
                        ],
                      ):Text(''),
                      SizedBox(
                        height: 5,
                      ),
                      cliente.isNotEmpty
                          ?Row(
                        children: [
                          Expanded(
                            child: 'Indirizzo :'
                                .text
                                .size(16)
                                .semiBold
                                .maxLines(2)
                                .softWrap(false)
                                .make(),
                          ),
                          '${cliente[0]["indirizzo"]}'
                              .text
                              .size(8)
                              .semiBold
                              .maxLines(2)
                              .softWrap(false)
                              .make(),
                        ],
                      ):Text(''),
                      SizedBox(
                        height: 5,
                      ),
                      cliente.isNotEmpty
                          ?Row(
                        children: [
                          Expanded(
                            child: 'Localita :'
                                .text
                                .size(16)
                                .semiBold
                                .maxLines(2)
                                .softWrap(false)
                                .make(),
                          ),
                          '${cliente[0]["localita"]} (${cliente[0]["cd_provincia"]})  - ${cliente[0]["cd_nazione"]}'
                              .text
                              .size(8)
                              .semiBold
                              .maxLines(2)
                              .softWrap(false)
                              .make(),
                        ],
                      ):Text(''),
                      SizedBox(
                        height: 5,
                      ),
                      cliente.isNotEmpty
                          ?Row(
                        children: [
                          Expanded(
                            child: 'Cap :'
                                .text
                                .size(16)
                                .semiBold
                                .maxLines(2)
                                .softWrap(false)
                                .make(),
                          ),
                          '${cliente[0]["cap"]}'
                              .text
                              .size(8)
                              .semiBold
                              .maxLines(2)
                              .softWrap(false)
                              .make(),
                        ],
                      ):Text(''),
                      SizedBox(
                        height: 5,
                      ),
                      cliente.isNotEmpty
                          ?Row(
                        children: [
                          Expanded(
                            child: 'Email :'
                                .text
                                .size(16)
                                .semiBold
                                .maxLines(2)
                                .softWrap(false)
                                .make(),
                          ),
                          '${cliente[0]["mail"]}'
                              .text
                              .size(8)
                              .semiBold
                              .maxLines(2)
                              .softWrap(false)
                              .make(),
                        ],
                      ):Text(''),
                      SizedBox(
                        height: 5,
                      ),
                      cliente.isNotEmpty
                          ?Row(
                        children: [
                          Expanded(
                            child: 'Agente 1 :'
                                .text
                                .size(16)
                                .semiBold
                                .maxLines(2)
                                .softWrap(false)
                                .make(),
                          ),
                          '${cliente[0]["cd_agente_1"]}'
                              .text
                              .size(8)
                              .semiBold
                              .maxLines(2)
                              .softWrap(false)
                              .make(),
                        ],
                      ):Text(''),
                      SizedBox(
                        height: 5,
                      ),
                      cliente.isNotEmpty
                          ?Row(
                        children: [
                          Expanded(
                            child: 'Agente 2 :'
                                .text
                                .size(16)
                                .semiBold
                                .maxLines(2)
                                .softWrap(false)
                                .make(),
                          ),
                          '${cliente[0]["cd_agente_2"]}'
                              .text
                              .size(8)
                              .semiBold
                              .maxLines(2)
                              .softWrap(false)
                              .make(),
                        ],
                      ):Text(''),
                      SizedBox(
                        height: 5,
                      ),
                      cliente.isNotEmpty
                          ?Row(
                        children: [
                          Expanded(
                            child: 'Descrizione :'
                                .text
                                .size(16)
                                .semiBold
                                .maxLines(2)
                                .softWrap(false)
                                .make(),
                          ),
                          Text(cliente[0]['descrizione'])
                              .text
                              .size(8)
                              .semiBold
                              .maxLines(2)
                              .softWrap(false)
                              .make(),
                        ],
                      ):Text(''),
                    ],
                  )
                ],
              ),
            ],
          );
  }
}
/*
class BagButton extends StatelessWidget {
  const BagButton({Key? key, this.numberOfItemsPurchased = 0})
      : super(key: key);
  final int? numberOfItemsPurchased;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        IconButton(
          icon: Image.asset(
            'assets/shopping_bag.png',
          ),
          onPressed: () {},
        ),
        if (numberOfItemsPurchased != 0)
          Container(
            margin: const EdgeInsets.only(right: 4, top: 8),
            height: 20,
            width: 20,
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.circle,
                border: Border.all(width: 1.5, color: Colors.white)),
            child:
                numberOfItemsPurchased.toString().text.sm.makeCentered().p(2),
          ),
      ],
    );
  }
}*/
/*

class ColorSelector extends StatelessWidget {
  const ColorSelector(
      {Key? key,
      required this.colors,
      required this.updateContainerColor,
      required this.selectedIndex})
      : super(key: key);
  final List<Color> colors;
  final Function(int v) updateContainerColor;
  final int selectedIndex;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SizedBox(
        height: 60,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: colors.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                updateContainerColor(index);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                    color: (selectedIndex == index)
                        ? Colors.lightBlue
                        : Colors.transparent,
                    shape: BoxShape.circle),
                child: Center(
                  child: Container(
                    width: 33,
                    height: 33,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colors[index],
                        border: Border.all(width: 1.5, color: Colors.white)),
                  ),
                ).p(1),
              ).pOnly(right: 3),
            );
          },
        ),
      ),
    );
  }
}*/
