import '../models/api_check_model.dart';
import 'package:http/http.dart' as http;

import '../utils/constants/app_constants.dart';



class MailCheckApi{
  static var client = http.Client();

  static Future<MailCheckModel> mailCheck(String clientEmail, deviceId) async {
    //var baseUrl = GlobalConfiguration().get('base_url');



    var response = await client.post(Uri.parse(
        '${AppConstants.baseUrl}user-check'),
        body: {'clientEmail': clientEmail, 'fcm':deviceId});

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return mailCheckModelFromJson(jsonString);
    }
    return mailCheckModelFromJson(response.body);
  }
}