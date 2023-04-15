import '../views/pending_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/accept_controller.dart';
import '../controller/list_today_controller.dart';
import '../styles/app_colors.dart';
import '../styles/common_module/my_widgets.dart';
import '../utils/constants/size_orientation.dart';
import 'reject_list.dart';
import 'only_approved.dart';


class Appointments extends StatelessWidget {
  const Appointments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var box = GetStorage();
    TodayListController listController1 = Get.find();
    AcceptController acceptController = Get.find();
    // Future<void> _launchUrl(String urls) async {
    //   var url = urls;
    //   try{
    //     if (!await launchUrl(Uri.parse(url))) {
    //       throw Exception('Could not launch $url');
    //     }
    //   }catch(c){
    //     MySnackbar.infoSnackBar('Link not correct', 'Invalid link, please copy the link and open external');
    //   }
    // }
    ScreenContext.getScreenContext(context);
    if(ScreenContext.width! > 550) {
      ///tablets...............
      return
        Scaffold(
          // appBar: MyAppBars.myAppBar(context,box.read('avatar').toString(),box.read('role').toString()),
        body: GetX<TodayListController>(initState: (context) {
          listController1.getPreApproved();
        }, builder: (controller) {
          if (controller.isLoadingPreApproved.value) {
            return Scaffold(body: Center(child: CircularProgressIndicator(color: AppColors.themeColor,)));
          } else {
            return GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: DefaultTabController(
                        length: 4,
                        initialIndex: 0,
                        animationDuration: const Duration(seconds: 1),
                        child: Column(
                          children: [
                            TabBar(
                              isScrollable: false,
                              labelColor: AppColors.black,
                              labelStyle: const TextStyle(fontSize: 14),
                              // labelStyle: FlutterFlowTheme.of(context).bodyText1,
                              indicatorColor: AppColors.themeColor,
                              indicatorWeight: 3,
                              tabs: [
                                Tab(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset('assets/images/pre_approved.png', width: 18, height: 18),
                                      const SizedBox(width: 4),
                                      const Text('Pre Approved'),
                                    ],
                                  ),
                                ),
                                Tab(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset('assets/images/recent_visitor.png', width: 18, height: 18),
                                      const SizedBox(width: 4),
                                      const Text('Approved'),
                                    ],
                                  ),
                                ),
                                Tab(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset('assets/images/pending.png', width: 18, height: 18),
                                      const SizedBox(width: 4),
                                      const Text('Pending'),
                                    ],
                                  ),
                                ),
                                Tab(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset('assets/images/rejected.png', width: 18, height: 18),
                                      const SizedBox(width: 4),
                                      const Text('Rejected'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: TabBarView(
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      controller.listPreApproved.isEmpty?
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: const[
                                            Center(child: Text('No Appointments found!!',style: TextStyle(fontSize: 17),)),
                                          ],
                                        ),
                                      ):
                                      Expanded(
                                        child: ListView.builder(
                                          itemCount: controller.listPreApproved.length,
                                          // shrinkWrap: true,
                                          //padding: const EdgeInsets.only(bottom: 30),
                                          itemBuilder: (context, index) {
                                            return MyWidgets.myContainer(
                                                context,index,
                                                controller.listPreApproved,'',);
                                          },),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      OnlyApprovedList.onlyApproved(context,listController1)
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      PendingListPage.onlyPending(context,listController1,acceptController)
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      RejectedList.onlyRejects(context,listController1)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
          }
        }),
      );
    }

    ///phones...............
    return Scaffold(
      // appBar: MyAppBars.myAppBar(context,box.read('avatar').toString(),box.read('role').toString()),
      body: GetX<TodayListController>(initState: (context) {
      listController1.getPreApproved();
    }, builder: (controller) {
      if (controller.isLoadingPreApproved.value) {
        return Scaffold(
            body: Center(
                child: CircularProgressIndicator(color: AppColors.themeColor,)));
      } else {
        return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: DefaultTabController(
                    length: 4,
                    initialIndex: 0,
                    animationDuration: const Duration(seconds: 1),
                    child: Column(
                      children: [
                        TabBar(
                          isScrollable: true,
                          labelColor: AppColors.black,
                          labelStyle: const TextStyle(fontSize: 14),
                          indicatorColor: AppColors.themeColor,
                          indicatorWeight: 3,
                          tabs: [
                            Tab(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset('assets/images/pre_approved.png', width: 18, height: 18),
                                  const SizedBox(width: 4),
                                  const Text('Pre Approved'),
                                ],
                              ),
                            ),
                            Tab(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset('assets/images/recent_visitor.png', width: 18, height: 18),
                                  const SizedBox(width: 4),
                                  const Text('Approved'),
                                ],
                              ),
                            ),
                            Tab(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset('assets/images/pending.png', width: 18, height: 18),
                                  const SizedBox(width: 4),
                                  const Text('Pending'),
                                ],
                              ),
                            ),
                            Tab(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset('assets/images/rejected.png', width: 18, height: 18),
                                  const SizedBox(width: 4),
                                  const Text('Rejected'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 5,),
                                        controller.listPreApproved.isEmpty?
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: const[
                                              Center(child: Text('No Appointments found!!',
                                                style: TextStyle(fontSize: 17),)),
                                            ],
                                          ),
                                        ):
                                        Expanded(
                                          child: ListView.builder(
                                            itemCount: controller.listPreApproved.length,
                                            padding: const EdgeInsets.only(bottom: 30),
                                            itemBuilder: (context, index) {
                                             return MyWidgets.myContainer(
                                                 context,index, controller.listPreApproved,'');
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  OnlyApprovedList.onlyApproved(context,listController1)
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  PendingListPage.onlyPending(context,listController1,acceptController),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  RejectedList.onlyRejects(context,listController1)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}