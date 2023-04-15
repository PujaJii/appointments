import 'package:http/http.dart' as http;

import '../models/list_today_model.dart';
import '../utils/constants/app_constants.dart';



class FilterListApi{
  static var client = http.Client();


  static Future<TodayListModel> getFilterList(String date) async {

    // var baseUrl = GlobalConfiguration().get("base_url");

    var response = await client.post(Uri.parse('${AppConstants.baseUrl}appointment/list/filter'),
        body: {'key': date}
    );

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return todayListModelFromJson(jsonString);
    }
    return todayListModelFromJson(response.body);
  }
}