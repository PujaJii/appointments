import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import '../styles/app_colors.dart';
import '../styles/common_module/my_snack_bar.dart';
import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';



class DownloadFilePage extends StatefulWidget {

  String? name;
  DownloadFilePage(this.name, {Key? key}) : super(key: key);

  @override
  State<DownloadFilePage> createState() => _DownloadFilePageState();
}

class _DownloadFilePageState extends State<DownloadFilePage> {

  void _downloadFile() async {
    final notify = await Permission.notification.request();
    if(notify.isGranted) {
      final status = await Permission.storage.request();
      if (status.isGranted) {
        final baseStorage = await getExternalStorageDirectory();
        Directory _path = await getApplicationDocumentsDirectory();
        String _localPath = _path.path + Platform.pathSeparator + 'Download';
        final savedDir = Directory(_localPath);
        bool hasExisted = await savedDir.exists();
        if (!hasExisted) {
          savedDir.create();
        }
        var path = _localPath;
        if (baseStorage != null) {
          print('..................$path');
          print('..................$savedDir');
          try{
            final id = await FlutterDownloader.enqueue(
              url: 'https://psbdn.in/visitor-management/${widget.name}',
              headers: {},
              // optional: header send with url (auth token etc)
              savedDir: path,
              //fileName: 'File',
              showNotification: true,
              // show download progress in status bar (for Android)
              openFileFromNotification: true,
              // click on notification to open downloaded file (for Android)
              saveInPublicStorage: true,
            );
          } catch (e){
            print(e);
          }
          print('File downloaded');
        } else {
          print('My File path is null');
        }
      } else {
        MySnackbar.errorSnackBar('Download Failed', 'Gallery Permission not Granted');
        print('..........not granted!!');
      }
    } else {
       // MySnackbar.infoSnackBar('Please Allow Notification', 'Notification Permission not Granted');
        await AppSettings.openNotificationSettings();
        await Permission.notification.request();
          // if(notify.isGranted){
          //   print('my status.........permission granted');
          // }else{
          //   print('my status.........permission not granted');
          //   MySnackbar.infoSnackBar('Please Allow Notification', 'Notification Permission not Granted');
          // }
          FirebaseMessaging messaging = FirebaseMessaging.instance;
          NotificationSettings settings = await messaging.requestPermission(
            alert: true,
            announcement: false,
            badge: true,
            carPlay: false,
            criticalAlert: false,
            provisional: false,
            sound: true,
          );

          if (settings.authorizationStatus == AuthorizationStatus.authorized) {
            print('..................User granted permission');

          } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
            print('.......................User granted provisional permission');
            MySnackbar.infoSnackBar('Please Allow Notification', 'Notification Permission not Granted');
          } else {
            print('...................User declined or has not accepted permission');
            MySnackbar.infoSnackBar('Please Allow Notification', 'Notification Permission not Granted');
          }
    }
    //
    // FirebaseMessaging messaging = FirebaseMessaging.instance;
    // NotificationSettings settings = await messaging.requestPermission(
    //   alert: true,
    //   announcement: false,
    //   badge: true,
    //   carPlay: false,
    //   criticalAlert: false,
    //   provisional: false,
    //   sound: true,
    // );
    //
    // if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    //   print('User granted permission');
    //
    // } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    //   print('User granted provisional permission');
    // } else {
    //   print('User declined or has not accepted permission');
    // }
  }
  String? getFileExtension(String fileName) {
    try {
      return "." + fileName.split('.').last;
    } catch(e){
      return null;
    }
  }

  Widget getPdfView(String path)=>

      PDF().cachedFromUrl('https://psbdn.in/visitor-management/${widget.name}');
  int progress = 0;
  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    print(widget.name);

    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    _port.listen((message) {
      setState((){
        progress = message;
      });
    });
    FlutterDownloader.registerCallback(downloadCallBack);
    super.initState();
  }

  static downloadCallBack(id, status, progress) {
    final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send(progress);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, backgroundColor: AppColors.themeColor, title: const Text('Download')
      ),
      body: ListView(
      //  crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 25,),
          //const SizedBox(width: double.infinity,),
          // const Text('Attached File :'),
          const SizedBox(height: 20,),
          Container(
            height: 500,
           // color: Colors.grey[350],
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: getFileExtension('https://psbdn.in/visitor-management/${widget.name}')=='.pdf'?
            SfPdfViewer.network('https://psbdn.in/visitor-management/${widget.name}')
                : FadeInImage.assetNetwork(
                placeholder: 'assets/images/loading.gif',
                placeholderScale : 3,
                image:'https://psbdn.in/visitor-management/${widget.name}'
            )
              //Image.network('https://iwebnext.us/bookingsystem/${widget.name}', fit: BoxFit.contain),
          ),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _downloadFile();
                 // print(widget.name);
                 // download('https://iwebnext.us/bookingsystem/${widget.name}',widget.name.toString());
                },
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.themeColor)),
                child:
                Column(
                 children: [
                   const SizedBox(height: 2,),
                   Image.asset('assets/images/download_a.png',
                       width: 17,height: 22,fit: BoxFit.contain,color: Colors.white),
                   const SizedBox(height: 2),
                   const Text('     Download    ',
                       style: TextStyle(fontSize: 12,)
                   ),
                   const SizedBox(height: 2,),
                 ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// static Future saveInStorage(
  //     String fileName, File file, String extension) async {
  //   final status = await Permission.storage.request();
  //
  //   if(status.isGranted) {
  //    // await _checkPermission();
  //     String _localPath = (await ExtStorage.getExternalStoragePublicDirectory(
  //         ExtStorage.DIRECTORY_DOWNLOADS))!;
  //     String filePath =
  //         _localPath + "/" + fileName.trim() + "_" + Uuid().v4() + extension;
  //
  //     File fileDef = File(filePath);
  //     await fileDef.create(recursive: true);
  //     Uint8List bytes = await file.readAsBytes();
  //     await fileDef.writeAsBytes(bytes);
  //   }
  // }
  //
  // Future openFile(String url, String fileName) async {
  //   final myFile = await download(url,fileName);
  //   if(myFile == null) return;
  //   print('Path : ${myFile.path}');
  // //  OpenFile.open(myFile.path);
  // }
  //
  // Future<File?> download (String url, String fileName)async{
  //   final status = await Permission.storage.request();
  //
  //   if(status.isGranted) {
  //     final appStorage = await getApplicationDocumentsDirectory();
  //     final file = File('${appStorage.path}/$fileName');
  //    // File fileDef = File(file);
  //     await file.create(recursive: true);
  //     Uint8List bytes = await file.readAsBytes();
  //     await file.writeAsBytes(bytes);
  //     if(file.existsSync()){
  //       print('File path doesn\'t exist');
  //       print(file);
  //      // var myfilee =  new File('$file').create(recursive: true);
  //
  //     }
  //     try {
  //       print('object');
  //     final response = await Dio().get(url, options: Options(
  //       receiveTimeout: 0,
  //       responseType: ResponseType.bytes,
  //       followRedirects: false,
  //     ));
  //     final raf = file.openSync(mode: FileMode.write);
  //     raf.writeFromSync(response.data);
  //     await raf.close();
  //     return file;
  //   }catch (e){
  //     print(e);
  //     return null;
  //   }
  //   }else{
  //     print('Permission not Granted');
  //   }
  // }


/*
  Container(
            //height: 55,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.themeColorLight,
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3,
                  offset: Offset(
                    0,
                    3,
                  ),
                )
              ],
            ),
            child:
            Column(
              children: [
                const SizedBox(height: 20,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(width: 20,),
                    Expanded(
                        child: Image.network('https://iwebnext.us/bookingsystem/$name',height: 70)),
                    // Expanded(
                    //     child: Text('https://iwebnext.us/bookingsystem/$name')
                    // ),
                    const SizedBox(width: 20,),
                    InkWell(
                      onTap: () {

                      },
                      child: Container(
                        child: Column(
                          children: [
                            Image.asset('assets/images/download_a.png',
                                width: 17,height: 22,fit: BoxFit.contain),
                            const Text('Download',style: TextStyle(fontSize: 10,
                             )
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 20,),
                  ],
                ),
                const SizedBox(height: 20,),
              ],
            ),
          ),
 */
