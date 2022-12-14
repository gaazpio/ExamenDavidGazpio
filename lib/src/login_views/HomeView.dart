import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examen_david_gazpio/src/Perfil/Lista.dart';
import 'package:examen_david_gazpio/src/custom_views/ListItem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../DataHolder/DataHolder.dart';
import '../Perfil/Perfiles.dart';
import '../custom_views/Button.dart';

//ESTA ES LA CLASE DONDE SE MUESTRA LAS LISTAS, llamas al LISTITEM y se muestra
// luego hacemos 2 funciones para acceder a cada lista y otra para mostrarla



class HomeView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomeView> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<Lista> listRooms = [];
  Lista typeaList = Lista();
  String name = "--";

  @override
  void initState() {
    super.initState();
    pasarlistas();
  }

  void onClickgo(int index) {
    print("has clicado");
    print(listRooms[index].name);
    Navigator.of(context).pushNamed("/insideList");
    DataHolder().whatList=listRooms[index];
  }

  void pasarlistas() async {
    final docRef = db.collection("listas").withConverter(
        fromFirestore: Lista.fromFirestore,
        toFirestore: (Lista list, _) => list.toFirestore());
    final docSnap = await docRef.get();
    setState(() {
      for (int i = 0; i < docSnap.docs.length; i++) {
        listRooms.add(docSnap.docs[i].data());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.map),
        title: Text('Seleccion Española'),
        actions: [
          Icon(Icons.map),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
          ),
        ],
        backgroundColor: Color.fromRGBO(112, 0, 0, 20),

      ),  bottomNavigationBar: BottomAppBar(
      color: Color.fromRGBO(112, 0, 0, 20),
      child: Row(
        children: [
          IconButton(
              icon: Icon(
                Icons.menu,
                size: 0,
              ),
              onPressed: () {}),
          Spacer(),
        ],
      ),
    ),
      body: Container(
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: listRooms.length,
          itemBuilder: (BuildContext context, int index) {
            return ListItem(
              stittle: listRooms[index].name!,
              whitClickGo: onClickgo,
              iIndex: index,
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
          const Divider(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).popAndPushNamed("/onBoardingListas");
        },
        label: const Text('Añadir nuevo jugador'),
        icon: const Icon(Icons.flag_circle),
        backgroundColor: Color.fromRGBO(112, 0, 0, 20),
      ),
      backgroundColor: Colors.yellow,
    );
  }
}