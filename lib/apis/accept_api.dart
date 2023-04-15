
import '../models/accept_appointment_model.dart';
import 'package:http/http.dart' as http;

import '../utils/constants/app_constants.dart';



class AcceptApi{

  static var client = http.Client();

  static Future<AcceptAppointmentModel> acceptAppointment(String accessType, String appointmentID) async {

    var response = await client.post(Uri.parse('${AppConstants.baseUrl}multipurpose'),
    body: {
      'accessType'    : accessType,
      'appointmentID' : appointmentID
     }
    );

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return acceptAppointmentModelFromJson(jsonString);
    }
    return acceptAppointmentModelFromJson(response.body);
  }
}
