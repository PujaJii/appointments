import 'dart:io';

import '../controller/create_appointment_controller.dart';
import '../controller/service_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../styles/app_colors.dart';
import '../styles/common_module/my_snack_bar.dart';
import '../styles/common_module/my_widgets.dart';
import '../utils/constants/size_orientation.dart';



class AddNew extends StatefulWidget {
  const AddNew({Key? key}) : super(key: key);

  @override
  State<AddNew> createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {


  CreateAppointmentController createController = Get.put(CreateAppointmentController());
  ServiceListController serviceListController = Get.put(ServiceListController());
  var box = GetStorage();
  final _formKey = GlobalKey<FormState>();
  String apType = '';
  String? apStatus;
  String serviceType = '';
  String id ='';
  // Duration _duration = Duration(hours: 0, minutes: 0);
  // TextEditingController durationTEC = TextEditingController();
  // TextEditingController _txtTimeController = TextEditingController();

  statusRec(){
    apType == 'Meeting' ?
    apStatus = 'Approved': apStatus = 'Pending';
  }

  List<String> appointmentType = ['Meeting','Visitors','VIP','Appointments','Deputation'];
  List<String> serviceTypeList = ['Pending','Approved',];

  @override
  void initState() {
    createController.dateTEC.text = ''; //set the initial value of text field
    createController.timeTEC.text = '';
    //durationTEC.text = '${_duration.inHours} : ${_duration.inHours}';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenContext.getScreenContext(context);
    if (ScreenContext.width! > 550) {
      ///tablets...............
      return Scaffold(
        // appBar: MyAppBars.myAppBar(
        //     context, box.read('avatar').toString(),box.read('role').toString()),
       body: GetX<ServiceListController> (initState: (context) {
        serviceListController.getServiceLists();
      }, builder: (controller) {
        if (controller.isLoading.value) {
          return Scaffold(body: Center(
              child: CircularProgressIndicator(color: AppColors.themeColor,)));
        } else {
          return Form(
               key: _formKey,
               child: ListView(
                children: [
                  const SizedBox(height: 25),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    child: TextFormField(
                      //keyboardType: TextInputType.datetime,
                        controller: createController.dateTEC,
                        validator: (input) =>
                        input!.isEmpty ? "Please Enter Date" : null,
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2100));

                          if (pickedDate != null) {
                            //  print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                            // print(formattedDate); //formatted date output using intl package =>  2021-03-16
                            setState(() {
                              createController.dateTEC.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {}
                        },
                        textInputAction: TextInputAction.next,
                        style: TextStyle(fontSize: 15, color: AppColors.black),
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(
                              fontSize: 14, color: Colors.grey),
                          fillColor: AppColors.white,
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 16.0),
                          hintText: '  Enter meeting date',
                          // labelText: '   Enter meeting date',
                          labelStyle: const TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontStyle: FontStyle.normal),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: AppColors.black,
                              )
                          ),
                        )
                    ),
                  ),

                  Container (
                    margin: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 7),
                    child: TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (input) =>
                        input!.isEmpty ? "Please Enter time" : null,
                        readOnly: true,
                        controller: createController.timeTEC,
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          );
                          if (pickedTime != null) {
                            // print(pickedTime.format(context));   //output 10:51 PM
                            DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                            //converting to DateTime so that we can further format on different pattern.
                            // print(parsedTime); //output 1970-01-01 22:53:00.000
                            String formattedTime = DateFormat('HH:mm').format(
                                parsedTime);
                            //print(formattedTime); //output 14:59:00
                            //DateFormat() is from intl package, you can format the time on any pattern you need.
                            setState(() {
                              createController.timeTEC.text =
                                  formattedTime; //set output date to TextField value.
                            });
                          } else {
                            print("Time is not selected");
                          }
                        },
                        textInputAction: TextInputAction.next,
                        style: TextStyle(fontSize: 15, color: AppColors.black),
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(
                              fontSize: 14, color: Colors.grey),
                          fillColor: AppColors.white,
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 16.0),
                          labelText: '   Enter meeting time',
                          labelStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontStyle: FontStyle.normal),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: AppColors.black,
                              )),
                        )
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 10),
                      child: TextFormField(
                        controller: createController.minutes,
                        validator: (input) =>
                        input!.isEmpty ? "Please Enter minutes" : null,
                        keyboardType: TextInputType.numberWithOptions(decimal: false),
                        decoration: InputDecoration(
                          hintText: 'Minutes',
                          fillColor: AppColors.white,
                          filled: true,
                          labelText: '   Enter Allowed time(In minutes)',
                          labelStyle: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                              fontStyle: FontStyle.normal),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 16.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: AppColors.black,
                              )
                          ),
                        ),
                      )
                  ),
                  Container(
                    //height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    child: DropdownButtonFormField(
                      validator: (input) =>
                      input == null ? "Please Enter a type" : null,
                      iconSize: 0,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 15),
                        //  icon: const Icon(Icons.keyboard_arrow_down_outlined),
                        suffixIcon: const Icon(
                            Icons.keyboard_arrow_down_outlined),
                        hintText: '     Select Entry Type',
                        hintStyle: const TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      items: appointmentType.map((String category) {
                        return DropdownMenuItem(value: category, child:
                        Text('   $category'));
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          apType = value!;
                          statusRec();
                          // print(apType);
                          // print(apStatus);
                        });
                      },
                    ),
                  ),
                  //const SizedBox(height: 12,),
                  apType == 'VIP'?
                  Container():
                  Container(
                    //height: 50,
                    margin: const EdgeInsets.only(left: 40,right: 40,top: 12),
                    child: DropdownButtonFormField(
                      validator: (input) =>
                      input == null ? "Please Appointment Status" : null,
                      iconSize: 0,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 15),
                        //  icon: const Icon(Icons.keyboard_arrow_down_outlined),
                        suffixIcon: const Icon(
                            Icons.keyboard_arrow_down_outlined),
                        hintText: '     Select Appointment Status',
                        hintStyle: const TextStyle(fontSize: 13),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      items: serviceTypeList.map((String category) {

                        return DropdownMenuItem(value: category, child:
                        Text('   $category'),
                        );
                      }).toList(),
                      value: apStatus,
                      onChanged: (String? value) {
                        setState(() {
                          // dropDownValue == 'Meeting' ?
                          apStatus = value!;
                          //print(apStatus);
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 5,),
                  apType == 'Visitors'|| apType == 'VIP'?
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                      //keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        controller: createController.nameTEC,
                        validator: (input) =>
                        input!.isEmpty ? "Please Enter Name" : null,
                        style: TextStyle(fontSize: 15, color: AppColors.black),
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(fontSize: 14,color: Colors.grey),
                          fillColor: AppColors.white,
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 16.0),
                          //  hintText: 'Enter Name',
                          labelText: '   Name of the recipient',
                          labelStyle: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                              fontStyle: FontStyle.normal),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: AppColors.black,
                              )),
                        )
                    ),
                  ):
                  Container(),
                  apType == 'Visitors'|| apType == 'VIP'?
                  Container(
                    //height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    child: DropdownButtonFormField(
                      validator: (input) =>
                      input == null ? "Please Enter a service type" : null,
                      iconSize: 0,
                      decoration: InputDecoration(
                        suffixIcon: const Icon(
                            Icons.keyboard_arrow_down_outlined),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 15),
                        hintText: '     Select Entry service Type',
                        hintStyle: const TextStyle(fontSize: 13),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      items: serviceListController.cats.map((var name) {
                        // var ab = controller.caiID.map((var el){
                        //   print(el);
                        // }).toList();
                        // id = ab.toString();
                        // print(category);
                        return DropdownMenuItem(value: name.split('_').last,
                            child: Text('   ${name.split('_').first}'));
                      }).toList(),
                      onChanged: (var value) {
                        setState(() {
                          serviceType = value.toString();
                          print('cate id: $value');
                          // print(serviceType);
                        });
                      },
                    ),
                  ):
                  Container(),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 8),
                    child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.name,
                        controller: createController.subjectTEC,
                        validator: (input) =>
                        input!.isEmpty ? "Please Enter subject" : null,
                        textInputAction: TextInputAction.next,
                        maxLines: 3,
                        style: TextStyle(fontSize: 15, color: AppColors.black),
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(
                              fontSize: 14, color: Colors.grey),
                          fillColor: AppColors.white,
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 16.0),
                          hintText: '   Enter purpose/subject....',
                          // labelText: '   Enter purpose/subject....',
                          // labelStyle: const TextStyle(
                          //     fontSize: 13,
                          //     color: Colors.black,
                          //     fontStyle: FontStyle.normal),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: AppColors.black,
                              )
                          ),
                        )
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 8),
                    child: TextFormField(
                      //keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        controller: createController.videoLink,
                        // validator: (input) =>
                        // input!.isEmpty ? "Enter Video Link" : null,
                        style: TextStyle(fontSize: 15, color: AppColors.black),
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.black),
                          fillColor: AppColors.white,
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 16.0),
                          //  hintText: 'Enter Name',
                          labelText: '   Enter Video Link',
                          labelStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontStyle: FontStyle.normal),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: AppColors.black,
                              )
                          ),
                        )
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      getImage(ImageSource.gallery);
                    },
                    child: Container(
                      height: 60,
                      //  width: 300,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 5),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black87)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          imgName == '' ?
                          Expanded(
                              child: MyWidgets.textView('      Attach a file',
                                  Colors.grey, 14))
                              : Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    imgName,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.black,fontSize: 14))
                              )
                          ),
                          Container(
                            height: double.infinity,
                            // width: 75,
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: AppColors.themeColor,
                                borderRadius: BorderRadius.circular(7.5)
                            ),
                            child: Center(child: MyWidgets.textView(
                                'Choose file', Colors.white, 13)),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        //width: 250,
                        height: 45,
                        margin: const EdgeInsets.symmetric(horizontal: 20,),
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    AppColors.themeColorTwo),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    )
                                )
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                createController.createAppointment(apType,apStatus!,serviceType,imgPath: filePath);
                              }
                            },
                            child: MyWidgets.textView(
                                "  Create Appointment  ", AppColors.white, 14)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
        }
      }),
      );
    }
    ///phones...............
    return  Scaffold(
      // appBar: MyAppBars.myAppBar(
      //     context, box.read('avatar').toString(),box.read('role').toString()),
      body: GetX<ServiceListController>(initState: (context) {
      serviceListController.getServiceLists();
    }, builder: (controller) {
      if (controller.isLoading.value) {
        return Scaffold(
            body: Center(
                child: CircularProgressIndicator(color: AppColors.themeColor,)
            )
        );
      } else {
        return Form(
            key: _formKey,
            child: ListView(
              //  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 15),
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 25, vertical: 7),
                  child: TextFormField(
                    //keyboardType: TextInputType.datetime,
                      controller: createController.dateTEC,
                      validator: (input) =>
                      input!.isEmpty ? "Please Enter Date" : null,
                      readOnly: true,
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
                          setState(() {
                            createController.dateTEC.text =
                                formattedDate; //set output date to TextField value.
                          });
                        } else {}
                      },
                      textInputAction: TextInputAction.next,
                      style: TextStyle(fontSize: 15, color: AppColors.black),
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                            fontSize: 13, color: Colors.grey),
                        fillColor: AppColors.white,
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 16.0),
                        hintText: '  Enter meeting date',

                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: AppColors.black,
                            )
                        ),
                      )
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 25, vertical: 7),
                  child: TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (input) =>
                      input!.isEmpty ? "Please Enter time" : null,
                      readOnly: true,
                      controller: createController.timeTEC,
                      onTap: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                          initialTime: TimeOfDay.now(),
                          context: context,
                        );
                        if (pickedTime != null) {
                          // print(pickedTime.format(context));   //output 10:51 PM
                          DateTime parsedTime = DateFormat.jm().parse(
                              pickedTime.format(context).toString());
                          //converting to DateTime so that we can further format on different pattern.
                          // print(parsedTime); //output 1970-01-01 22:53:00.000
                          String formattedTime = DateFormat('HH:mm').format(
                              parsedTime);
                          //print(formattedTime); //output 14:59:00
                          //DateFormat() is from intl package, you can format the time on any pattern you need.
                          // var myDate = TimeOfDay.now();
                          if(formattedTime == TimeOfDay.now().toString()){
                            print('Set time');
                          }else{
                            print('failed');
                            print('TimeOfDay($formattedTime)');
                            print(TimeOfDay.now());
                          }
                          setState(() {
                            createController.timeTEC.text =
                                formattedTime; //set output date to TextField value.
                          });
                        } else {
                          print("Time is not selected");
                        }
                      },
                      textInputAction: TextInputAction.next,
                      style: TextStyle(fontSize: 15, color: AppColors.black),
                      decoration: InputDecoration(
                        hintText: '   Enter meeting time',
                        hintStyle: const TextStyle(
                            fontSize: 13, color: Colors.grey),
                        fillColor: AppColors.white,
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 16.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: AppColors.black,
                            )),
                      )
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 25, vertical: 7),
                  child: TextFormField(
                    controller: createController.minutes,
                    validator: (input) =>
                    input!.isEmpty ? "Please Enter minutes" : null,
                    keyboardType: TextInputType.numberWithOptions(decimal: false),
                    decoration: InputDecoration(
                      hintText: 'Minutes',
                      hintStyle: const TextStyle(
                          color: Colors.grey,fontSize: 13,
                      ),
                      fillColor: AppColors.white,
                      filled: true,
                      labelText: '   Enter Allowed time(In minutes)',
                      labelStyle: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          fontStyle: FontStyle.normal),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: AppColors.black,
                          )
                      ),
                    ),
                  )
                ),
                Container(
                  //height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  child: DropdownButtonFormField(
                    validator: (input) =>
                    input == null ? "Please Enter a type" : null,
                    iconSize: 0,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 15),
                      //  icon: const Icon(Icons.keyboard_arrow_down_outlined),
                      suffixIcon: const Icon(
                          Icons.keyboard_arrow_down_outlined),
                      hintText: '     Select Entry Type',
                      hintStyle: const TextStyle(fontSize: 13),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    items: appointmentType.map((String category) {
                      return DropdownMenuItem(value: category, child:
                      Text('   $category'));
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        apType = value!;
                        statusRec();
                        // print(apType);
                        // print(apStatus);
                      });
                    },
                  ),
                ),
               // const SizedBox(height: 12,),
                apType == 'VIP'?
                Container():
                Container(
                  //height: 50,
                  margin: const EdgeInsets.only(left: 25,right: 25,top: 10),
                  child: DropdownButtonFormField(
                      validator: (input) =>
                      input == null ? "Please Appointment Status" : null,
                      iconSize: 0,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 15),
                        //  icon: const Icon(Icons.keyboard_arrow_down_outlined),
                        suffixIcon: const Icon(
                            Icons.keyboard_arrow_down_outlined),
                        hintText: '     Select Appointment Status',
                        hintStyle: const TextStyle(fontSize: 13),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      items: serviceTypeList.map((String category) {
                        return DropdownMenuItem(value: category, child:
                        Text('   $category'),
                        );
                      }).toList(),
                      value: apStatus,
                    onChanged: (String? value) {
                      setState(() {
                        // dropDownValue == 'Meeting' ?
                        apStatus = value!;
                        //print(apStatus);
                      });
                    },
                  ),
                ),
                const SizedBox(height: 5,),
                apType == 'Visitors' || apType == 'VIP'?
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 25, vertical: 10),
                  child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                    //keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      controller: createController.nameTEC,
                      validator: (input) =>
                      input!.isEmpty ? "Please Enter Name" : null,
                      style: TextStyle(fontSize: 15, color: AppColors.black),
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(color: Colors.black),
                        fillColor: AppColors.white,
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 16.0),
                        //  hintText: 'Enter Name',
                        labelText: '   Name of the recipient',
                        labelStyle: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                            fontStyle: FontStyle.normal),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: AppColors.black,
                            )),
                      )
                  ),
                ) :
                Container(),
                apType == 'Visitors' || apType == 'VIP'?
                Container(
                  //height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  child: DropdownButtonFormField(
                    validator: (input) =>
                    input == null ? "Please Enter a service type" : null,
                    iconSize: 0,
                    decoration: InputDecoration(
                      suffixIcon: const Icon(
                          Icons.keyboard_arrow_down_outlined),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 15),
                      hintText: '     Select Entry service Type',
                      hintStyle: const TextStyle(fontSize: 13),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    items: serviceListController.cats.map((var name) {

                      return DropdownMenuItem(value: name.split('_').last,
                          child: Text('   ${name.split('_').first}'));
                    }).toList(),
                    onChanged: (var value) {
                      setState(() {
                        serviceType = value.toString();
                      //  print('cate id: $value');
                        // print(serviceType);
                      });
                    },
                  ),
                ):
                Container(),
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 25, vertical: 8),
                  child: TextFormField(
                    //keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      controller: createController.videoLink,
                      // validator: (input) =>
                      // input!.isEmpty ? "Enter Video Link" : null,
                      style: TextStyle(fontSize: 15, color: AppColors.black),
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(color: Colors.black),
                        fillColor: AppColors.white,
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 16.0),
                        //  hintText: 'Enter Name',
                        labelText: '   Enter Video Link',
                        labelStyle: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                            fontStyle: FontStyle.normal),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: AppColors.black,
                            )
                        ),
                      )
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 25, vertical: 8),
                  child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.name,
                      controller: createController.subjectTEC,
                      validator: (input) =>
                      input!.isEmpty ? "Please Enter subject" : null,
                      textInputAction: TextInputAction.newline,
                      maxLines: 3,
                      style: TextStyle(fontSize: 15, color: AppColors.black),
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                            fontSize: 13, color: Colors.grey),
                        fillColor: AppColors.white,
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 16.0),
                        hintText: '   Enter purpose/subject....',
                        labelText: '   Enter subject....',
                        labelStyle: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                            fontStyle: FontStyle.normal),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: AppColors.black,
                            )
                        ),
                      )
                  ),
                ),
                InkWell(
                  onTap: () {
                    getImage(ImageSource.gallery);
                  },
                  child: Container(
                    height: 60,
                    //  width: 300,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 5),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black87)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        imgName == '' ?
                        Expanded(
                            child: MyWidgets.textView('      Attach a file',
                                Colors.grey, 14))
                            : Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  imgName,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.black,fontSize: 14)),
                            )
                        ),
                        Container(
                          height: double.infinity,
                          // width: 75,
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: AppColors.themeColor,
                              borderRadius: BorderRadius.circular(7.5)
                          ),
                          child: Center(child: MyWidgets.textView(
                              'Choose file', Colors.white, 13)),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      //width: 250,
                      height: 45,
                      margin: const EdgeInsets.symmetric(horizontal: 20,),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  AppColors.themeColorTwo),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  )
                              )
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              createController.createAppointment(apType,apStatus!,serviceType,imgPath: filePath);
                            }
                          },
                          child: MyWidgets.textView(
                              "  Create Appointment  ", AppColors.white, 14)),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
              ],
            ),
          );
      }
    }),
    );
  }

  //PlatformFile? pickedFiles;

 //var selectedImagePath = ''.obs;
  String imgName ='';
  String filePath ='';
  File file = File('');
  void getImage(ImageSource imageSource) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );

    if (result != null) {
      //file = File(result.files.single.path!);
      filePath = result.files.single.path!;
      imgName = result.files.single.name.toString();
      // print('file type -------------------------------${file.toString()}');
      // print('file type1 -------------------------------${filePath}');
      setState((){});
    } else {
      // User canceled the picker
      MySnackbar.infoSnackBar(
          'No Image selected', 'Please select a image ');
    }
    // final pickedFile = await ImagePicker().getImage(source: imageSource);
    // final pickedFile = await ImagePicker().pickImage(source: imageSource);
    // if (pickedFile != null) {
    //   selectedImagePath.value = pickedFile.path;
    //   imgName = pickedFile.name;
    //   setState((){});
    //   print('file type -------------------------------${selectedImagePath.value}');
    //   // imgName = pickedFile.path.toString();
    // } else {
    //   MySnackbar.infoSnackBar(
    //       'No Image selected', 'Please select a image ');
    // }
  }
}
