import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:imi/model/cart.dart';
import 'package:imi/page/dettaglio.dart';
import 'package:imi/page/home.dart';
import 'package:imi/page/table.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';

import '../db/databases.dart';

class OrdiniPage extends StatefulWidget {
  static const String id = '/OrdiniPage';

  @override
  State<OrdiniPage> createState() => _OrdiniPageState();
}

class _OrdiniPageState extends State<OrdiniPage> {
  int _quantity = 1;
  late List cart = [];
  bool isLoading = true;
  late Timer timer;

  @override
  void initState() {
    super.initState();

    refreshCart();

    //_prezzototale();
    /* if (mounted) {
      timer = Timer.periodic(
          const Duration(seconds: 1), (Timer t) => _prezzototale());
    }*/
  }

  /*Future _prezzototale() async {
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
  }*/
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

  Future refreshCart() async {
    setState(() {
      isLoading = true;
    });

    final d1b = await ProvDatabase.instance.database;
    cart = await d1b.rawQuery(
        'SELECT cart.*, ar.immagine from cart left join ar on cart.cd_ar = ar.cd_ar WHERE cart.stato == \'send\'');
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
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
                'Ordini da Sincronizzare',
                style: const TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.lightBlue,
              actions: [
                GestureDetector(
                  child: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ));
                  },
                ),
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
                          16.heightBox,
                          16.heightBox,
                          16.heightBox,
                          MainOrdiniPageCartCard().px(8),
                          16.heightBox,
                          16.heightBox,
                          16.heightBox,
                          /*Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  'Descrizione'.text.semiBold.lg.make(),
                  //  const RatingWidget(rating: 4)
                ],
              ).px(24),
              //widget.Cart.description.text.lg.make().py(12).px(24),
              Text('articolo[0]["descrizione"]'),*/
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  /*children: [
                       
                        SizedBox(
                          width: 35,
                          child: IconButton(
                              padding: const EdgeInsets.all(0),
                              onPressed: () {
                                /*
                                setState(() {
                                  if (_quantity > 1) _quantity -= 1;
                                  refreshAR();
                                });*/
                              },
                              icon: const Icon(
                                CupertinoIcons.minus_circle,
                                size: 22,
                              )),
                        ),
                        /*
                        _quantity.text.xl.semiBold.make(),*/
                        SizedBox(
                          width: 35,
                          child: IconButton(
                              padding: const EdgeInsets.all(0),
                              onPressed: () {
                                /*
                                setState(() {
                                  _quantity += 1;
                                  refreshAR();
                                });*/
                              },
                              icon: const Icon(
                                CupertinoIcons.plus_circle,
                                size: 22,
                              )),
                        ),
                        const Spacer(), 
                        'Totale: ${prezzototale} €'.text.xl.make(),*/
                                  //inserire il prezzo
                                  /*'\$${widget.Cart.price * _quantity}'
                            .text
                            .semiBold
                            .xl
                            .make(),
                      ],*/
                                ).px(8),
                                // 24.heightBox,
                                PrimaryShadowedButton(
                                    child: 'Sincronizza Ordine'
                                        .text
                                        .xl2
                                        .white
                                        .makeCentered()
                                        .py(16),
                                    onPressed: () async {
                                      bool internet =
                                          await InternetConnectionChecker()
                                              .hasConnection;
                                      if (internet) {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        await ProvDatabase.instance
                                            .readAllCartFilter()
                                            .then((value) async {
                                          if (value.isNotEmpty) {
                                            for (int i = 0;
                                                i < value.length;
                                                i++) {
                                              await sendCart(value[i]);

                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    content: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              1.3,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              4,
                                                      decoration:
                                                          new BoxDecoration(
                                                        shape:
                                                            BoxShape.rectangle,
                                                        color: const Color(
                                                            0xFFFFFF),
                                                        borderRadius:
                                                            new BorderRadius
                                                                .all(new Radius
                                                                    .circular(
                                                                32.0)),
                                                      ),
                                                      // ignore: unnecessary_new
                                                      child: new Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Icon(
                                                            Icons.verified,
                                                            color: Colors.green,
                                                            size: 32,
                                                          ),
                                                          Text('Complimenti!'),
                                                          Text(
                                                            'Tutte le righe sono state sincronizzate!',
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          MaterialButton(
                                                              onPressed:
                                                                  () async {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                refreshCart();
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
                                                                    EdgeInsets
                                                                        .all(
                                                                            15.0),
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
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                              print(
                                                  'Inserito correttamente riga $i');
                                            }
                                          } else {
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
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.3,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            4,
                                                    decoration:
                                                        new BoxDecoration(
                                                      shape: BoxShape.rectangle,
                                                      color:
                                                          const Color(0xFFFFFF),
                                                      borderRadius:
                                                          new BorderRadius.all(
                                                              new Radius
                                                                      .circular(
                                                                  32.0)),
                                                    ),
                                                    // ignore: unnecessary_new
                                                    child: new Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Text('Errore!'),
                                                        Text(
                                                          'Nessuna riga è presente nel carrello!',
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        MaterialButton(
                                                            onPressed:
                                                                () async {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              refreshCart();
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
                                                                  EdgeInsets
                                                                      .all(
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
                                                  ),
                                                );
                                              },
                                            );
                                          }
                                          await ProvDatabase.instance
                                              .deleteallCart();
                                        });
                                        refreshCart();
                                        setState(() {
                                          isLoading = true;
                                        });
                                      } else {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Dialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 24,
                                                      vertical: 30),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      const Text("Errore!",
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          )),
                                                      const Text(
                                                          "Non sei connesso ad Internet.",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          )),
                                                      const SizedBox(
                                                        height: 16,
                                                      ),
                                                      MaterialButton(
                                                        onPressed: () async {
                                                          setState(() {});
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                            "Riprova"),
                                                        color: Color.fromARGB(
                                                            174, 140, 235, 123),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                        minWidth:
                                                            double.infinity,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                      }
                                    },
                                    borderRadius: 16,
                                    color: Colors.lightBlue)
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

class FavouriteButton extends StatelessWidget {
  const FavouriteButton(
      {Key? key,
      required this.iconSize,
      required this.onPressed,
      required this.isClicked})
      : super(key: key);

  final String isClicked;
  final double iconSize;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(80))),
          backgroundColor: MaterialStateProperty.all(
              (isClicked == 'true') ? Colors.green : Colors.grey),
          elevation: MaterialStateProperty.all(4),
          shadowColor: MaterialStateProperty.all(Colors.green)),
      child: Center(
        child: Icon(
          Icons.circle,
          size: iconSize,
          color: (isClicked == 'true') ? Colors.green : Colors.grey,
        ),
      ),
      onPressed: onPressed,
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
              colors: [Colors.lightBlueAccent, Colors.lightBlue],
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

