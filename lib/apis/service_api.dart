
import '../utils/constants/app_constants.dart';
import 'package:http/http.dart' as http;

import '../models/service_model.dart';



class ServiceListApi{

  static var client = http.Client();


  static Future<ServiceListModel> getServiceList() async {

    // var baseUrl = GlobalConfiguration().get("base_url");

    var response = await client.post(Uri.parse('${AppConstants.baseUrl}service/list'),
        body: {}
    );

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return serviceListModelFromJson(jsonString);
    }
    return serviceListModelFromJson(response.body);
  }
}