import 'dart:async';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:imi/page/home.dart';
import 'package:velocity_x/velocity_x.dart';

import '../db/databases.dart';
import 'cart.dart';

String prezzo = '1.00';
String prezzototale = '0.00';
bool isLoading = false;
String cd_ar = '';

class ProductPage extends StatefulWidget {
  static const String id = '/ProductPage';

  final String image;
  // ignore: use_key_in_widget_constructors
  const ProductPage({required this.image, required this.prod, this.cd_cf
      //required this.product,
      });
  final int prod;
  final String? cd_cf;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int _quantita = 1;
  int _confezioni = 1;
  List articolo = [];
  bool isLoading = true;
  late Timer timer;
  late String xstato;

  @override
  void initState() {
    super.initState();

    refreshAR();

    calcolaprezzo();

    //_prezzototale();

    if (mounted) {
      timer = Timer.periodic(
          const Duration(seconds: 1), (Timer t) => _prezzototale());
    }
  }

  Future calcolaprezzo() async {
    setState(() {
      isLoading = true;
    });

    final d1b = await ProvDatabase.instance.database;

    List cd_ar2 = await d1b.rawQuery(
        'SELECT * from ar where id_ditta = \'8\' and id  =  ${widget.prod}');

    String cd_ar1 = cd_ar2[0]["cd_ar"];

    List check = await d1b.rawQuery(
        'SELECT * FROM dorig WHERE id_ditta = \'8\' AND cd_cf = \'${widget.cd_cf}\' AND cd_ar = \'${cd_ar1}\' order by id DESC LIMIT 1');

    if (check.isEmpty) {
      /*
      check = await d1b.rawQuery(
          "SELECT * FROM dorig WHERE id_ditta = '7' AND cd_cf like 'C%' AND cd_ar = '${cd_ar1}' order by id DESC LIMIT 1");
      List forn = await d1b.query("cf",
          where: "id_ditta = '7' AND cd_cf like ?", whereArgs: ['C%']);

      print(forn.length);*/

      /*check = await d1b.query("dorig",
          where: "id_ditta = '7' AND cd_ar = ?",
          whereArgs: ['${cd_ar1}'],
          orderBy: "id Desc",
          limit: 1);*/

      check = await d1b.rawQuery(
          "SELECT * FROM dorig WHERE id_ditta = '7' AND cd_cf like 'C%' AND cd_ar = '${cd_ar1}'  order by id DESC LIMIT 1");
    }

    if (check.isEmpty) {
      prezzo = '1';
    } else {
      prezzo = check[0]["prezzounitariov"];
    }

    setState(() {
      isLoading = false;
    });
  }

