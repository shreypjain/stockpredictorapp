import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'symbols.dart';
import 'AnalysisPage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:stockapp/symbols.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock Prediction',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Stock Price Predictor'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //https://pkgstore.datahub.io/core/nasdaq-listings/nasdaq-listed-symbols_json/data/5c10087ff8d283899b99f1c126361fa7/nasdaq-listed-symbols_json.json
  bool loading = true;
  static List<Company> companies = new List<Company>();
  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<Company>> key = new GlobalKey();

  void getData() async{
    try{
      final resp = await http.get("https://pkgstore.datahub.io/core/nasdaq-listings/nasdaq-listed-symbols_json/data/5c10087ff8d283899b99f1c126361fa7/nasdaq-listed-symbols_json.json");
      if(resp.statusCode == 200){
        companies = getCompanies(resp.body);
        print('Companies: ${companies.length}');
        setState(() {
          loading = false;
        });
      }
      else{
        print("Error getting data");
      }
    }catch(e){
      print("Error getting data");
    }
  }

  static List<Company> getCompanies(String jsonS){
    final parsed = json.decode(jsonS).cast<Map<String, dynamic>>();
    return parsed.map<Company>((json) => Company.fromJson(json)).toList();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }


  void sendData(String sym){
    print("test");
  }

  Widget row(Company c){
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context){
              return AnaPage();
            }
          )
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(c.symbol,
            style: GoogleFonts.openSans(
                textStyle: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold,)
            ),
          ),
          Flexible(
            child: Text(c.name,
              style: GoogleFonts.openSans(
                  textStyle: TextStyle(fontSize: 12.0, color: Colors.black45)
              ),
              overflow: TextOverflow.ellipsis,
            ),

      )
        ],
      )
    );
  }
  @override
  Widget build(BuildContext contexts) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          loading ? CircularProgressIndicator() :
              searchTextField = AutoCompleteTextField<Company>(
                key: key,
                clearOnSubmit: false,
                suggestions: companies,
                style: TextStyle(color: Colors.black, fontSize: 16.0),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                  hintText: "Search for stock symbols to predict",
                  hintStyle: TextStyle(color: Colors.black)
                ),
                itemFilter: (item, query){
                  return item.symbol.toLowerCase().startsWith(query.toLowerCase());
                },
                itemSorter: (a, b){
                  return a.symbol.compareTo(b.symbol);
                },
                itemSubmitted: (item){
                  setState(() {
                    searchTextField.textField.controller.text = item.symbol;
                  });
                },
                itemBuilder: (context, item){
                  return row(item);
                },
              )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
