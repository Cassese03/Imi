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

import 'cart.dart';
import 'cliente.dart';
import 'dettaglio.dart';
import 'documenti.dart';
import 'ordini.dart';

class SincronizzaPage extends StatefulWidget {
  const SincronizzaPage({required this.agente, required this.cart});
  final List? cart;
  final String? agente;
  @override
  _SincronizzaPageState createState() => _SincronizzaPageState();
}

class _SincronizzaPageState extends State<SincronizzaPage> {
  late List cf;
  bool isLoading = false;
  bool isDownloading = false;
  bool isSending = false;
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    SincronizzaDati();
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
        'cd_agente_1': cart.cd_agente_1.toString(),
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
        'xconfezione': cart.confezione.toString(),
      }),
    );
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

  Future SincronizzaDati() async {
    setState(() => isDownloading = true);
    sendCart(widget.cart);
    setState(() => isDownloading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
          body: Center(
        child: isDownloading
            ? Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('Sincronizza dati Online'),
                    //Image.asset('assets/logo.png'),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                    ),
                    LoadingJumpingLine.circle()
                  ],
                ),
              )
            : Container(
                child: Text(''),
              ),
      ));
}
