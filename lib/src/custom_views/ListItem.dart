import 'package:flutter/material.dart';


//CLASS LISITEM LA CLASE QUE SE MUESTRA EN EL HOME

class ListItem extends StatelessWidget{
  final String stittle;
  final int iIndex;
  final Function(int index) whitClickGo;
const ListItem({Key? key , required this.stittle, required this.whitClickGo, required this.iIndex,}) : super(key: key);
  @override

  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
      title: Text(stittle, textScaleFactor: 1.1,),
      leading: Icon(Icons.sports_baseball),
      onTap: (){
        whitClickGo(iIndex);
      },
    );
  }


}