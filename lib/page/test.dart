/* 
import 'package:flutter/material.dart';
import 'package:imi/db/databases.dart';
import 'package:imi/model/cart.dart';
import 'package:imi/model/imi.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:imi/page/agente.dart';
import 'package:imi/page/table.dart';
import 'package:imi/widget/imi_card_widget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:loading_animations/loading_animations.dart';
import '../model/ar.dart';
import '../db/databases.dart';
import '../widget/table_card_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // late List<imi> prov;
  bool isLoading = false;
  late List result1;
  late List cart;

  @override
  void initState() {
    super.initState();

    refreshProv();
  }

/*
  @override
  void dispose() {
    ProvDatabase.instance.close();

    super.dispose();
  }
*/
  Future<List<AR>> get_ar() async {
    var url = 'https://bohagent.cloud/api/b2b/get_imi/IMI1234';

    var response = await http.get(Uri.parse(url));

    var notes = <AR>[];

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        notes.add(AR.fromJson(noteJson));
      }
    }
    return notes;
  }

  Future refreshProv() async {
    setState(() => isLoading = true);

//    prov = await ProvDatabase.instance.readAllimi();

    final d1b = await ProvDatabase.instance.database;
    result1 = (await d1b.query('sqlite_master',
            where:
                'type = ? and name != \'android_metadata\' and name != \'sqlite_sequence\' ',
            whereArgs: ['table']))
        .map((row) => row['name'] as String)
        .toList(growable: false);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Tabelle',
            style: TextStyle(fontSize: 24),
          ),
          actions: [Icon(Icons.search), SizedBox(width: 12)],
        ),
        body: Center(
          child: isLoading
              ? Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      //Image.asset('assets/logo.png'),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                      ),
                      LoadingJumpingLine.circle()
                    ],
                  ),
                )
              : result1.isEmpty
                  ? Text(
                      'Nessuna Tabelle',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  : buildNotes(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: const Icon(Icons.refresh),
          onPressed: () async {
            isLoading = true;

            print('Start');

            await get_ar().then((value) async {
              await ProvDatabase.instance.deleteallAR();

              for (int i = 0; i < value.length; i++) {
                await ProvDatabase.instance.addAR(
                    value[i].cd_AR,
                    value[i].descrizione,
                    value[i].cd_aliquota_v,
                    value[i].cd_arclasse1,
                    value[i].cd_arclasse2,
                    value[i].cd_arclasse3,
                    value[i].cd_argruppo1,
                    value[i].cd_argruppo2,
                    value[i].cd_argruppo3,
                    value[i].immagine);
                print('Inserito correttamente $i');
              }
            });

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
      );

  Widget buildNotes() => StaggeredGridView.countBuilder(
        padding: EdgeInsets.all(8),
        itemCount: result1.length,
        staggeredTileBuilder: (int index) =>
            StaggeredTile.extent(result1.length, 100),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final note = result1[index];

          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TablePage(tabella: note),
              ));

              refreshProv();
            },
            onLongPress: () async {
              int? ciao = result1[index].id;
              //print((ciao) != null ? ciao : 0);
              (ciao) != null ? await ProvDatabase.instance.delete(ciao) : '';

              refreshProv();
            },
            child: TableCardWidget(note: note, index: index),
          );
        },
      );
}
*/