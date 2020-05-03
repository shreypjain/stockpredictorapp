import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AnaPage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return AnaState();
  }
}
class AnaState extends State<AnaPage>
{
  bool loading = true;

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async{
    try{
      final response = await http.get('url');
      if(response.statusCode == 200){
        setState(() {
          loading = false;
        });
      }
    }catch(e){

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data"),
      ),
      body: Column(
        children: <Widget>[
          loading ? CircularProgressIndicator() :
            Image(
              image: Image.network("j"),
            )
        ],
      ),
    );
  }
}