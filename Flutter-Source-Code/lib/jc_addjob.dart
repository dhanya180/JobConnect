import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:convert'; 
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart'; 
import 'package:csc_picker/csc_picker.dart';
import 'package:jobconnect_app/models/get_jobtypes_model.dart';
import 'package:jobconnect_app/services/addJob_api_service.dart';
import 'package:jobconnect_app/services/getjobtypes_api_service.dart';
//import 'package:jobconnect_app/services/datetimefile.dart';
import 'package:jobconnect_app/services/dateconvertfile.dart';
import 'package:jobconnect_app/currentuser.dart';

class AddJobScreen extends StatelessWidget {
  const AddJobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData( scaffoldBackgroundColor:  const Color.fromRGBO(255, 255, 255,1),),
      home: Scaffold(
        appBar: AppBar(
                      centerTitle: true,
                      backgroundColor: const Color.fromRGBO(255, 255, 255,1),
                      leading: IconButton( icon: const Icon(Icons.arrow_left, size: 50,), onPressed: () { Navigator.pop(context); },  ),
                      actions: const [
                         /* IconButton(
                            icon: const Icon(Icons.list), 
                            onPressed: (){
                              //code to execute when this button is pressed
                            }
                          ),*/
                          //more widgets to place here
                          ],
          elevation: 20,
          
          title: const Text('JobConnect',  style: TextStyle(color: Color.fromARGB(255, 122, 113, 164), fontWeight: FontWeight.bold, fontSize: 30),)

          ),
        
        body: const AddJobPage(),
      ),
      //home: Home(),
    );
  }
}



class AddJobPage extends StatefulWidget {
  const AddJobPage({super.key});



@override 
State<AddJobPage> createState() => AddJobState(); 
} 

class AddJobState extends State<AddJobPage> { 
  late List<Jobtypes>? _jobtypesModel = [];
static final _formkey = GlobalKey<FormState>();

   static const List<String> pay_frequency_list = <String>['Daily', 'Weekly', 'Monthly', 'Annual'];
   List<String> jobsList = ["Others"];
   //static final _addjobformkey = GlobalKey<FormState>();

  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";
  String Job_Id = "";
  String GetJobTypes = "TRUE";

    String dropdownvalue = 'Others';
    bool passwordVisible=true; 
    bool reEnterPasswordVisible=true; 
    
  final TextEditingController country = TextEditingController(); 
  final TextEditingController state = TextEditingController(); 
  final TextEditingController city = TextEditingController();
  final TextEditingController NewJobType = TextEditingController();
   bool newsetval = false;

   final Login_Type = TextEditingController();
   final Job_Type = TextEditingController();
   final Date_From = TextEditingController();
   final Date_To = TextEditingController();
   final Job_Description = TextEditingController();
   final Job_Openings = TextEditingController();
   final Payment_Frequency = TextEditingController();
   final Job_Street = TextEditingController();
   final Wage_Minimum = TextEditingController();
   final Wage_Maximum = TextEditingController();
   final Job_Pincode = TextEditingController();
   final Email = TextEditingController();

   
  
    @override
  void initState() {
    super.initState();
    _getJobTypesData();
  }



  void _getJobTypesData() async {
    _jobtypesModel = (await PostJobTypesApiService().getJobTypes())!;

      Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {


                for (int i = 0; i < _jobtypesModel!.length; i++){

                    jobsList.add(_jobtypesModel![i].jobType);

                }
          }
      )
      );


      /* if ((_jobTypesModel) != null)
       {
           setState(() {});

       } */
  
  }

    @override
  void dispose() {
    // Clean up the controller when the widget is disposed.

    Email.dispose();
    Login_Type.dispose();
    Job_Type.dispose();
    Date_From.dispose();
    Date_To.dispose();
    Job_Description.dispose();
    Job_Openings.dispose();
    Payment_Frequency.dispose();
    Job_Street.dispose();
    Wage_Minimum.dispose();
    Wage_Maximum.dispose();
    Job_Pincode.dispose();
    NewJobType.dispose();
    super.dispose();
  }
