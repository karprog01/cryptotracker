import 'package:appsdevtycoon/cdata.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CList extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() {
    return CListState();
  }
}

class CListState extends State<CList> {
  List<CData> data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CryptoTracker'),
      ),
      body: Container(
        child: ListView(
          children: _buildList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () => _loadC(),
      ),
    );
  }

  _loadC() async {
    final response = await http.get('https://api.coincap.io/v2/assets?limit=100');
    if(response.statusCode == 200) {
      var allData = (json.decode(response.body) as Map)['data'];

      var cDataList = List<CData>();
      allData.forEach((value) {
        cDataList.add(CData(
          name: value['name'],
          symbol: value['symbol'],
          rank: int.parse(value['rank']),
          price: double.parse(value['priceUsd']),
        ));
      });

      setState(() {
        data = cDataList;
      });
    }
  }

  List<Widget> _buildList(){
    return data.map((CData f) => ListTile(
      subtitle: Text(f.symbol),
      title: Text(f.name),
      leading: CircleAvatar(child: Text(f.rank.toString())),
      trailing: Text('\$${f.price.toStringAsFixed(2)}'),
    )).toList();
  }

  @override
  void initState() {
    super.initState();
    _loadC();
  }
}