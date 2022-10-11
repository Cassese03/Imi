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

class CartPage extends StatefulWidget {
  static const String id = '/CartPage';

  const CartPage({this.cd_cf, required this.agente});
  final String? agente;
  final String? cd_cf;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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

  Future refreshCart() async {
    setState(() {
      isLoading = true;
    });

    final d1b = await ProvDatabase.instance.database;

    if (widget.cd_cf == null)
      cart = await d1b.rawQuery(
          'SELECT DISTINCT cart.*, ar.immagine from cart left join ar on cart.cd_ar = ar.cd_ar WHERE cart.stato != \'send\'');
    else
      cart = await d1b.rawQuery(
          'SELECT DISTINCT cart.*, ar.immagine from cart left join ar on cart.cd_ar = ar.cd_ar WHERE cart.cd_cf = \'${widget.cd_cf}\' and cart.stato != \'send\'');

    print(cart);

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
                'Ordini da Gestire',
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
                      builder: (context) =>
                          HomePage(agente: widget.agente.toString()),
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
                          MainCartPageCartCard(
                            cd_cf: widget.cd_cf,
                          ).px(8),
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
                                    child: 'Invia Ordine'
                                        .text
                                        .xl2
                                        .white
                                        .makeCentered()
                                        .py(16),
                                    onPressed: () async {
                                      final d1b =
                                          await ProvDatabase.instance.database;
                                      List cart_p = await d1b.rawQuery(
                                          'SELECT cart.*, ar.immagine from cart left join ar on cart.cd_ar = ar.cd_ar WHERE cart.stato != \'send\'');
                                      if (cart_p.length == 0)
                                        showDialog(
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
                                                      'Nessun articolo è presente nel  carrello!',
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
                                                          Navigator.of(context)
                                                              .pop();
                                                          refreshCart();
                                                          setState(() {});
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
                                      refreshCart();
                                      setState(() {});
                                      if (cart_p.length > 0) {
                                        List cart_f = await d1b.rawQuery(
                                            'SELECT cart.*, ar.immagine from cart left join ar on cart.cd_ar = ar.cd_ar WHERE cart.stato == \'0\' and cart.stato != \'send\' ');
                                        if (cart_f.isNotEmpty) {
                                          showDialog(
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
                                                        'Errore!',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 20.0,
                                                          fontFamily:
                                                              'helvetica_neue_light',
                                                        ),
                                                      ),
                                                      Text(
                                                        'Nessun articolo da confermare nel carrello!',
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
                                                            refreshCart();
                                                            setState(() {});
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
                                        }
                                        refreshCart();
                                        setState(() {});
                                        if (cart_f.isEmpty) {
                                          print('cart_f');
                                          await d1b.rawUpdate('''
                                        UPDATE cart 
                                        SET stato = ? 
                                        WHERE stato = ?
                                        ''', ['send', 'true']);
                                          showDialog(
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
                                                        'Gli articoli sono stati confermati carrello!',
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
                                                            refreshCart();
                                                            setState(() {});
                                                            Navigator.of(
                                                                    context)
                                                                .push(
                                                                    (MaterialPageRoute(
                                                              builder: (context) =>
                                                                  HomePage(
                                                                      agente: widget
                                                                          .agente),
                                                            )));
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
                                        }
                                      }
                                      refreshCart();
                                      setState(() {});
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

class MainCartPageCartCard extends StatefulWidget {
  const MainCartPageCartCard({this.cd_cf});
  final String? cd_cf;

  @override
  State<MainCartPageCartCard> createState() => _MainCartPageCartCardState();
}

class _MainCartPageCartCardState extends State<MainCartPageCartCard> {
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

    if (widget.cd_cf == null)
      cart = await d1b.rawQuery(
          'SELECT DISTINCT cart.*, ar.immagine from cart left join ar on cart.cd_ar = ar.cd_ar WHERE cart.stato != \'send\'');
    else
      cart = await d1b.rawQuery(
          'SELECT DISTINCT cart.*, ar.immagine from cart left join ar on cart.cd_ar = ar.cd_ar WHERE cart.cd_cf = \'${widget.cd_cf}\' and cart.stato != \'send\'');

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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
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
                          ),
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
                                if (widget.cd_cf == null)
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
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                  ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            color: Colors.black,
                            onPressed: () {
                              ProvDatabase.instance
                                  .deleteCart(cart[index]["id"]);
                              refreshCart();
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ))
    ]);
  }
}