/*

    void _postjobTypesData() async {
    final Status = (await PostJobTypesApiService().getJobTypes());

      Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
      log('Get Job Types status is ',  name: Status);
      if (Status == "Success")
      {

      }
     
  }
*/

void clearFields() {
    //fieldText.clear();
        Email.clear();
    Login_Type.clear();
  //  Job_Type.clear();
    Date_From.clear();
    Date_To.clear();
    Job_Description.clear();
    Job_Openings.clear();
    //Payment_Frequency.clear();
    Job_Street.clear();
    Wage_Minimum.clear();
    Wage_Maximum.clear();
    Job_Pincode.clear();
    //NewJobType.clear();
   // super.dispose();
  }



    void _postAddJobData(String newrequest) async {

      log('request before passing ',  name: newrequest);
    final Status = (await PostNewJobApiService().addJob(newrequest));

      Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
      log('Job status is ',  name: Status);
      if (Status.toUpperCase() == "JOB ADDED")
      {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                                title: const Text("Job Status"),
                                content: const Text("Your job has been added.\nWhen Job Seekers apply, You will get Email Notification."),
                                actions: [ TextButton(onPressed: () => {Navigator.pop(context),
                               // Navigator.of(context).pushNamed('/welcome'), 
                               clearFields(),
                                }, child: const Text('OK')) ]
                            )
                     );// showDialog
                  
      }

  }
  

  @override
  Widget build(BuildContext context) {
   
  

  // List of items in our dropdown menu 
  /*   if (GetJobTypes == "TRUE")
     {
      GetJobTypes = "FALSE";
        _getJobTypesData();
     }
     */

   // return MaterialApp(
   return Form(
       key: _formkey, 
     // debugShowCheckedModeBanner: false,
      child: Scaffold
      (
        body: SafeArea(
        child: SingleChildScrollView(
          child: Card(
            child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(height: 0),
                 const Column(
                        children: <Widget>[ SizedBox(height: 20.0),
                                Text("New Job Posting", style: TextStyle(color: Color.fromARGB(255, 122, 113, 164), fontSize: 20, fontWeight: FontWeight.bold, ),),
                                          ],
                       ),
                       const SizedBox(height: 16),
                              Row(
                  children: <Widget>[
                      Expanded( child:DropdownMenu<String>( width: 180.0, //initialSelection: jobsList.first,
                                  hintText: "Job Type", 
                                  inputDecorationTheme: InputDecorationTheme( isDense: true, 
                                     contentPadding: const EdgeInsets.all(10), constraints: const BoxConstraints(maxWidth: 180),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
                                  ),
                                 
                                  onSelected: (String? value) {setState(() {dropdownvalue = value!; 
                                                  if (dropdownvalue == "Others"){
                                                      NewJobType.text = "";
                                                      newsetval = true;
                                                  }
                                                  else {
                                                      NewJobType.text = dropdownvalue;
                                                      newsetval = false;
                                                      }
                                                      setState(() {  });                                 
                                  
                                              }   ); },
                                  dropdownMenuEntries: jobsList.map<DropdownMenuEntry<String>>((String value) 
                                  {return DropdownMenuEntry<String>(value: value, label: value);  }).toList(),
                                                  ),
                              ),
                      const SizedBox(width: 5), 
                      Expanded(child: TextFormField(
                                enabled: newsetval,
                                validator: MultiValidator([ 
                                RequiredValidator(errorText: 'Your new Job Type'), 
                                MinLengthValidator(1, errorText: 'Your new Job Type'), ]).call, 
                                controller: NewJobType,
                                decoration: InputDecoration( hintText: "Your new Job Type",
                                                            //border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(3)),),
                                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(18),),
                                                            prefixIcon: const Icon(Icons.work)),
                                style: const TextStyle(fontSize: 14),
                                          ),
                                ),

                                ],
                ),
                const SizedBox(height: 7), 
                 Column(
                        children: <Widget>[

                            TextFormField(
                                keyboardType: TextInputType.multiline, minLines: 1, maxLines: 5, 
                                validator: MultiValidator([ 
                                RequiredValidator(errorText: 'Please enter Job Description'), 
                                MinLengthValidator(3, errorText: 'Joob description cant be less than 3 characters'), ]).call, 
                                controller: Job_Description,
                                decoration: InputDecoration( hintText: "Job description",
                                                            //border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(3)),),
                                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(18),),
                                                            prefixIcon: const Icon(Icons.note)),
                                style: const TextStyle(fontSize: 14),
                                          ),
                                const SizedBox(height: 7),



 
                       ],
                    ),
 
              Row(
                  children: <Widget>[
                      Expanded(child: TextFormField(

                                
                                validator: MultiValidator([ 
                                RequiredValidator(errorText: 'Number of Vacancies please'), 
                                MinLengthValidator(1, errorText: 'Number of Vacancies please'), ]).call, 
                                controller: Job_Openings,
                                decoration: InputDecoration( hintText: "Vacancies",
                                                            //border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(3)),),
                                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(18),),
                                                            prefixIcon: const Icon(Icons.hourglass_empty),  counterText: "",),
                                style: const TextStyle(fontSize: 14),
                                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),],
                                keyboardType: TextInputType.number, maxLength: 3, 
                                          ),
                                ),
                      const SizedBox(width: 5), 
                      Expanded( child:DropdownMenu<String>( width: 200.0, initialSelection: pay_frequency_list.first,

                                  inputDecorationTheme: InputDecorationTheme( isDense: true, 
                                     contentPadding: const EdgeInsets.all(10), constraints: const BoxConstraints(maxWidth: 188),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
                                  ),
                                 
                                  onSelected: (String? value) {setState(() {Payment_Frequency.text = value!; }); },
                                  dropdownMenuEntries: pay_frequency_list.map<DropdownMenuEntry<String>>((String value) 
                                  {return DropdownMenuEntry<String>(value: value, label: value);  }).toList(),
                                                  ),
                              )

                                ],
                ),
              const SizedBox(height: 7, width: 5),

              Row(
                  children:<Widget>[
                      Expanded(child:TextFormField(
                              validator: MultiValidator([RequiredValidator(errorText: 'Please select Job start date'),]).call,
                              controller: Date_From,
                              decoration: InputDecoration( hintText: "Job Start Date",
                                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(18),),
                                                            prefixIcon: const Icon(Icons.calendar_today)),
                              style: const TextStyle(fontSize: 14),
                              readOnly: true,  // when true user cannot edit text 
                              onTap: () async {
                                DateTime? pickedDate = DateTime.now();
                                        
                                         pickedDate = await showDatePicker( context: context,
                                                              initialDate: DateTime.now(), //get today's date
                                                              firstDate:DateTime.now(), // if previous year needed then give year 
                                                              lastDate: DateTime(2101) );
                                                        /*   DateTime ourDateExample = DateTime.now();
                                                            final ourDate = ourDateExample.showDateInOwnFormat(); */
                                                   setState(() { if ((pickedDate) != null) { Date_From.text = (pickedDate.showDateInOwnFormat()[0]); }; });
                                                                                                  }
                                          ),
                                ),
 
                      const SizedBox(width: 5),
                      Expanded(child:TextFormField(
                              controller: Date_To,
                              decoration: InputDecoration( hintText: "Job end date",
                                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(18),),
                                                            prefixIcon: const Icon(Icons.calendar_today)),
                              style: const TextStyle(fontSize: 14),
                              readOnly: true,  // when true user cannot edit text 
                              onTap: () async {
                                 DateTime? selectedDate = DateTime.now();
                                        selectedDate = await showDatePicker( context: context,
                                                              initialDate: DateTime.now(), //get today's date
                                                              firstDate:DateTime.now(), // if previous year needed then give year 
                                                              lastDate: DateTime(2101) );
                                                        /*   DateTime ourDateExample = DateTime.now();
                                                            final ourDate = ourDateExample.showDateInOwnFormat(); */
                                                    setState(() { if ((selectedDate) != null) { Date_To.text = (selectedDate.showDateInOwnFormat()[0]); }; });
                                                                                                  }
                                          ),
                                ),
                            ],
                  ),//
                  const SizedBox(height: 7, width: 5), 
              Row(
                  children:<Widget>[
                     Expanded(child: TextFormField(
                                validator: MultiValidator([ 
                                RequiredValidator(errorText: 'Please enter minimum wage in Rs.'), 
                                MinLengthValidator(2, errorText: 'Minimum wage cant be less than 2 characters'), ]).call, 
                                controller: Wage_Minimum,
                                decoration: InputDecoration( hintText: "Minimum Wage",
                                                            //border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(3)),),
                                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(18),),
                                                            prefixIcon: const Icon(Icons.currency_rupee), counterText: "",),
                                style: const TextStyle(fontSize: 14),
                                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),],
                                keyboardType: TextInputType.number, maxLength: 7,
                                          ),
                                ),
                                const SizedBox(width: 5), 
                      Expanded(child: TextFormField(
                                validator: MultiValidator([ 
                                RequiredValidator(errorText: 'Please enter maximum wage in Rs.'), 
                                MinLengthValidator(2, errorText: 'Maximum wage cant be less than 2 characters'), ]).call, 
                                controller: Wage_Maximum,
                                decoration: InputDecoration( hintText: "Maximum Wage",
                                                            //border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(3)),),
                                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(18),),
                                                            prefixIcon: const Icon(Icons.currency_rupee), counterText: "",),
                                style: const TextStyle(fontSize: 14),
                                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),],
                                keyboardType: TextInputType.number, maxLength: 7,
                                          ),
                                ),
                                
                                   ],
                  ),//
                   const SizedBox(height: 7, width: 5), 

