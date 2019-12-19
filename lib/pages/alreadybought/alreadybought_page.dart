import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/counter.dart';

class AlreadyboughtPage extends StatefulWidget {
  @override
  _AlreadyboughtPageState createState() => _AlreadyboughtPageState();
}

class _AlreadyboughtPageState extends State<AlreadyboughtPage> {
  @override
  Widget build(BuildContext context) {
    var asd = Provider.of<Counter>(context);
    return Scaffold(
      body: InkWell(
        onTap: (){
          // asd.incCount(10);
          Navigator.pushNamed(context, '/my');
        },
        child: Center(
          child: Text('${asd.count}'),
        ),
      ),
    );
  }
}