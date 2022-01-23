
import 'package:validus_coin/utils/utility_functions.dart';

class Stock {
  String id, stockName;
  DateTime lastTrade, extendedHours;
  double price, dayGain, lastPrice;
  Stock({id, stockName, price, dayGain, lastTrade, extendedHours, lastPrice});
  Stock.fromJson (Map<String, dynamic> stockJson) {
    if (stockJson == null) return;
    id = stockJson["id"];
    stockName = stockJson["stockName"];
    price =  getDoubleFrom(stockJson["price"]);
    dayGain =  getDoubleFrom(stockJson["dayGain"]);
    lastTrade =  getDateTimeFrom(getIntFrom(stockJson["lastTrade"]));
    extendedHours =  getDateTimeFrom(getIntFrom(stockJson["extendedHours"]));
    lastPrice =  getDoubleFrom(stockJson["lastPrice"]);
  }
  toJson() {
    return {
      "id": id,
      "stockName": stockName,
      "price": price,
      "dayGain": dayGain,
      "lastTrade": lastTrade,
      "extendedHours": extendedHours,
      "lastPrice": lastPrice
    };
  }
}
class StockApi {
  bool success;
  int statusCode;
  List<Stock> stocks = [];
  StockApi({success = false, statusCode, stocks});
  StockApi.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    success = getBoolFrom(json["success"]);
    statusCode = getIntFrom(json["statusCode"]);
    List<Map<String, dynamic>>.from(json["data"]).forEach((element) {
      stocks.add(Stock.fromJson(element));
    });
  }
}