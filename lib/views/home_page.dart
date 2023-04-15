import '../controller/accept_controller.dart';
import '../controller/list_today_controller.dart';
import '../styles/common_module/my_widgets.dart';
import '../views/full_view.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../styles/app_colors.dart';
import '../styles/common_module/my_snack_bar.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String? notificationsStr;
  //late FirebaseMessaging messaging = FirebaseMessaging.instance;
  TodayListController listController = Get.put(TodayListController());
  AcceptController acceptController = Get.put(AcceptController());
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  var formatted = ''.obs;
  final box = GetStorage();
  Future<void> _pullRefresh(var _refreshIndicatorKey) async {
    // _refreshIndicatorKey.currentState?.show();
    //listController.getTodayLists();
    listController.getPending();
    listController.getFilterLists(formatted.value);
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print('My FCM .......... $fcmToken');
    print('My Box FCM .......... ${box.read('deviceID')}');
  }
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    getNotifications();
    //listController.myDate.value = formatter.format(now);
    //print(listController.myDate.value);
    formatted.value = formatter.format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: MyAppBars.myAppBar(context, box.read('avatar').toString(),box.read('role').toString()),
      body: GetX<TodayListController>(initState: (context){
        //listController.getTodayLists();
        listController.getFilterLists(formatted.value);
        listController.getPending();
        listController.getHistoryList();
        listController.getUpcomingList();
      },builder: (controller){
        controller.listUpcoming.sort((a, b) => a.meetingDate!.compareTo(b.meetingDate!)); // sort items by date
        controller.listHistory.sort((a, b) => b.meetingDate!.compareTo(a.meetingDate!)); // sort items by date
        List<DateTime?> dates = controller.listUpcoming.map((item) => item.meetingDate).toSet().toList();
        List<DateTime?> datesHistory = controller.listHistory.map((item) => item.meetingDate).toSet().toList();
        if (controller.isLoadingFilter.value){
          return Scaffold(
              body: Center(
                  child: CircularProgressIndicator(color: AppColors.themeColor,)));
        } else{
          return
            GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: DefaultTabController(
                      length: 3,
                      initialIndex: 0,
                      child: Column(
                        children: [
                          TabBar(
                            //isScrollable: true,
                            labelColor: AppColors.black,
                            labelStyle: const TextStyle(fontSize: 14),
                            indicatorColor: AppColors.themeColor,
                            indicatorWeight: 3,

                            tabs: const [
                              Tab(
                                text: 'Today\'s',
                              ),
                              Tab(
                                text: 'Upcoming',
                              ),
                              Tab(
                                text: 'History',
                              )
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                Column(
                                  children: [
                                    //const SizedBox(height: 15,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Obx(()=>
                                         InkWell(
                                          onTap: () async {
                                            DateTime? pickedDate = await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                //DateTime.now() - not to allow to choose before today.
                                                lastDate: DateTime(2100));
                                            if (pickedDate != null) {
                                              print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                              String formattedDate =
                                              DateFormat('yyyy-MM-dd').format(pickedDate);
                                              print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                                formatted.value = formattedDate; //set output date to TextField value.
                                              listController.getFilterLists(formattedDate);
                                            } else {}
                                          },
                                          child: Row(
                                            children: [
                                              const SizedBox(width: 15,),
                                              SizedBox(
                                                height: 35,
                                                width: 35,
                                                child: Image.asset('assets/images/calendar.png'),
                                              ),
                                              const SizedBox(width: 5,),
                                              Text('Today   ${formatted.value}',
                                                style: const  TextStyle(fontSize: 15,),
                                              )
                                            ],
                                          ),
                                        )),
                                        TextButton(
                                          onPressed: () {
                                            Get.to(()=> const FullView());
                                          },
                                          child: const Text('Full View    ',
                                            style: TextStyle(fontSize: 14,color: Colors.black),
                                          ),
                                        )
                                      ],
                                    ),
                                    //const SizedBox(height: 10),
                                    controller.listFilter.isEmpty?
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: const[
                                          Center(
                                              child: Text(
                                                  'No Appointments for today!!',style: TextStyle(fontSize: 17)
                                              )
                                          ),
                                        ],
                                      ),
                                    ):
                                    Expanded(
                                      child: RefreshIndicator(
                                        key: _refreshIndicatorKey,
                                        onRefresh: () {
                                          return _pullRefresh(_refreshIndicatorKey);
                                        },
                                        color: AppColors.themeColor,
                                        child: ListView.builder(
                                          //shrinkWrap: true,
                                          itemCount: controller.listFilter.length,
                                          padding: const EdgeInsets.only(bottom: 30),
                                          itemBuilder: (context, index) {
                                            return MyWidgets.myContainer(context,index,
                                                controller.listFilter,
                                                acceptController: acceptController,'',
                                                );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 5,),
                                          controller.listUpcoming.isEmpty?
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
                                            child: ListView.separated(
                                              itemCount: dates.length,
                                              itemBuilder: (BuildContext context, int index) {
                                                var itemsForDate = controller.listUpcoming.where((item) => item.meetingDate == dates[index]).toList(); // get items for current date
                                                return Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Text('   ${DateFormat('EEEE, MMMM dd, y').format(dates[index]!)}'), // display date header
                                                    ),
                                                    ListView.builder(
                                                      shrinkWrap: true,
                                                      physics: NeverScrollableScrollPhysics(),
                                                      itemCount: itemsForDate.length,
                                                      padding: const EdgeInsets.only(bottom: 10),
                                                      itemBuilder: (context, index) {
                                                        return MyWidgets.myContainer(
                                                            context,index, itemsForDate,'Upcoming');
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                              separatorBuilder: (BuildContext context, int index) {
                                                return Divider();
                                              },
                                            )
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 5,),
                                          controller.listHistory.isEmpty?
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
                                              child: ListView.separated(
                                                itemCount: datesHistory.length,
                                                itemBuilder: (BuildContext context, int index) {
                                                  var itemsForDate = controller.listHistory.where((item) => item.meetingDate == datesHistory[index]).toList(); // get items for current date
                                                  return Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Text('      ${DateFormat('EEEE, MMMM dd, y').format(datesHistory[index]!)}'), // display date header
                                                      ),
                                                      //DateFormat('EEEE, MMMM dd, y')
                                                      ListView.builder(
                                                        shrinkWrap: true,
                                                        physics: NeverScrollableScrollPhysics(),
                                                        itemCount: itemsForDate.length,
                                                        padding: const EdgeInsets.only(bottom: 10),
                                                        itemBuilder: (context, index) {
                                                          return MyWidgets.myContainer(
                                                              context,index, itemsForDate,'history');
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                                separatorBuilder: (BuildContext context, int index) {
                                                  return Divider();
                                                },
                                              )
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
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
        },
      ),
    );
  }
  getNotifications() {
    //On Terminated
    FirebaseMessaging.instance.getInitialMessage().then((event) {
      if (event != null) {
        //print("notification event: ${event.notification}, notification msg: ${event.notification!.title}");
        // listController.getTodayLists();
        listController.getFilterLists(formatted.value);
        listController.getPending();
      }
   });

    //On Foreground
    FirebaseMessaging.onMessage.listen((event) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${event.data}');
      //listController.getTodayLists();
      listController.getFilterLists(formatted.value);
      listController.getPending();
      // if (event.notification != null) {
      //   setState(() {
      //     notificationsStr =
      //     'Title : ${event.notification!.title}, Body : ${event.notification!.body} This is from Foreground State';
      //     MySnackbar.whiteSnackbar('Notification for you', notificationsStr!);
      //   });
      //   print('Message also contained a notification: ${event.notification}');
      // }
    });

    //Background
    FirebaseMessaging.onMessageOpenedApp.listen((event) =>
      setState(() {
        notificationsStr =
        'Title : ${event.notification!.title}, Body : ${event.notification!.body} This is from Background State';
        MySnackbar.whiteSnackbar('Notification for you', notificationsStr!);
      }),
   ///listController.getTodayLists()
    );
  }
}

/*

 */