// ignore_for_file: deprecated_member_use

//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:imi/db/databases.dart';
import 'package:imi/model/agente.dart';
import 'package:imi/model/imi.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class AgentePage extends StatefulWidget {
  @override
  _AgentePageState createState() => _AgentePageState();
}

class _AgentePageState extends State<AgentePage> {
  late List<Agente> prov;
  bool isLoading = false;
  late String descrizione;
  late String password;
  late String cd_agente;

  @override
  void initState() {
    super.initState();

    refreshAgente();
  }
/*
  @override 
  void dispose() {
    ProvDatabase.instance.close();

    super.dispose();
  }*/

  Future refreshAgente() async {
    setState(() => isLoading = true);

    prov = await ProvDatabase.instance.readAllAgente();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Notes',
            style: TextStyle(fontSize: 24),
          ),
          actions: [Icon(Icons.search), SizedBox(width: 12)],
        ),
        body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : prov.isEmpty
                  ? Text(
                      'No Notes',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  : buildNotes(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: const Icon(Icons.add),
          onPressed: () async {
            showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: const Text('AlertDialog Title'),
                      content: const Text('AlertDialog description'),
                      actions: <Widget>[
                        Text(
                          'Inserisci cd_agente',
                          textAlign: TextAlign.start,
                        ),
                        Form(
                          child: TextFormField(onChanged: (val) {
                            cd_agente = val;
                          }),
                        ),
                        Text(
                          'Inserisci descrizione Agente',
                          textAlign: TextAlign.start,
                        ),
                        Form(
                          child: TextFormField(onChanged: (val) {
                            descrizione = val;
                          }),
                        ),
                        Text(
                          'Inserisci password',
                          textAlign: TextAlign.start,
                        ),
                        Form(
                          child: TextFormField(onChanged: (val) {
                            password = val;
                          }),
                        ),
                        RaisedButton(onPressed: () {
                          print(cd_agente);
                          print(descrizione);
                          print(password);
                        })
                      ],
                    ));
          },
        ),
      );

  Widget buildNotes() => StaggeredGridView.countBuilder(
        padding: EdgeInsets.all(8),
        itemCount: prov.length,
        staggeredTileBuilder: (int index) =>
            StaggeredTile.extent(prov.length, 100),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final note = prov[index];

          return GestureDetector(
            onTap: () async {
              /*
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NoteDetailPage(noteId: note.id!),
              ));
*/
              refreshAgente();
            },
            onLongPress: () async {
              int? ciao = prov[index].id;
              //print((ciao) != null ? ciao : 0);
              (ciao) != null
                  ? await ProvDatabase.instance.deleteAgente(ciao)
                  : '';

              refreshAgente();
            },
            //child: AgenteCardWidget(note: note, index: index),
          );
        },
      );
}
