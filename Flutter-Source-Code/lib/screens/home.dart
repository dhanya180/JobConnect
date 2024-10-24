import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jobconnect_app/models/get_jobs_model.dart';
import 'package:jobconnect_app/services/getjobs_api_service.dart';
import 'package:jobconnect_app/jc_addjob.dart';
import 'package:jobconnect_app/services/jobprogress_api_service.dart';
import 'package:jobconnect_app/services/getjobtypes_api_service.dart';
import 'package:jobconnect_app/currentuser.dart';
import 'dart:async';
import 'package:jobconnect_app/models/get_jobtypes_model.dart';



class ShowJobsScreen extends StatelessWidget {
  const ShowJobsScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
            routes: {
                 '/addJob': (context) => const AddJobScreen(),
                 '/jobspage': (context) => const ShowJobsScreen(),
              },

      theme: ThemeData( scaffoldBackgroundColor:  const Color.fromRGBO(255, 255, 255,1),),
      home: Scaffold(
        appBar: AppBar(
          
                      centerTitle: true,
                      leading: IconButton( icon: const Icon(Icons.time_to_leave), onPressed: () { Navigator.pop(context); },),
                      backgroundColor: const Color.fromRGBO(255, 255, 255,1),
                      elevation: 10,
                      title: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan( text: "JobConnect", style: const TextStyle(color: Color.fromARGB(255, 122, 113, 164), fontWeight: FontWeight.bold, fontSize: 16),
                                                        children: <TextSpan>[
                                                                    TextSpan( text: '\n Welcome ${CurrentUser.User_Name}',
                                                                    style: const TextStyle(color: Color.fromARGB(255, 122, 113, 164), fontWeight: FontWeight.bold, fontSize: 9),
                                                                    ),
                                                                            ]
                                                  ),
                                      ),
                   //   title: const Text('JobConnect',  style: TextStyle(color: Color.fromARGB(255, 122, 113, 164), fontWeight: FontWeight.bold, fontSize: 30),),
          ),


        body: const Home(),
      ),
      
    );
    
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<JobDetails>? _jobModel = [];
  final Asking_Wage = TextEditingController();
  final List<String> AskingWages = [];
  late List<Jobtypes>? _jobtypesModel = [];
  List<String> jobsList = [];
  List<String>  JobStatusList = <String>['AVAILABLE', 'REQUESTED', 'ACCEPTED', 'REQUEST_CANCELLED', 'ACCEPT_CANCELLED', 'DECLINED'];
  List<String>  nextActionList_JS = <String>['Request', 'Cancel', 'Cancel', 'Agree', 'Agree', 'Agree', 'Agree', 'Agree'];
  List<String>  nextActionList_JP = <String>['Delete', 'Accept/Decline', 'Cancel', 'Agree', 'Agree', 'Agree', 'Agree', 'Agree'];
  List<bool> showOption = <bool> [true, true, true, false, false, false,  false, false];
  bool enabledForAvailableOnly = false;
  String JobTypeFilter = 'Others';

  void handleRole(int item) {
            switch (item) {
              case 0:
                CurrentUser.Login_Type = "JS";
                CurrentUser.Login_Type_Description = "Job Seeker";
                if ((JobStatusList.contains("DELETED")))
                {
                    JobStatusList.remove("DELETED");
                    JobStatusList.remove("READY");
                }

                enabledForAvailableOnly = true;
                break;
              case 1:
                CurrentUser.Login_Type = "JP";
                CurrentUser.Login_Type_Description = "Job Provider";
                if (!(JobStatusList.contains("DELETED")))
                {
                      JobStatusList.add("DELETED");
                      JobStatusList.add("READY");
                }
                enabledForAvailableOnly = false;
          
                break;
            }
            handleJobStatusFilter(JobStatusList.indexOf(CurrentUser.JobStatusFilter));
         }

