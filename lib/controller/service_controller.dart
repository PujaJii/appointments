
import '../models/service_model.dart';
import 'package:get/get.dart';

import '../apis/service_api.dart';


class ServiceListController extends GetxController{


  var isLoading = false.obs;
  var serviceList = <Services>[].obs;
  var cats = [].obs;
  var catID = [].obs;

  getServiceLists () async {
    try {
      isLoading(true);
      var apiResponse = await ServiceListApi.getServiceList();

      if (apiResponse != null) {
        if (apiResponse.response == 'success') {
          serviceList.assignAll(apiResponse.data!);
          // Map<String, dynamic> jsonMap = json.decode(serviceList);
          // Map<String, dynamic> matchedObject = serviceList.firstWhere((obj) => obj['id'] == 18);
          for (var element in serviceList) {
            cats.add(element.serviceName.toString() + '_'+ element.id.toString());
            catID.add(element.id.toString());
          }
          // for(int i = 0; i < cats.length; i++){
          //   print('${cats.elementAt(i)} ${catID.elementAt(i)}');
          // }
        }
      }
    } finally {
      isLoading(false);
    }
  }
}