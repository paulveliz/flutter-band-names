import 'dart:io';

import 'package:bandnamesapp/src/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Band> bands = [
    new Band(id: '1', name: 'Metallica', votes: 5),
    new Band(id: '2', name: 'Guns And Roses', votes: 4),
    new Band(id: '3', name: 'Post malone', votes: 1),
    new Band(id: '4', name: 'Trippie redd', votes: 5),
    new Band(id: '5', name: '6ix9ine', votes: 1)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text('BandNames', style: TextStyle(color: Colors.black87)),
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (_, i) => bandTile(bands[i])
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: addNewBand,
      ),
    );
  }

  Widget bandTile(Band banda) {
    return Dismissible(
      key: Key(banda.id),
      direction: DismissDirection.startToEnd,
      onDismissed: ( direction ){
        // TODO: Llamar el borrado en el server.
      },
      background: Container(
        padding: EdgeInsets.only(left: 10),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text('Delete band', style: TextStyle(color: Colors.white)),
        ),
      ),
      child: ListTile(
        title: Text(banda.name),
        trailing: Text('${banda.votes}', style: TextStyle(fontSize: 20)),
          leading: CircleAvatar(
            child: Text(banda.name.substring(0,2)),
            backgroundColor: Colors.blue[100],
          ),
          onTap: (){},
      ),
    );
  }

  addNewBand(){
    final textController = new TextEditingController();
    if( Platform.isAndroid ){
      showDialog(
        context: context,
        builder: ( context ) {
          return AlertDialog(
            title: Text('New band name'),
            content: TextField(
              controller: textController,
            ),
            actions: [
              MaterialButton(
                child: Text('Add'),
                textColor: Colors.blue,
                elevation: 5,
                onPressed: () => addBandToList(textController.text)
              )
            ],
          );
        }
      );
    }else{
      showCupertinoDialog(
        context: context, 
        builder: (_){
          return CupertinoAlertDialog(
            title: Text('New band name:'),
            content: CupertinoTextField(
              controller: textController,
            ),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text('Add'),
                onPressed: () => addBandToList(textController.text)
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                child: Text('Dismiss'),
                onPressed: () => Navigator.pop(context)
              ),
            ],
          );
        }
      );
    }
  }

  void addBandToList(String name){
    if(name.length > 1){
      this.bands.add(new Band(id: DateTime.now().toString(), name: name, votes: 4));
      setState(() {});
      Navigator.of(context).pop();
    }else{
      Navigator.of(context).pop();
    }
  }

}