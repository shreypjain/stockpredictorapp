class Company{
    String name;
    String symbol;

    Company({this.name, this.symbol});

    factory Company.fromJson(Map<String, dynamic> parsedJson){
      return Company(
        name: parsedJson["Company Name"] as String,
        symbol: parsedJson["Symbol"] as String,
      );
    }
}