Container(
  padding: const EdgeInsets.symmetric(horizontal: 1),
  height: 100,
  child: Column(
    children: [
      ///Adding CSC Picker Widget in app
      CSCPicker(
        ///Enable disable state dropdown [OPTIONAL PARAMETER]
        showStates: true,

        /// Enable disable city drop down [OPTIONAL PARAMETER]
        showCities: true,

        ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
        flagState: CountryFlag.DISABLE,

        ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
        dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
           // color: Colors.white,
            border: Border.all(color: const Color.fromARGB(255, 70, 69, 69), width: 1) 
            ),

        ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
        disabledDropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            //color: Colors.grey.shade300,
            border: Border.all(color: const Color.fromARGB(255, 70, 69, 69), width: 1) 
            ),

        ///placeholders for dropdown search field
        countrySearchPlaceholder: "Country",
        stateSearchPlaceholder: "State",
        citySearchPlaceholder: "City",

        ///labels for dropdown
        countryDropdownLabel: "Country",
        stateDropdownLabel: "State",
        cityDropdownLabel: "City",

        ///Default Country
        defaultCountry: CscCountry.India,

        //Disable country dropdown (Note: use it with default country)
       // disableCountry: true,

        ///Country Filter [OPTIONAL PARAMETER]
       // countryFilter: [CscCountry.India,CscCountry.United_States,CscCountry.Canada],

        ///selected item style [OPTIONAL PARAMETER]
       selectedItemStyle: const TextStyle(
          //color: Colors.black,
          fontSize: 14,
        ),

        ///DropdownDialog Heading style [OPTIONAL PARAMETER]
        dropdownHeadingStyle: const TextStyle(
            //color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold),

        ///DropdownDialog Item style [OPTIONAL PARAMETER]
        dropdownItemStyle: const TextStyle(
          //color: Colors.black,
          fontSize: 14,
        ), 

        ///Dialog box radius [OPTIONAL PARAMETER]
        dropdownDialogRadius: 10.0,

        ///Search bar radius [OPTIONAL PARAMETER]
        searchBarRadius: 10.0,

        ///triggers once country selected in dropdown
        onCountryChanged: (value) {
          setState(() {
            ///store value in country variable
            countryValue = value;
          });
        }, 
        ///triggers once state selected in dropdown
        onStateChanged: (value) {
          setState(() {
            ///store value in state variable
            stateValue = value.toString();
          });
        },

        ///triggers once city selected in dropdown
        onCityChanged: (value) {
          setState(() {
            ///store value in city variable
            cityValue = value.toString();
          });
        },
      ),
//address = "$cityValue, $stateValue, $countryValue";

    ],
  )),

                Row(
                  children: <Widget>[

                       Expanded(child: TextFormField(
                                validator: MultiValidator([RequiredValidator(errorText: 'Enter Street name'), ]).call, 
                                controller: Job_Street,
                                decoration: InputDecoration( hintText: "Street",
                                                             //border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(3)),  ),
                                                             border: OutlineInputBorder(borderRadius: BorderRadius.circular(18),),
                                                             prefixIcon: const Icon(Icons.email)),
                                style: const TextStyle(fontSize: 14),
                                         ),
                       ),
                  ],
                ),
                                const SizedBox(height: 7),

                Row(
                  children: <Widget>[
                      Expanded(child: TextFormField(
                                validator: MultiValidator([ 
                                RequiredValidator(errorText: 'Pincode please'), 
                                MinLengthValidator(6, errorText: 'Please enter 6 digit Pincode'), ]).call, 
                                controller: Job_Pincode,
                                decoration: InputDecoration( hintText: "Pincode",
                                                            //border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(3)),),
                                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(18),),
                                                            prefixIcon: const Icon(Icons.post_add), counterText: "",),
                                style: const TextStyle(fontSize: 14), maxLength: 6,
                                          ),
                                ),
                                ]
                                ),

            const SizedBox(height: 12), 
            Container(
                    padding: const EdgeInsets.only(top: 2, left: 3),
                    child: ElevatedButton( onPressed: () { 
                   if (_formkey.currentState!.validate()) { 
                

                    DateTime ourDateExample = DateTime.now();
                  //  final CurJobId = (ourDateExample.showDateInOwnFormat()).replaceAll(r'-', '');
                  List<String> newdatetime = ourDateExample.showDateInOwnFormat();

                  final CurJobId = newdatetime[0].replaceAll(r'-', '') + newdatetime[1];
                    log('new job id', name: CurJobId);
                    //     log('value received', name: _jobtypesModel![0].jobType);
                    //     log('temp userMobile is ',  name: CurUserMobile);
                /*    log('before josn', name: Login_Id.value.text);
                    log('before josn', name: Mobile_Number.value.text);
                    log('before josn', name: Password.value.text);
                    log('before josn', name: User_Name.value.text);
                    log('before josn', name: Age.value.text);
                    log('before josn', name:  Profession.value.text);
                    log('before josn', name: Experience_Years.value.text );
                    log('before josn', name: Email.value.text);
                    log('before json',  name: cityValue);
                    log('before json',  name: stateValue); */
                    if ( (Payment_Frequency.value.text).isEmpty ) {

                            Payment_Frequency.text = pay_frequency_list[0];
                    }

                   String addJobDetails = jsonEncode(
                    {
                              "Login_Id": CurrentUser.Login_Id,
                              "Job_Id": CurJobId,
                              "Job_Type": NewJobType.value.text.toUpperCase(),
                              "Date_From": Date_From.value.text,
                              "Date_To": Date_To.value.text,
                              "Job_Description": Job_Description.value.text,
                              "Job_Openings": Job_Openings.value.text,
                              "Job_Status": "AVAILABLE",
                              "Job_Street": Job_Street.value.text,
                              "Job_City": cityValue,
                              "Job_State": stateValue,
                              "Job_Pincode": Job_Pincode.value.text,
                              "Payment_Frequency": Payment_Frequency.value.text,
                              "Wage_Minimum": Wage_Minimum.value.text,
                              "Wage_Maximum": Wage_Maximum.value.text,
                              "Name_JP": CurrentUser.User_Name,
                              "Mobile_Number_JP": CurrentUser.Mobile_Number,
                              "Email_JP": CurrentUser.Email,
                              "Lattitude":"",
                              "Longtitude": ""
                    }
                   );
                   log('composed-update-request ', name: addJobDetails);
                   _postAddJobData(addJobDetails);
                    }
                     },
                            style: ElevatedButton.styleFrom(shape: const StadiumBorder(),
                                                            padding: const EdgeInsets.symmetric(vertical: 12),
                                                            backgroundColor: const Color.fromARGB(255, 91, 142, 91),
                                                            ),
                            child: const Text("Submit Job",style: TextStyle(  fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),),
                                          )
                      ),
                  const SizedBox(height: 20),
                ],

              ),
             
            ),
          ),
        )
      ),
    );
  } //widget build
}