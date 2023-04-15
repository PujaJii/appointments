import '../controller/log_history_controller.dart';
import '../styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../utils/constants/size_orientation.dart';

class LogHistory extends StatelessWidget {
  const LogHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var box = GetStorage();
    ScreenContext.getScreenContext(context);
    LogHistoryController logHistoryController = Get.put(LogHistoryController());
    if(box.read('role').toString() == 'DM'){
      if(ScreenContext.width! > 550) {
      ///tablets...............
        return  Scaffold(
            backgroundColor: AppColors.themeColorLight,
            // appBar: MyAppBars.myAppBar(context,box.read('avatar').toString(),box.read('role').toString()),
            body: GetX<LogHistoryController>(initState: (context){
              logHistoryController.getLogHistoryList();
            },builder: (controller){
              if (controller.isLoading.value){
                return Scaffold(
                    body: Center(child: CircularProgressIndicator(color: AppColors.themeColor,)));
              } else{
                return Column(
                  children: [
                    const SizedBox(height: 10,),
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.logHistoryList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 3,
                                  offset: Offset(
                                    0,
                                    3,
                                  ),
                                )],
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.white,),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text('Login Time',style: TextStyle(fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(controller.logHistoryList[index].loginTime.toString()),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text('Login IP',style: TextStyle(fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(controller.logHistoryList[index].ipAddress!),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text('Login Browser',style: TextStyle(fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(controller.logHistoryList[index].userAgent!),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );

              }
            }),
        );
      }
      ///phones.................
      return
        Scaffold(
            backgroundColor: AppColors.themeColorLight,
            // appBar: MyAppBars.myAppBar(context,box.read('avatar').toString(),box.read('role').toString()),
            body: GetX<LogHistoryController>(initState: (context){
              logHistoryController.getLogHistoryList();
            },builder: (controller){
              if (controller.isLoading.value){
                return Scaffold(
                    body: Center(child: CircularProgressIndicator(color: AppColors.themeColor,)));
              } else{
                return Column(
                    children: [
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.logHistoryList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 3,
                                    offset: Offset(
                                      0,
                                      3,
                                    ),
                                  )],
                                borderRadius: BorderRadius.circular(5),
                                color: AppColors.white,),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Row(
                                            children: [
                                              Icon(Icons.access_time_sharp,size: 20,color: AppColors.themeColor3),
                                              Text('  Login Time',style: TextStyle(fontWeight: FontWeight.bold)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(controller.logHistoryList[index].loginTime.toString()),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.all(5.0),
                                          child: Row(
                                            children: [
                                              Icon(Icons.laptop,size: 20,color: AppColors.themeColor3),
                                              Text('  Login IP',style: TextStyle(fontWeight: FontWeight.bold)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(controller.logHistoryList[index].ipAddress!),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:  CrossAxisAlignment.start,
                                    children: [
                                       Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.all(5.0),
                                          child: Row(
                                            children: [
                                              Icon(Icons.signal_cellular_connected_no_internet_0_bar,size: 20,color: AppColors.themeColor3),
                                              Text('  Login Browser',style: TextStyle(fontWeight: FontWeight.bold)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(controller.logHistoryList[index].userAgent!),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
          }
        }),
      );
    }
    if(ScreenContext.width! > 550) {
      ///tablets...............
      return Scaffold(
          // appBar: MyAppBars.myAppBar(context,box.read('avatar').toString(),box.read('role').toString()),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('You are not authorised to see this page\n Please log in as DM',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17),)
              ],
            ),
          )
      );
    }
    ///phones...............
    return Scaffold(
        // appBar: MyAppBars.myAppBar(context,box.read('avatar').toString(),box.read('role').toString()),
        body:
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('You are not authorised to see this page\n please log in as DM',textAlign: TextAlign.center,)
            ],
          ),
        )
    );

  }
}
