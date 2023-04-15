import '../models/edit_appointment_model.dart';
import '../utils/constants/app_constants.dart';
import 'package:http/http.dart' as http;



class EditAppointmentApi{

  static Future<EditApiModel> editAppointment(
      String appointment_name,
      String appointment_date,
      String appointment_time,
      String appointment_type,
      String appointment_subject,
      String userID,
      String appioment_status,
      String? service_type,
      String? video_confarance,
      String appointment_id,
      String minutes,
      {dynamic document}
      ) async {
    // var baseUrl = GlobalConfiguration().get("base_url");

    var request =  http.MultipartRequest('POST',
        Uri.parse('${AppConstants.baseUrl}edit-appointment'));

    request.fields['appointment_name'] = appointment_name;
    request.fields['appointment_date'] = appointment_date;
    request.fields['appointment_time'] = appointment_time;
    request.fields['appointment_type'] = appointment_type;
    request.fields['appointment_subject'] = appointment_subject;
    request.fields['userID'] = userID;
    request.fields['appioment_status'] = appioment_status;
    request.fields['service_type'] = service_type!;
    request.fields['video_confarance'] = video_confarance!;
    request.fields['appointment_id'] = appointment_id;
    request.fields['minutes'] = minutes;
    if(document == ''|| document ==null){
    }
    else{
      request.files.add(await http.MultipartFile.fromPath('document', document.toString()));
    }
    //  request.files.add(await http.MultipartFile.fromPath('document', document.toString()));

    var response = await request.send();
    final res = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var jsonString = res.body.toString();
      //print('$baseUrl url');
      return editApiModelFromJson(jsonString);
    }
    return editApiModelFromJson(res.body);
  }
}