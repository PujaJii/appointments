import '../models/del_model.dart';
import 'package:http/http.dart' as http;

import '../utils/constants/app_constants.dart';



class DeleteApi{

  static var client = http.Client();

  static Future<DeleteModel> delAppointment(String appointment_id,) async {

    var response = await client.post(Uri.parse('${AppConstants.baseUrl}del-appointment'),
        body: {
          'appointment_id'    : appointment_id,
        }
    );

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return deleteModelFromJson(jsonString);
    }
    return deleteModelFromJson(response.body);
  }
}