  Future _prezzototale() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    prezzototale = ((_quantita).toDouble() * double.parse(prezzo)).toString();

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future refreshAR() async {
    setState(() {
      isLoading = true;
    });

    //prezzototale = (_quantita.toDouble() * double.parse(prezzo)).toString();

    final d1b = await ProvDatabase.instance.database;

    var id = widget.prod;

    articolo = await d1b
        .rawQuery('SELECT * from ar where id_ditta = \'8\' and id  = $id');

    cd_ar = articolo[0]["cd_ar"];

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return isLoading
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
                articolo[0]["cd_ar"],
                style: const TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.lightBlue,
              actions: [
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
                ),
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
                : Container(
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
                          (articolo[0] == null)
                              ? const CircularProgressIndicator.adaptive()
                              : MainProductPageProductCard(
                                  image: widget.image,
                                  prod: articolo[0]['id'],
                                ).px(24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              'Descrizione'.text.semiBold.lg.make(),
                              //  const RatingWidget(rating: 4)
                            ],
                          ).px(24),
                          //widget.product.description.text.lg.make().py(12).px(24),
                          SizedBox(
                            height: 10,
                          ),
                          Text(articolo[0]['descrizione']),
                          16.heightBox,
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(32),
                                topRight: Radius.circular(32),
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 35,
                                      child: IconButton(
                                          padding: const EdgeInsets.all(0),
                                          onPressed: () {
                                            setState(() {
                                              if (_quantita > 1) _quantita -= 1;
                                              refreshAR();
                                              if (mounted) {
                                                _prezzototale();
                                              }
                                            });
                                          },
                                          icon: const Icon(
                                            CupertinoIcons.minus_circle,
                                            size: 22,
                                          )),
                                    ),
                                    TextButton(
                                      //padding: const EdgeInsets.all(0),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            String? quantita;

                                            return AlertDialog(
                                              content: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1.3,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    4,
                                                decoration: new BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  color: const Color(0xFFFFFF),
                                                  borderRadius:
                                                      new BorderRadius.all(
                                                          new Radius.circular(
                                                              32.0)),
                                                ),
                                                // ignore: unnecessary_new
                                                child: new Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    const Text(
                                                      'Inserisci i quantita desiderati.',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18.0,
                                                        fontFamily:
                                                            'helvetica_neue_light',
                                                      ),
                                                    ),
                                                    TextFormField(
                                                      validator: (value) => (value
                                                                  ?.length) !=
                                                              0
                                                          ? null
                                                          : "Inserire un numero",
                                                      onChanged: (val) {
                                                        quantita =
                                                            val.toString();
                                                      },
                                                      keyboardType:
                                                          TextInputType.number,
                                                      autofocus: true,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            'Inserisci i quantita desiderati ',
                                                        labelText: 'Quantita\'',
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
                                                          if (quantita != null)
                                                            _quantita = int
                                                                .parse(quantita
                                                                    .toString());
                                                          Navigator.of(context)
                                                              .pop();
                                                          refreshAR();
                                                          if (mounted) {
                                                            _prezzototale();
                                                          }
                                                        },
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              12,
                                                          padding:
                                                              EdgeInsets.all(
                                                                  15.0),
                                                          child: Material(
                                                              color:
                                                                  Colors.green,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25.0),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: <
                                                                    Widget>[
                                                                  Text(
                                                                    'Ok',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          18.0,
                                                                      fontFamily:
                                                                          'helvetica_neue_light',
                                                                    ),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
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
                                        setState(() {
                                          refreshAR();
                                        });
                                      },
                                      child: Text(
                                        _quantita.toString(),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 35,
                                      child: IconButton(
                                          padding: const EdgeInsets.all(0),
                                          onPressed: () {
                                            setState(() {
                                              _quantita += 1;
                                              refreshAR();
                                              if (mounted) {
                                                _prezzototale();
                                              }
                                            });
                                          },
                                          icon: const Icon(
                                            CupertinoIcons.plus_circle,
                                            size: 22,
                                          )),
                                    ),
                                    const Text('QUANTITA\''),
                                  ],
                                ),
                                6.heightBox,
                                Row(children: [
                                  const Spacer(),
                                  'Totale: ${prezzototale} €'
                                      .text
                                      .xl
                                      .bold
                                      .make(),
                                ]),
                                6.heightBox,
                                PrimaryShadowedButton(
                                    child: 'Aggiungi al Carrello'
                                        .text
                                        .xl2
                                        .white
                                        .makeCentered()
                                        .py(16),
                                    onPressed: () async {
                                      final d1b =
                                          await ProvDatabase.instance.database;

                                      List controllo = await d1b.rawQuery(
                                          "SELECT * FROM mggiac where cd_ar = '${cd_ar}' ",
                                          null);

                                      xstato = '0';

                                      for (int i = 0;
                                          i < controllo.length;
                                          i++) {
                                        if (double.parse(controllo[i]
                                                    ['disponibile']
                                                .toString()) >=
                                            double.parse(
                                                _quantita.toString())) {
                                          xstato = 'send';
                                        }
                                      }
                                      if (widget.cd_cf != null) {
                                        await ProvDatabase.instance
                                            .addCart(
                                                widget.cd_cf.toString(),
                                                cd_ar.toString(),
                                                _quantita.toString(),
                                                "null".toString(),
                                                "null".toString(),
                                                "null".toString(),
                                                "null".toString(),
                                                "null".toString(),
                                                prezzo.toString(),
                                                "null".toString(),
                                                "null".toString(),
                                                "null".toString(),
                                                "null".toString(),
                                                "null".toString(),
                                                "null".toString(),
                                                "null".toString(),
                                                xstato.toString())
                                            .then((value) {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              var articolo;
                                              var quantita;
                                              var cliente;

                                              TextEditingController
                                                  articoloController =
                                                  TextEditingController();
                                              TextEditingController
                                                  quantitaController =
                                                  TextEditingController();
                                              TextEditingController
                                                  clienteController =
                                                  TextEditingController();

                                              return AlertDialog(
                                                content: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.3,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      4,
                                                  decoration: new BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    color:
                                                        const Color(0xFFFFFF),
                                                    borderRadius:
                                                        new BorderRadius.all(
                                                            new Radius.circular(
                                                                32.0)),
                                                  ),
                                                  // ignore: unnecessary_new
                                                  child: new Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      GestureDetector(
                                                        child: Icon(
                                                          Icons.verified,
                                                          color: Colors.green,
                                                          size: 32,
                                                        ),
                                                        onTap: () {},
                                                      ),
                                                      Text(
                                                        'Complimenti!',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 20.0,
                                                          fontFamily:
                                                              'helvetica_neue_light',
                                                        ),
                                                      ),
                                                      Text(
                                                        'L\' articolo è stato correttamente inserito nel carrello!',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18.0,
                                                          fontFamily:
                                                              'helvetica_neue_light',
                                                        ),
                                                      ),
                                                      MaterialButton(
                                                          onPressed: () async {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            refreshAR();
                                                          },
                                                          child: Container(
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                12,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    15.0),
                                                            child: Material(
                                                                color: Colors
                                                                    .green,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            25.0),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: <
                                                                      Widget>[
                                                                    Text(
                                                                      'Ok',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            18.0,
                                                                        fontFamily:
                                                                            'helvetica_neue_light',
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
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
                                        });
                                      } else {
                                        return showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              content: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1.3,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    3,
                                                decoration: new BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  color: const Color(0xFFFFFF),
                                                  borderRadius:
                                                      new BorderRadius.all(
                                                          new Radius.circular(
                                                              32.0)),
                                                ),
                                                // ignore: unnecessary_new
                                                child: new Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    GestureDetector(
                                                      child: Icon(
                                                        Icons.verified,
                                                        color: Colors.green,
                                                        size: 32,
                                                      ),
                                                      onTap: () {},
                                                    ),
                                                    Text(
                                                      'Errore!',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20.0,
                                                        fontFamily:
                                                            'helvetica_neue_light',
                                                      ),
                                                    ),
                                                    Text(
                                                      'Nessun Cliente selezionato.',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18.0,
                                                        fontFamily:
                                                            'helvetica_neue_light',
                                                      ),
                                                    ),
                                                    Text(
                                                      'Vuoi che ti riporti alla scelta cliente ? ',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18.0,
                                                        fontFamily:
                                                            'helvetica_neue_light',
                                                      ),
                                                    ),
                                                    new Container(
                                                      child: Row(
                                                        children: <Widget>[
                                                          MaterialButton(
                                                              onPressed:
                                                                  () async {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              HomePage(),
                                                                    ));
                                                              },
                                                              child: Container(
                                                                width: 100,
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height /
                                                                    12,
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            5.0),
                                                                child: Material(
                                                                    color: Colors
                                                                        .green,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            25.0),
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: <
                                                                          Widget>[
                                                                        Text(
                                                                          'Ok',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize:
                                                                                18.0,
                                                                            fontFamily:
                                                                                'helvetica_neue_light',
                                                                          ),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        ),
                                                                      ],
                                                                    )),
                                                              )),
                                                          MaterialButton(
                                                              onPressed:
                                                                  () async {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Container(
                                                                width: 100,
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height /
                                                                    12,
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            5.0),
                                                                child: Material(
                                                                    color: Colors
                                                                        .red,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            25.0),
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: <
                                                                          Widget>[
                                                                        Text(
                                                                          'No',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize:
                                                                                18.0,
                                                                            fontFamily:
                                                                                'helvetica_neue_light',
                                                                          ),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        ),
                                                                      ],
                                                                    )),
                                                              )),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    },
                                    borderRadius: 16,
                                    color: Colors.black)
                              ],
                            ),
                          ),
                        ],
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
              colors: [Colors.lightBlue, Colors.lightBlue],
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

