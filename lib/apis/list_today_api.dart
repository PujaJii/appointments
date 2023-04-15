
import 'package:http/http.dart' as http;

import '../models/list_today_model.dart';
import '../utils/constants/app_constants.dart';



class TodayListApi{
  static var client = http.Client();

  static Future<TodayListModel> getTodayList(String type) async {

    // var baseUrl = GlobalConfiguration().get("base_url");

    var response = await client.post(Uri.parse('${AppConstants.baseUrl}appointment/list'),
        body: {'key': type}
    );

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return todayListModelFromJson(jsonString);
    }
    return todayListModelFromJson(response.body);
  }

  static Future<TodayListModel> getVIPList(String key,String type) async {

    // var baseUrl = GlobalConfiguration().get("base_url");

    var response = await client.post(Uri.parse('${AppConstants.baseUrl}appointment/list'),
        body: {'key': key, 'type': type}
    );

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return todayListModelFromJson(jsonString);
    }
    return todayListModelFromJson(response.body);
  }
}
  // Future<File> loadPdfFromNetwork(String url) async {
  //   final response = await http.get(Uri.parse(url));
  //   final bytes = response.bodyBytes;
  //   return _storeFile(url, bytes);
  // }
  //
  // Future<File> _storeFile(String url, List<int> bytes) async {
  //   final filename = basename(url);
  //   final dir = await getApplicationDocumentsDirectory();
  //   final file = File('${dir.path}/$filename');
  //   await file.writeAsBytes(bytes, flush: true);
  //   print('$file');
  //   return file;
  // }