class MainOrdiniPageCartCard extends StatefulWidget {
  @override
  State<MainOrdiniPageCartCard> createState() => _MainOrdiniPageCartCardState();
}

class _MainOrdiniPageCartCardState extends State<MainOrdiniPageCartCard> {
  int _quantity = 1;
  late List cart = [];
  bool isLoading = true;
  late Timer timer;
  late List immagine = [];
  bool isClicked_form = false;

  late bool internet;

  @override
  void initState() {
    super.initState();

    refreshCart();
  }

  Future refreshCart() async {
    setState(() {
      isLoading = true;
    });

    internet = await InternetConnectionChecker().hasConnection;

    final d1b = await ProvDatabase.instance.database;
    cart = await d1b.rawQuery(
        'SELECT cart.*, ar.immagine from cart left join ar on cart.cd_ar = ar.cd_ar WHERE cart.stato == \'send\'');

    setState(() {
      isLoading = false;
    });
  }

  int _selectedColor = 0;
  int _selectedImageIndex = 0;
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomCenter, children: [
      AspectRatio(
          aspectRatio: 0.75,
          child: Container(
            child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                shrinkWrap: true,
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  //selectAR('${cart[index]["cd_ar"]}');
                  return Card(
                    color: Colors.lightBlue,
                    elevation: 5.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          /*Container(
                            width: 30,
                            height: 30,
                            child: FavouriteButton(
                              isClicked: cart[index]["stato"],
                              iconSize: 12,
                              onPressed: () async {
                                final d1b =
                                    await ProvDatabase.instance.database;
                                if (cart[index]["stato"] == 'true')
                                  await d1b.rawUpdate('''
                                  UPDATE cart 
                                  SET stato = ? 
                                  WHERE id = ?
                                  ''', ['false', cart[index]["id"]]);
                                else
                                  await d1b.rawUpdate('''
                                  UPDATE cart 
                                  SET stato = ? 
                                  WHERE id = ?
                                  ''', ['true', cart[index]["id"]]);
                                refreshCart();
                                setState(() {});
                              },
                            ),
                          ),*/
                          cart[index]['immagine'] != 'null'
                              ? internet
                                  ? Image.network(
                                      cart[index]["immagine"].toString(),
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.fill,
                                    )
                                  : Image.asset(
                                      'assets/nophoto.jpg',
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.fill,
                                    )
                              : Image.asset(
                                  'assets/nophoto.jpg',
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.fill,
                                ),
                          SizedBox(
                            width: 130,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 5.0,
                                ),
                                RichText(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  text: TextSpan(
                                      text: 'Cd_AR: ',
                                      style: TextStyle(
                                          color: Colors.blueGrey.shade800,
                                          fontSize: 15.0),
                                      children: [
                                        TextSpan(
                                            text: '${cart[index]["cd_ar"]}',
                                            //'${products[index].name.toString()}\n',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ]),
                                ),
                                RichText(
                                  maxLines: 1,
                                  text: TextSpan(
                                      text: 'Quantità: ',
                                      style: TextStyle(
                                          color: Colors.blueGrey.shade800,
                                          fontSize: 15.0),
                                      children: [
                                        TextSpan(
                                            text: '${cart[index]["qta"]}',
                                            // '${products[index].unit.toString()}\n',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ]),
                                ),
                                RichText(
                                  maxLines: 1,
                                  text: TextSpan(
                                      text: 'Prezzo: ',
                                      style: TextStyle(
                                          color: Colors.blueGrey.shade800,
                                          fontSize: 15.0),
                                      children: [
                                        TextSpan(
                                            text:
                                                '${cart[index]["prezzo_unitario"]}'
                                                "€",
                                            //'${products[index].price.toString()}\n',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ]),
                                ),
                                RichText(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  text: TextSpan(
                                      text: 'Cd_CF: ',
                                      style: TextStyle(
                                          color: Colors.blueGrey.shade800,
                                          fontSize: 15.0),
                                      children: [
                                        TextSpan(
                                            text: '${cart[index]["cd_cf"]}',
                                            //'${products[index].name.toString()}\n',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ]),
                                ),
                              ],
                            ),
                          ), /*
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              ProvDatabase.instance
                                  .deleteCart(cart[index]["id"]);
                              refreshCart();
                            },
                          ),*/
                        ],
                      ),
                    ),
                  );
                }),
          ))
    ]);
  }
}
