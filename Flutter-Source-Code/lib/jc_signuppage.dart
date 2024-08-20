import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:convert'; 
import 'package:form_field_validator/form_field_validator.dart'; 
//import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:jobconnect_app/services/userRegister_api_service.dart';


class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

@override 
State<SignupPage> createState() => _RegisterState(); 
} 

class _RegisterState extends State<SignupPage> { 
static final _formkey = GlobalKey<FormState>(); 

   var items = [ 'Female', 'Male', 'Others' ]; 
   static const List<String> list = <String>['   Female', '   Male', '   Others'];

     String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";

    String dropdownvalue = 'Female';
    bool passwordVisible=true; 
    bool reEnterPasswordVisible=true; 
    
  final TextEditingController country = TextEditingController(); 
  final TextEditingController state = TextEditingController(); 
  final TextEditingController city = TextEditingController();

   final Login_Id = TextEditingController();
   final Mobile_Number = TextEditingController();
   final Login_Type = TextEditingController();
   final Password = TextEditingController();
   final ConfirmPassword = TextEditingController();
   final User_Name = TextEditingController();
   final Gender = TextEditingController();
   final Age = TextEditingController();
   final Profession = TextEditingController();
   final Experience_Years = TextEditingController();
   final Experience_Months = TextEditingController();
   final Street = TextEditingController();
   //final City = TextEditingController();
   //final State = TextEditingController();
   final Pincode = TextEditingController();
   final Email = TextEditingController();
  
