
import '../models/log_history_model.dart';
import 'package:http/http.dart' as http;

import '../utils/constants/app_constants.dart';



class LogHistoryApi{

  static var client = http.Client();


  static Future<LogHistoryModel> getLogHistory(String type) async {

    // var baseUrl = GlobalConfiguration().get("base_url");

    var response = await client.post(Uri.parse('${AppConstants.baseUrl}multipurpose'),
        body: {'accessType': type}
    );

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return logHistoryModelFromJson(jsonString);
    }
    return logHistoryModelFromJson(response.body);
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
