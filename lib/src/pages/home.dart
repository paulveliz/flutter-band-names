import 'package:bandnamesapp/src/models/band.dart';
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
        onPressed: (){},
      ),
    );
  }

  ListTile bandTile(Band banda) {
    return ListTile(
      title: Text(banda.name),
      trailing: Text('${banda.votes}', style: TextStyle(fontSize: 20)),
        leading: CircleAvatar(
          child: Text(banda.name.substring(0,2)),
          backgroundColor: Colors.blue[100],
        ),
        onTap: (){},
    );
  }
}