    @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    Login_Id.dispose();
    Mobile_Number.dispose();
    Email.dispose();
    Login_Type.dispose();
    Password.dispose();
    ConfirmPassword.dispose();
    User_Name.dispose();
    Gender.dispose();
    Age.dispose();
    Profession.dispose();
    Experience_Years.dispose();
    Experience_Months.dispose();
    Street.dispose();
    //City.dispose();
    //State.dispose();
    Pincode.dispose();
    super.dispose();
  }

      void _postUserRegisterData(String newrequest) async {
    final Status = (await PostUserRegisterApiService().updateJob(newrequest));

      Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
      log('User register status is ',  name: Status);
      if (Status == "User Registered")
      {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                                title: const Text("Registration Status"),
                                content: const Text("Your registration is successful.\nYou can Login now."),
                                actions: [ TextButton(onPressed: () => {Navigator.pop(context),
                               // Navigator.of(context).pushNamed('/welcome'), 
                                }, child: const Text('OK')) ]
                            )
                     );// showDialog
      }
      else if (Status == "User Already Exist")
      {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                                title: const Text("User Record Already Exists"),
                                content: const Text("Your profile is already available with us.\nPlease use Forgot Password option if you need to reset your password."),
                                actions: [ TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')) ]
                            )
                     );// showDialog
          
      }
  }

  @override
  Widget build(BuildContext context) {
   
  
  // List of items in our dropdown menu 

  //  return MaterialApp(
   return Form(
    key: _formkey, 
  //    debugShowCheckedModeBanner: false,
      child: Scaffold(
        body: SafeArea(
        child: SingleChildScrollView(
          child: Card(
            child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(height: 2),
                 const Column(
                        children: <Widget>[ SizedBox(height: 20.0),
                                Text("Create Your JobConnect Account", style: TextStyle(color: Color.fromARGB(255, 122, 113, 164), fontSize: 24, fontWeight: FontWeight.bold, ),),
                                          ],
                       ),
                       const SizedBox(height: 12),
                 Column(
                        children: <Widget>[
                            TextFormField(
                                validator: MultiValidator([ 
                                RequiredValidator(errorText: 'Please enter Login Id, you want to use for Login'), 
                                MinLengthValidator(6, errorText: 'Login Id must be minimum 6 charecters'), ]).call, 
                                controller: Login_Id,
                                decoration: InputDecoration( hintText: "Login Id",
                                                            //border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(3)),),
                                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(18),),
                                                            prefixIcon: const Icon(Icons.person)),
                                style: const TextStyle(fontSize: 14),
                                          ),
                                const SizedBox(height: 7),
                            TextFormField(
                                validator: MultiValidator([ 
                                RequiredValidator(errorText: 'Name cant be empty'), 
                                MinLengthValidator(3, errorText: 'Name cant be less than 3 characters'), ]).call, 
                                controller: User_Name,
                                decoration: InputDecoration( hintText: "Your Name",
                                                            //border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(3)),),
                                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(18),),
                                                            prefixIcon: const Icon(Icons.person_3)),
                                style: const TextStyle(fontSize: 14),
                                          ),
                                const SizedBox(height: 7),

                            TextFormField(
                                validator: MultiValidator([ 
                                RequiredValidator(errorText: 'Enter email address'), 
                                EmailValidator( errorText: 'Please correct email filled'), ]).call, 
                                controller: Email,
                                decoration: InputDecoration( hintText: "Email",
                                                             //border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(3)),  ),
                                                             border: OutlineInputBorder(borderRadius: BorderRadius.circular(18),),
                                                             prefixIcon: const Icon(Icons.email)),
                                style: const TextStyle(fontSize: 14),
                                         ),
                                const SizedBox(height: 7),

                            TextFormField(
                                validator: MultiValidator([ 
                                RequiredValidator(errorText: 'Enter Your Mobile Number'), 
                                PatternValidator(r'(^[0-9]{10}$)', errorText: 'Please enter 10 digit Mobile Number'),]).call, 
                                controller: Mobile_Number,
                                decoration: InputDecoration( hintText: "Mobile Number",
                                                            //border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(3)),  ),
                                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(18),),
                                                            prefixIcon: const Icon(Icons.phone)),
                                style: const TextStyle(fontSize: 14),
                                        ),
                                const SizedBox(height: 7),
                       ],
                    ),

              Row(
                  children: <Widget>[
                      Expanded(child: TextFormField(
                                validator: MultiValidator([ 
                                RequiredValidator(errorText: 'Age please'), 
                                MinLengthValidator(2, errorText: 'Age in two digits'), ]).call, 
                                controller: Age,
                                decoration: InputDecoration( hintText: "Age",
                                                            //border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(3)),),
                                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(18),),
                                                            prefixIcon: const Icon(Icons.timeline)),
                                style: const TextStyle(fontSize: 14),
                                          ),
                                ),
                      const SizedBox(width: 5), 
                      Expanded( child:DropdownMenu<String>( width: 200.0, initialSelection: list.first,

                                  inputDecorationTheme: InputDecorationTheme( isDense: true, 
                                     contentPadding: const EdgeInsets.all(10), constraints: const BoxConstraints(maxWidth: 188),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
                                  ),
                                 
                                  onSelected: (String? value) {setState(() {dropdownvalue = value!; }); },
                                  dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) 
                                  {return DropdownMenuEntry<String>(value: value, label: value);  }).toList(),
                                                  ),
                              )

                                ],
                ),
              const SizedBox(height: 7, width: 5), 
              Row(
                  children:<Widget>[
                      Expanded(child: TextFormField(
                                  validator: MultiValidator([ 
                                  RequiredValidator(errorText: 'Please enter your password'), 
                                  MinLengthValidator(4, errorText: 'Password must be minimum 4 characters'), ]).call, 
                                  controller: Password,
                                  obscureText: passwordVisible, 
                                  decoration: InputDecoration(hintText: "Enter Your Password",
                                      suffixIcon: IconButton(icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off), 
                                        onPressed: () { setState(() { passwordVisible = !passwordVisible;}, ); },  ), 
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(18),),
                                      prefixIcon: const Icon(Icons.password),),
                                      style: const TextStyle(fontSize: 14),
                                            ),
                                ),
                                const SizedBox(width: 5),
                      Expanded(child: TextFormField(
                                  validator: MultiValidator([ 
                                  RequiredValidator(errorText: 'Please re-enter your password'), 
                                  MinLengthValidator(4, errorText: 'Password and re-entered Password must match'), ]).call, 
                                  controller: ConfirmPassword,
                                  obscureText: reEnterPasswordVisible, 
                                  decoration: InputDecoration(hintText: "Confirm Password",
                                      suffixIcon: IconButton(icon: Icon(reEnterPasswordVisible ? Icons.visibility : Icons.visibility_off), 
                                        onPressed: () { setState(() { reEnterPasswordVisible = !reEnterPasswordVisible;}, ); },  ), 
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(18),),
                                      prefixIcon: const Icon(Icons.password),),
                                      style: const TextStyle(fontSize: 14),
                                            ),
                              )
                                
                                   ],
                  ),//
                  const SizedBox(height: 7, width: 5), 
              Row(
                  children:<Widget>[
                     Expanded(child: TextFormField(
                                validator: MultiValidator([ 
                                RequiredValidator(errorText: 'Please enter NA if not applicable'), 
                                MinLengthValidator(2, errorText: 'Profession cant be less than 2 characters'), ]).call, 
                                controller: Profession,
                                decoration: InputDecoration( hintText: "Your Profession",
                                                            //border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(3)),),
                                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(18),),
                                                            prefixIcon: const Icon(Icons.work)),
                                style: const TextStyle(fontSize: 14),
                                          ),
                                ),
                                const SizedBox(width: 5), 
                      Expanded(child: TextFormField(
                                validator: MultiValidator([ 
                                RequiredValidator(errorText: 'Exp.Yrs'), 
                                MinLengthValidator(1, errorText: 'Please enter Experience years'), ]).call, 
                                controller: Experience_Years,
                                decoration: InputDecoration( hintText: "Exp. Years",
                                                            //border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(3)),),
                                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(18),),
                                                            prefixIcon: const Icon(Icons.work_history)),
                                style: const TextStyle(fontSize: 14),
                                          ),
                                ),
                                
                                   ],
                  ),//
                   const SizedBox(height: 7, width: 5), 
 /*           Column( 
                  mainAxisAlignment: MainAxisAlignment.center, 
                  children: [ CountryStateCityPicker( country: country, state: state, city: city, 
                                                      dialogColor: Colors.grey.shade200, 
                                                      textFieldDecoration: InputDecoration( 
                                                      suffixIcon: const Icon(Icons.arrow_drop_down_outlined), 
                                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(18),),),
                                                      
                                                    ), 
                                                    SizedBox(height: 6),
                  //Text("${country.text}, ${state.text}, ${city.text}")
                           ], 
                  ),*/

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
                                validator: MultiValidator([ 
                                RequiredValidator(errorText: 'Pincode please'), 
                                MinLengthValidator(6, errorText: 'Please enter 6 digit Pincode'), ]).call, 
                                controller: Pincode,
                                decoration: InputDecoration( hintText: "Pincode",
                                                            //border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(3)),),
                                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(18),),
                                                            prefixIcon: const Icon(Icons.post_add)),
                                style: const TextStyle(fontSize: 14),
                                          ),
                                ),]),

            const SizedBox(height: 12), 
            Container(
                    padding: const EdgeInsets.only(top: 2, left: 3),
                    child: ElevatedButton( onPressed: () { 
                      if (_formkey.currentState!.validate()) { 

                   String userRegisterDetails = jsonEncode(
                    {
                              "Login_Id": Login_Id.value.text,
                              "Mobile_Number": Mobile_Number.value.text,
                              "Login_Type": "",
                              "Password": Password.value.text,
                              "User_Name": User_Name.value.text,
                              "Gender": Gender.value.text,
                              "Age": Age.value.text,
                              "Profession": Profession.value.text,
                              "Experience_Years": Experience_Years.value.text,
                              "Experience_Months": 0,
                              "Street": "",
                              "City": cityValue,
                              "State": stateValue,
                              "Pincode": Pincode.value.text,
                              "Email": Email.value.text,
                    }
                   );
                   log('composed-update-request ', name: userRegisterDetails);
                   _postUserRegisterData(userRegisterDetails);
                    }

                     },
                            style: ElevatedButton.styleFrom(shape: const StadiumBorder(),
                                                            padding: const EdgeInsets.symmetric(vertical: 12),
                                                            backgroundColor: const Color.fromARGB(255, 91, 142, 91),
                                                            ),
                            child: const Text("Sign up",style: TextStyle(  fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),),
                                          )
                      ),
            const SizedBox(height: 9),
            Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                                      const Text("Already have an account?"),
                                      TextButton(
                                          onPressed: () { 
                                            Navigator.pop(context);
                               // Navigator.of(context).pushNamed('/');
                                
                                           },
                                          child: const Text("Login", style: TextStyle(color: Colors.purple),)
                                                )
                                    ],
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