void handleJobStatusFilter(int item)
{
  CurrentUser.JobStatusFilter = JobStatusList[item];
  if (CurrentUser.Login_Type == "JP")
  {
     CurrentUser.NextAction = nextActionList_JP[item];
     if (CurrentUser.NextAction.toUpperCase() == "Accept/Decline".toUpperCase()){
  
        }
  }
  else{
         CurrentUser.NextAction = nextActionList_JS[item];
  }
  if (CurrentUser.JobStatusFilter != "AVAILABLE")
  {
    enabledForAvailableOnly = false;
  }
  log('Job Status ', name: CurrentUser.JobStatusFilter);
  log('Next Job Action ', name: CurrentUser.NextAction);
  log('Login Type ', name: CurrentUser.Login_Type);
  CurrentUser.ShowOption = showOption[item];

  setState(() {  _getJobData();    });

}

  @override
  void initState() {
    super.initState();
        _getJobTypesData();
    _getJobData();
    
  }


  void _getJobTypesData() async {
    _jobtypesModel = (await PostJobTypesApiService().getJobTypes())!;

      Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {


                for (int i = 0; i < _jobtypesModel!.length; i++){

                    jobsList.add(_jobtypesModel![i].jobType);

                }
                jobsList.sort((a, b) => a.compareTo(b));
          }
      )
      );
  }

    @override
  void dispose() {
    // Clean up the controller when the widget is disposed.

    Asking_Wage.dispose();
    super.dispose();
  }

  void _getJobData() async {

          _jobModel = (await GetJobApiService().getJobs())!;

          Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  
  }

  void _assignJobUpdateFields(int index,  int proceedstatus)
  {

      String loginIdJs;
      String mobileNumberJs;
      String nameJs;
      String emailJs;

      String loginIdJp;
      String mobileNumberJp;
      String nameJp;
      String emailJp;


      if ( proceedstatus == 1) {

         if(CurrentUser.Login_Type == "JS")
    {
       loginIdJs = CurrentUser.Login_Id;
       mobileNumberJs = CurrentUser.Mobile_Number;
       nameJs = CurrentUser.User_Name;
       emailJs = CurrentUser.Email;

 /*      Login_Id_JP = _jobModel![index].loginId;
       Mobile_Number_JP = _jobModel![index].mobileNumberJp;
       Name_JP = _jobModel![index].nameJp;
       Email_JP = _jobModel![index].emailJp; */

    }
    else
    {
       loginIdJs = _jobModel![index].loginIdJs;
       mobileNumberJs = _jobModel![index].mobileNumberJs;
       nameJs = _jobModel![index].nameJs;
       emailJs = _jobModel![index].emailJs;

/*       Login_Id_JP = CurrentUser.Login_Id;
       Mobile_Number_JP = CurrentUser.Mobile_Number;
       Name_JP = CurrentUser.User_Name;
       Email_JP = CurrentUser.Email; */

    }
                                 String jobToUpdate = jsonEncode(
                                    {
                                              "Job_Id": _jobModel![index].jobId,
                                              "Login_Id_JS": loginIdJs,
                                              "Login_Id": _jobModel![index].loginId,
                                              "Mobile_Number_JS": mobileNumberJs,
                                              "Mobile_Number_JP": _jobModel![index].mobileNumberJp,
                                              "Date_From": _jobModel![index].dateFrom,
                                              "Date_To": _jobModel![index].dateTo,
                                              "Job_Pincode": _jobModel![index].jobPincode,
                                              "Job_Type": _jobModel![index].jobType,
                                              "Job_Status": CurrentUser.JobStatusToSubmit,
                                              "Name_JP": _jobModel![index].nameJp,
                                              "Name_JS": nameJs,
                                              "Payment_Frequency": _jobModel![index].paymentFrequency,
                                              "Requested_Wage": _jobModel![index].requestedWage,
                                              "Wage_Maximum": _jobModel![index].wageMaximum,
                                              "Email_JP": _jobModel![index].emailJp,
                                              "Email_JS": emailJs,
                                              "Lattitude": "",
                                              "Longtitude": "",
                                              "Wage_Minimum": _jobModel![index].wageMinimum,
                                              "Job_Description": _jobModel![index].jobDescription,
                                              "Job_City": _jobModel![index].jobCity,
                                              "Job_State": _jobModel![index].jobState

                                    }
                                  );
                                  log('composed-update-request ', name: jobToUpdate);
                                  _postJobUpdateData(jobToUpdate);

      }

   

  }

 int waitfewsec(){
    Timer(Duration(seconds: 3), () {
  Text("Yeah, this line is printed after 3 seconds");
});
return 0;
 }

    void _postJobUpdateData(String newrequest) async {
    final Status = (await PostJobUpdateApiService().updateJob(newrequest));

      Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
      log('update status is ',  name: Status);
      if (Status == "Job Progress Updated")
      {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                                title: const Text("Job Status"),
                                content: const Text("Your Job update has been submitted for action"),
                                actions: [ TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')) ]
                            )
                     );// showDialog
                     setState(() {
                       _getJobData();
                     });
                     
      }
  }





  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar:    
 AppBar(
      elevation: 30,
        
            actions: <Widget>[
                const SizedBox(width: 7),
                 Expanded( 
                      child:DropdownMenu<String>( width:200, //initialSelection: jobsList.first,
                                  hintText: "Job Type", 
                                  inputDecorationTheme: const InputDecorationTheme( isDense: true, 
                                     contentPadding: EdgeInsets.all(3), constraints: BoxConstraints(maxWidth: 200)   ,
                                    //border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                  ),
                                 
                                  onSelected: (String? value) {setState(() {JobTypeFilter = value!; 
                                   CurrentUser.JobsFilter.clear();
                                   if(JobTypeFilter == "ALL")
                                   {
                                     CurrentUser.JobsFilter = [];
                                   }
                                   else{
                                        CurrentUser.JobsFilter.add(JobTypeFilter); 
                                   }
                                   
                                   setState(() { _getJobData();
                                    
                                  });}   ); },
                                  dropdownMenuEntries: jobsList.map<DropdownMenuEntry<String>>((String value) 
                                  {return DropdownMenuEntry<String>(value: value, label: value);  }).toList(),
                                                  ),
                              ),


                                 
                      PopupMenuButton<int>( icon: const Icon(Icons.add_reaction),
       tooltip: 'You are viewing ${CurrentUser.JobStatusFilter} jobs now',
       iconSize: 22.0,
       iconColor: const Color.fromARGB(255, 5, 199, 105),
          onSelected: (item) => {handleJobStatusFilter(item)},
          itemBuilder: (context) => [
            const PopupMenuItem<int>(value: 0, child: Text('AVAILABLE')),
            const PopupMenuItem<int>(value: 1, child: Text('REQUESTED')),
            const PopupMenuItem<int>(value: 2, child: Text('ACCEPTED')),
            const PopupMenuItem<int>(value: 3, child: Text('REQUEST_CANCELLED')),
            const PopupMenuItem<int>(value: 4, child: Text('ACCEPT_CANCELLED')),
            const PopupMenuItem<int>(value: 5, child: Text('DECLINED')),
            const PopupMenuItem<int>(value: 6, child: Text('DELETED')),
            const PopupMenuItem<int>(value: 7, child: Text('READY')),
          ],
        ),
     //  const SizedBox(height: 0), 
     /*            Expanded( child: Text( CurrentUser.JobStatusFilter, 
                                  style: const TextStyle(fontSize: 8,color:Color.fromARGB(245, 130, 33, 9) , fontWeight: FontWeight.bold), ),
                                          ),
        */
         //     ],),


       // const SizedBox(width: 10), 



       /*            Expanded( child: Text( CurrentUser.Login_Type_Description, 
                                  style: const TextStyle(fontSize: 8,color:Color.fromARGB(245, 130, 33, 9) , fontWeight: FontWeight.bold), ),
                                          ), 
                                          */
      PopupMenuButton<int>(
        enabled: true,
       icon: const Icon(Icons.work),
       tooltip: 'You are a ${CurrentUser.Login_Type_Description} now',
       iconSize: 22.0,
        iconColor: const Color.fromARGB(255, 104, 58, 183),
          onSelected: (item) => {handleRole(item)},
          itemBuilder: (context) => [
            const PopupMenuItem<int>(value: 0, child: Text('Job Seeker')),
            const PopupMenuItem<int>(value: 1, child: Text('Job Provider')),
          ],
        ),

                IconButton(
            icon: const Icon(Icons.add_business),
            color: Color.fromARGB(245, 184, 15, 15),
            disabledColor: Color.fromARGB(245, 46, 24, 108),
            highlightColor: Color.fromARGB(245, 46, 24, 108),
            iconSize: 22,
            tooltip: 'Add New Job',
            onPressed: () {
              setState(() {  Navigator.of(context).pushNamed('/addJob');  });
                             // setState(() {        });
                          },
            ),
      

    ],
      ),



      body: _jobModel == null || _jobModel!.isEmpty
          ? 

           //const CircularProgressIndicator()
           const Text("\n\n\t\t Please Wait for Few Seconds, in case of no data, please change your filter criteria",
            style: TextStyle(color: Color.fromARGB(255, 89, 38, 8), fontWeight: FontWeight.w300, fontSize: 20),
            ) 


          : ListView.builder(
              itemCount: _jobModel!.length,
              itemBuilder: (context, index) {
                return Card(
                color:Colors.white,
                elevation: 20,

        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

        const SizedBox(height: 7), 
             Row(
                  children:<Widget>[
                    const SizedBox(width: 15), 
                     Expanded(child: Text('Job: ${_jobModel![index].jobType}', style: const TextStyle(fontSize: 14),),),
                    const SizedBox(width: 20), 
                     Expanded(child: Text('Vacancies: ${_jobModel![index].jobOpenings}', style: const TextStyle(fontSize: 14),),),
                                  ]
                  ),

                  const SizedBox(height: 7), 
              Row(
                  children:<Widget>[
                    const SizedBox(width: 15), 
                     Expanded(child: Text('From: ${_jobModel![index].dateFrom}', style: const TextStyle(fontSize: 14),),),
                     const SizedBox(width: 20), 
                     Expanded(child: Text(' To: ${_jobModel![index].dateTo}', style: const TextStyle(fontSize: 14),),),
                                  ]
                  ),
                  const SizedBox(height: 7), 
              Row(
                  children:<Widget>[
                    const SizedBox(width: 15), 
                     Expanded(child: Text('Salary Range (Rs.):  ${_jobModel![index].wageMinimum}', style: const TextStyle(fontSize: 14),),),
                     const SizedBox(width: 20), 
                     Expanded(child: Text(' To (Rs.) :  ${_jobModel![index].wageMaximum}', style: const TextStyle(fontSize: 14),),),
                                  ]
                  ),
                  const SizedBox(height: 1), 
              Row(
                  children:<Widget>[
                    const SizedBox(width: 12), 
                     Expanded(child: TextFormField(
                      enabled: enabledForAvailableOnly,
                                      decoration: InputDecoration( hintText: 'Asking Salary: ${_jobModel![index].requestedWage}',
                                            border: InputBorder.none,
                                            fillColor: Colors.white70,
                                            prefixIcon: const Icon(Icons.currency_rupee),
                                            counterText: "",),
                                            maxLength: 7, style: const TextStyle(fontSize: 14, color: Colors.blueGrey,),
                                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),],
                                            keyboardType: TextInputType.number,
                                              onChanged: (text) {  setState(() {  _jobModel![index].requestedWage = text; });},
                                          ),
                     
                             ),
                     const SizedBox(width: 20), 
                     Expanded(child: Text('Pay Type: ${_jobModel![index].paymentFrequency}', style: const TextStyle(fontSize: 14),),),
                                  ]
                  ),
                  const SizedBox(height: 7), 


              Row(
                  children:<Widget>[
                    const SizedBox(width: 15), 
                     Expanded(child: Text('${_jobModel![index].jobCity}, ${_jobModel![index].jobState}, ${_jobModel![index].jobPincode}', style: const TextStyle(fontSize: 14),),),
                                   ]
                  ),

                  const SizedBox(height: 7), 
            Row(

              children: <Widget>[

               Expanded(child: TextButton(
                  child: Text(CurrentUser.NextAction),
                  onPressed: () {
                    int taskCompleted = 0;
 
                  if ((CurrentUser.JobStatusFilter == "REQUESTED") && (CurrentUser.NextAction == "Cancel")){

                        CurrentUser.JobStatusToSubmit = "REQUEST_CANCELLED";
                  }
                  else if ((CurrentUser.JobStatusFilter == "ACCEPTED") && (CurrentUser.NextAction == "Cancel")){
                        CurrentUser.JobStatusToSubmit = "ACCEPT_CANCELLED";
                  }
                  else if (CurrentUser.NextAction.toUpperCase() == "Request".toUpperCase()){
                        CurrentUser.JobStatusToSubmit = "REQUESTED";
                  }
                  else if (CurrentUser.NextAction.toUpperCase() == "DELETE"){
                        CurrentUser.JobStatusToSubmit = "DELETED";
                  }
                  else if (CurrentUser.NextAction == "DECLINE"){
                        CurrentUser.JobStatusToSubmit = "DECLINED";
                  }
                  else if (CurrentUser.NextAction.toUpperCase() == "Agree".toUpperCase()){
                              showDialog(
                                            context: context,
                                            builder: (BuildContext context) => 
                                            AlertDialog(
                                            title: const Text('No Action Required'),
                                            content: const Text('Thank you confirming.'),
                                            actions: <Widget>[
                                                                TextButton(
                                                                  onPressed: () => {
                                                                    CurrentUser.JobStatusToSubmit = "AGREED",
                                                                     taskCompleted = 1,
                                                                    Navigator.pop(context, 'Ok'),
                                                                    },
                                                                  child: const Text('Ok'),
                                                                   
                                                                ),
                                                            ],
                                                        ),
                                        );

                  }
                  else if (CurrentUser.NextAction.toUpperCase() == "Accept/Decline".toUpperCase()){
                     taskCompleted = 0;
  

                  //   void tappedbutton() async {     await

                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) => 
                                            AlertDialog(
                                            title: const Text('Your Action'),
                                            content: const Text('You may Accept or Decline the request from Job Seeker'),
                                            actions: <Widget>[
                                                                TextButton(
                                                                  onPressed: () => {
                                                                    CurrentUser.JobStatusToSubmit = "DECLINED",
                                                                     taskCompleted = 1,
                                                                    Navigator.pop(context, 'Decline'),
                                                                    },
                                                                  child: const Text('Decline'),
                                                                   
                                                                ),
                                                                TextButton(
                                                                  onPressed: () => {
                                                                    CurrentUser.JobStatusToSubmit = "ACCEPTED",
                                                                    taskCompleted = 1,
                                                                    Navigator.pop(context, 'Accept'),},
                                                                  child: const Text('Accept'),
                                                                ),
                                                                TextButton(
                                                                  onPressed: () => {
                                                                    taskCompleted = 2,
                                                                    Navigator.pop(context, 'Cancel'),},
                                                                  child: const Text('Cancel'),
                                                                ),
                                                            ],
                                                        ),
                                        ).then((onValue) {
                                          _assignJobUpdateFields(index, taskCompleted);
   
                                        });
                  //   }
                     
                    // tappedbutton();

                  }
                  

                  if ((CurrentUser.NextAction.toUpperCase() != "Accept/Decline".toUpperCase()) && 
                  ((CurrentUser.NextAction.toUpperCase() != "Agree".toUpperCase()) ))
                  {
                    taskCompleted =1;
                    _assignJobUpdateFields(index, taskCompleted);

                  }
 
                    /* ... */},
                ),
            ),



                const SizedBox(width: 8),
               Expanded(child: TextButton(
                  child: const Text('View Details'),
                  onPressed: () {
                    setState(() {
                     // _getJobData();
                    });
                if (CurrentUser.Login_Type == "JS")
                 {  
                    showDialog(context: context,
                     builder: (context) => AlertDialog(
                      title: const Text("Job Details"),
                      content: Container(
                        child: Card(
                            child: Column(
                            children: <Widget>[
                                                const SizedBox(height: 5), 
                                                Row(
                                                  children: <Widget>[
                                                            const SizedBox(width: 20), 
                                                            Expanded(child: Text('Job Description:\n ${_jobModel![index].jobDescription}', style: const TextStyle(fontSize: 14),),),
                                                                  ]
                                                  
                                                  ),
                                                const SizedBox(height: 15), 
                                                Row(
                                                children: <Widget>[
                                                            const SizedBox(width: 20), 
                                                            Expanded(child: Text('Job Provider Name:\n ${_jobModel![index].nameJp}', style: const TextStyle(fontSize: 14),),),
                                                                  ]                                        
                                                   ),
                                                const SizedBox(height: 15), 
                                                Row(
                                                children: <Widget>[
                                                            const SizedBox(width: 20), 
                                                            Expanded(child: Text('Job Provider Mobile:\n ${_jobModel![index].mobileNumberJp}', style: const TextStyle(fontSize: 14),),),
                                                                  ]                                        
                                                   ),
                                                const SizedBox(height: 15), 
                                                Row(
                                                  children: <Widget>[
                                                            const SizedBox(width: 20), 
                                                            Expanded(child: Text('Job Address:\n ${_jobModel![index].jobStreet}', style: const TextStyle(fontSize: 14),),),
                                                                  ]
                                                  
                                                  ),
                                                const SizedBox(height: 5), 
                                                Row(
                                                children: <Widget>[
                                                            const SizedBox(width: 20), 
                                                            Expanded(child: Text('\n ${_jobModel![index].jobCity}', style: const TextStyle(fontSize: 14),),),
                                                                  ]                                        
                                                   ),
                                                const SizedBox(height: 5), 
                                              ]
                                          ),
                                      ),
                                  ),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context)
                        , child: const Text('OK'))
                      ]
                     )
                     );// showDialog
                  }
            else
            {  
                    showDialog(context: context,
                     builder: (context) => AlertDialog(
                      title: const Text("Job Details"),
                      content: Container(
                        child: Card(
                            child: Column(
                            children: <Widget>[
                                                const SizedBox(height: 5), 
                                                Row(
                                                children: <Widget>[
                                                            const SizedBox(width: 20), 
                                                            Expanded(child: Text('Job Seeker Name:\n ${_jobModel![index].nameJs}', style: const TextStyle(fontSize: 14),),),
                                                                  ]                                        
                                                   ),
                                                const SizedBox(height: 15), 
                                                Row(
                                                children: <Widget>[
                                                            const SizedBox(width: 20), 
                                                            Expanded(child: Text('Job Seeker Mobile:\n ${_jobModel![index].mobileNumberJs}', style: const TextStyle(fontSize: 14),),),
                                                                  ]                                        
                                                   ),
                                                const SizedBox(height: 5), 
                                              ]
                                          ),
                                      ),
                                  ),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context)
                        , child: const Text('OK'))
                      ]
                     )
                     );// showDialog
                  }
                    
                    /* ... */},
                ),
            ),
                const SizedBox(width: 9),
              ],
            ),
          ],
        ),
                        );
              },
            ),
       
    );
  }
}