class MainProductPageProductCard extends StatefulWidget {
  final String image;

  const MainProductPageProductCard({
    Key? key,
    required this.image,
    required this.prod,
    this.cd_cf,
  }) : super(key: key);

  final int prod;
  final String? cd_cf;

  @override
  State<MainProductPageProductCard> createState() =>
      _MainProductPageProductCardState();
}

class _MainProductPageProductCardState
    extends State<MainProductPageProductCard> {
  int _selectedColor = 0;
  int _selectedImageIndex = 0;
  List articolo = [];
  List url = [];
  bool isLoading = false;

  late List colonne;
  late List righe;
  bool internet = false;

  void _updateColor(int index) {
    setState(() {
      _selectedColor = index;
    });
  }

  @override
  void initState() {
    super.initState();

    refreshAR();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future refreshAR() async {
    setState(() {
      isLoading = true;
    });

    final d1b = await ProvDatabase.instance.database;
    var id = widget.prod;
    articolo = await d1b
        .rawQuery('SELECT * from ar where id_ditta = \'8\' and id  = $id');

    //print(articolo);
    internet = await InternetConnectionChecker().hasConnection;

    colonne = await d1b.rawQuery("PRAGMA table_info(mggiac)", null);
    righe = await d1b.rawQuery(
        "SELECT * FROM mggiac where cd_ar = '${articolo[0]["cd_ar"]}'", null);

    setState(() {
      isLoading = false;
    });
  }

  final product = _ProductPageState();
  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    isLoading = false;

    return isLoading
        ? const CircularProgressIndicator()
        : articolo.isEmpty
            ? const CircularProgressIndicator()
            : Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  AspectRatio(
                    aspectRatio: 0.75,
                    child: Container(
                        padding: const EdgeInsets.only(
                            left: 12, right: 12, bottom: 12),
                        margin: const EdgeInsets.only(top: 110, bottom: 16),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.22),
                                  offset: const Offset(0, 16),
                                  spreadRadius: 1.5,
                                  blurRadius: 32),
                            ]),
                        child: Container(
                          width: double.infinity,
                        )),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(24)),
                        // margin: const EdgeInsets.only(
                        //     left: 25, right: 25, top: 24, bottom: 32),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            SizedBox(
                              height: 220,
                              child: PageView.builder(
                                itemCount:
                                    1, //widget.product.productImages.length,
                                onPageChanged: (newIndex) => setState(() {
                                  _selectedImageIndex = newIndex;
                                }),
                                itemBuilder: (context, index) => AspectRatio(
                                  aspectRatio: 1,
                                  child: articolo[0]["immagine"] != 'null'
                                      ? internet
                                          ? Image.network(
                                              widget.image,
                                              width: 60,
                                              height: 50,
                                              fit: BoxFit.fill,
                                            ).p(24)
                                          : Image.asset(
                                              'assets/nophoto.jpg',
                                              width: 60,
                                              height: 50,
                                              fit: BoxFit.fill,
                                            ).p(24)
                                      : Image.asset(
                                          'assets/nophoto.jpg',
                                          width: 120,
                                          height: 100,
                                          fit: BoxFit.fill,
                                        ).p(24),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ).p(24),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              '${articolo[0]["cd_ar"]}'
                                  .text
                                  .size(18)
                                  .semiBold
                                  .maxLines(2)
                                  .softWrap(false)
                                  .make(),

                              //  Text('Disponibilità:'),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                            child: Text(''),
                          ),
                          articolo[0]["dms"] != 'null'
                              ? SizedBox(
                                  height: 40,
                                  width: 120,
                                  child: PrimaryShadowedButton(
                                    onPressed: () async {
                                      if (await canLaunch(
                                          articolo[0]["dms"].toString())) {
                                        await launch(
                                            articolo[0]["dms"].toString());
                                      } else {
                                        throw 'Could not launch ${articolo[0]["dms"]}';
                                      }
                                    },
                                    child: 'Allegato'.text.white.makeCentered(),
                                    borderRadius: 12,
                                    color: Colors.black,
                                  ),
                                )
                              : SizedBox(
                                  height: 40,
                                  width: 120,
                                ),
                          SizedBox(
                            height: 20,
                            child: Text(''),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 0.5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 40,
                                    width: 120,
                                    child: PrimaryShadowedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            String? quantita;

                                            final screenWidth =
                                                MediaQuery.of(context)
                                                    .size
                                                    .width;
                                            return AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    12.0,
                                                  ),
                                                ),
                                                backgroundColor:
                                                    Colors.lightBlue,
                                                content: SafeArea(
                                                  child: (Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.rectangle,
                                                      color: Color(0xFFFFFF),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12.0)),
                                                    ),
                                                    child:
                                                        SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      child: Container(
                                                        /* height:
                                                        (MediaQuery.of(context)
                                                                .size
                                                                .height) /
                                                            3,*/
                                                        color: Colors.grey,
                                                        /*padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 2, 0, 2),*/
                                                        width: screenWidth,
                                                        child: DataTable(
                                                            headingRowColor:
                                                                MaterialStateColor
                                                                    .resolveWith(
                                                                        (states) => Colors
                                                                            .lightBlue),
                                                            border: TableBorder
                                                                .symmetric(
                                                              outside:
                                                                  BorderSide(
                                                                      width: 1),
                                                              inside:
                                                                  BorderSide(
                                                                      width: 1),
                                                            ),
                                                            dataRowColor:
                                                                MaterialStateProperty
                                                                    .all(Colors
                                                                        .white),
                                                            columns: [
                                                              for (var element
                                                                  in colonne)
                                                                if (element[
                                                                        "name"] !=
                                                                    'id')
                                                                  if (element[
                                                                          "name"] !=
                                                                      'id_ditta')
                                                                    if (element[
                                                                            "name"] !=
                                                                        'cd_ar')
                                                                      if (element[
                                                                              "name"] !=
                                                                          'giacenza')
                                                                        DataColumn(
                                                                            label:
                                                                                Text(
                                                                          (element["name"].toString() == 'cd_mg')
                                                                              ? 'Magazzino'
                                                                              : 'Disponibile',
                                                                          style:
                                                                              TextStyle(color: Colors.black),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        )),
                                                            ],
                                                            rows: [
                                                              for (var element
                                                                  in righe)
                                                                DataRow(cells: [
                                                                  for (var i =
                                                                          0;
                                                                      i <
                                                                          colonne
                                                                              .length;
                                                                      i++)
                                                                    if (colonne[i]
                                                                            [
                                                                            "name"] !=
                                                                        'id')
                                                                      if (colonne[i]
                                                                              [
                                                                              "name"] !=
                                                                          'id_ditta')
                                                                        if (colonne[i]["name"] !=
                                                                            'cd_ar')
                                                                          if (colonne[i]["name"] !=
                                                                              'giacenza')
                                                                            DataCell(
                                                                              Text(
                                                                                element[colonne[i]["name"]].toString(),
                                                                                style: TextStyle(color: Colors.black),
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                            ),
                                                                ]),
                                                            ]),
                                                      ),
                                                    ),
                                                  )),
                                                ));
                                          },
                                        );
                                      },
                                      child: 'DISPONIBILITA\''
                                          .text
                                          .white
                                          .makeCentered(),
                                      borderRadius: 12,
                                      color: Colors.black,
                                    )),
                                SizedBox(
                                  height: 40,
                                  width: 20,
                                ),
                                'Prezzo : '.text.black.bold.make(),
                                SizedBox(
                                  height: 40,
                                  width: 90,
                                  child: PrimaryShadowedButton(
                                    onPressed: () {
                                      return showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          String? prezzov;

                                          return AlertDialog(
                                            content: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.3,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  4,
                                              decoration: new BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                color: const Color(0xFFFFFF),
                                                borderRadius: new BorderRadius
                                                        .all(
                                                    new Radius.circular(32.0)),
                                              ),
                                              // ignore: unnecessary_new
                                              child: new Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    'Si prega di inserire il prezzo unitario dell\'articolo selezionato.',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  TextFormField(
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
                                                    ],
                                                    keyboardType: TextInputType
                                                        .numberWithOptions(
                                                            decimal: true),
                                                    autofocus: true,
                                                    validator: (value) => (value
                                                                ?.length) !=
                                                            0
                                                        ? null
                                                        : "Inserire un numero valido",
                                                    onChanged: (val) {
                                                      if (val.length != 0)
                                                        prezzov = val;
                                                    },
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          'Inserisci il prezzo dell\'articolo',
                                                      labelText: 'Prezzo',
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
                                                        setState(() {
                                                          if (prezzov != null)
                                                            prezzo = prezzov
                                                                .toString();
                                                          if (mounted) {
                                                            Navigator.pop(
                                                                context);
                                                          }
                                                        });
                                                        /*
                                            print('Articolo : ' +
                                                articoloController.text
                                                    .toString() +
                                                ' - Quantita : ' +
                                                quantitaController.text
                                                    .toString() +
                                                ' - Cliente : ' +
                                                clienteController.text
                                                    .toString());
                                            await ProvDatabase.instance.addCart(
                                                clienteController.text
                                                    .toString(),
                                                articoloController.text
                                                    .toString(),
                                                quantitaController.text
                                                    .toString(),
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
                                                "null".toString());

                                            Navigator.of(context).pop();
                                            refreshAR();*/
                                                      },
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            12,
                                                        padding: EdgeInsets.all(
                                                            15.0),
                                                        child: Material(
                                                            color: Colors.green,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25.0),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  'Inserisci',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        18.0,
                                                                    fontFamily:
                                                                        'helvetica_neue_light',
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                    },
                                    child: '${double.parse(prezzo)}'
                                        .text
                                        .white
                                        .makeCentered(),
                                    borderRadius: 12,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (articolo[0]["xcd_xcalibro"] != 'null')
                                'Calibro:'.text.gray500.make(),
                              6.widthBox,
                              if (articolo[0]["xcd_xcalibro"] != 'null')
                                SizedBox(
                                  height: 32,
                                  width: 90,
                                  child: PrimaryShadowedButton(
                                    child: '${articolo[0]["xcd_xcalibro"]}'
                                        .text
                                        .white
                                        .semiBold
                                        .makeCentered(),
                                    borderRadius: 500,
                                    color: Colors.lightBlue,
                                    onPressed: () {},
                                  ),
                                ),
                              SizedBox(
                                height: 42,
                                width: 5,
                              ),
                              if (articolo[0]["xcd_xvarieta"] != 'null')
                                'Varietà:'.text.gray500.make(),
                              6.widthBox,
                              if (articolo[0]["xcd_xvarieta"] != 'null')
                                SizedBox(
                                  height: 32,
                                  width: 90,
                                  child: PrimaryShadowedButton(
                                    child: '${articolo[0]["xcd_xvarieta"]}'
                                        .text
                                        .white
                                        .semiBold
                                        .makeCentered(),
                                    borderRadius: 500,
                                    color: Colors.lightBlue,
                                    onPressed: () {},
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ).px(24).pOnly(bottom: 24)
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
