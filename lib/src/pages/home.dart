import 'dart:io';
import 'package:bandnamesapp/src/models/band.dart';
import 'package:bandnamesapp/src/services/socket_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() { 
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.on('active-bands', ( payload ) {
      this.bands = (payload as List).map( (band){
        return Band.fromMap(band);
      }).toList();
      setState(() {});
    });
    super.initState();
  }
  
  @override
  void dispose(){
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.off('active-bands');
    super.dispose();
  }

  List<Band> bands = [];

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text('BandNames', style: TextStyle(color: Colors.black87)),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: socketService.serverStatus != ServerStatus.Online ? Icon(Icons.offline_bolt, color: Colors.red) : Icon(Icons.check_circle, color: Colors.blue[300])
          )
        ],
      ),
      body: Column(
        children: [
          _showGraph(),
          Expanded(
            child: ListView.builder(
              itemCount: bands.length,
              itemBuilder: (_, i) => bandTile(bands[i])
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: addNewBand,
      ),
    );
  }

  Widget bandTile(Band banda) {
    final socketService = Provider.of<SocketService>(context, listen: false);

    return Dismissible(
      key: Key(banda.id),
      direction: DismissDirection.startToEnd,
      onDismissed: ( direction ){
          socketService.emit('delete-band', {'id': banda.id});
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
          onTap: (){
            socketService.emit('vote-band', { 'id': banda.id });
          },
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
      final socketService = Provider.of<SocketService>(context, listen: false);
      socketService.emit('add-band', {'nombre': name});
      // socketService.socket.on('active-bands', ( payload ) {
      //   this.bands = (payload as List).map( (band){
      //     return Band.fromMap(band);
      //   }).toList();
      //   setState(() {});
      // });

      Navigator.of(context).pop();
    }else{
      Navigator.of(context).pop();
    }
  }

  Widget _showGraph() {
    Map<String, double> dataMap = new Map();
    bands.forEach((e) {
      dataMap.putIfAbsent(e.name, () => e.votes.toDouble() );
    });
      List<Color> colorList = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.yellow,
    ];
    return Container(
      padding: EdgeInsets.all(10.0),
      child: PieChart(
        dataMap: dataMap,
        animationDuration: Duration(milliseconds: 800),
        chartLegendSpacing: 32,
        chartRadius: MediaQuery.of(context).size.width / 3.2,
        colorList: colorList,
        initialAngleInDegree: 0,
        chartType: ChartType.ring,
        ringStrokeWidth: 32,
        centerText: "HYBRID",
        legendOptions: LegendOptions(
          showLegendsInRow: false,
          legendPosition: LegendPosition.right,
          showLegends: true,
          legendShape: BoxShape.circle,
          legendTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        chartValuesOptions: ChartValuesOptions(
          showChartValueBackground: true,
          showChartValues: true,
          showChartValuesInPercentage: false,
          showChartValuesOutside: false,
        ),
      ),
    );
  }

}