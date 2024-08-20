import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:convert'; 
import 'package:form_field_validator/form_field_validator.dart'; 
//import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:jobconnect_app/services/pwdupdate_api_service.dart';


class ForgotPwdPage extends StatefulWidget {
  const ForgotPwdPage({super.key});

@override 
State<ForgotPwdPage> createState() => _ForgotPwdState(); 
} 

class _ForgotPwdState extends State<ForgotPwdPage> { 
final _formkey = GlobalKey<FormState>(); 

    bool passwordVisible=true; 
    bool reEnterPasswordVisible=true; 
    
   final Login_Id = TextEditingController();
   final Password = TextEditingController();
   final ConfirmPassword = TextEditingController();
   final Access_Code = TextEditingController();
   
    @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    Login_Id.dispose();
    Access_Code.dispose();
    Password.dispose();
    ConfirmPassword.dispose();

  }

      void _postPwdUpdateData(String newrequest) async {
    final Status = (await PostPwdUpdateApiService().updatePwd(newrequest));

      Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
      log('Password update status is ',  name: Status);
      if (Status == "Password Updated")
      {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                                title: const Text("Password Change Status"),
                                content: const Text("Your Password has been updated successfully.\nYou can Login now"),
                                actions: [ TextButton(onPressed: () => {Navigator.pop(context),
                                //Navigator.of(context).pushNamed('/welcome'), 
                                }, child: const Text('OK')) ]
                            )
                     );// showDialog
      }
      else if (Status == "Invalid Access Code")
      {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                                title: const Text("Invalid Access Code"),
                                content: const Text("Please enter the valid Access Code.\nThe Access Code you have received in your email is not matching"),
                                actions: [ TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')) ]
                            )
                     );// showDialog
          
      }
      else if (Status == "Invalid Login Id")
      {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                                title: const Text("Invalid Login Id"),
                                content: const Text("The Login Id you you have entered is Invalid.\nPlease Signup if you do not have an JobConnect accout with us."),
                                actions: [ TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')) ]
                            )
                     );// showDialog
          
      }
  }

  @override
  Widget build(BuildContext context) {
   
  
  // List of items in our dropdown menu 

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                                Text("Change Your JobConnect Password", style: TextStyle(color: Color.fromARGB(255, 122, 113, 164), fontSize: 24, fontWeight: FontWeight.bold, ),),
                                          ],
                       ),
                       const SizedBox(height: 12),
                 Column(
                        children: <Widget>[
                            TextFormField(
                                validator: MultiValidator([ 
                                RequiredValidator(errorText: 'Please enter Login Id'), 
                                MinLengthValidator(6, errorText: 'Login Id must be minimum 6 charecters'), ]).call, 
                                controller: Login_Id,
                                decoration: InputDecoration( hintText: "Login Id",
                                                            //border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(3)),),
                                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(18),),
                                                            prefixIcon: const Icon(Icons.person)),
                                style: const TextStyle(fontSize: 14),
                                          ),
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
                                RequiredValidator(errorText: 'Please enter the Access Code'), 
                                MinLengthValidator(6, errorText: 'Access Code should be 6 characters'), ]).call, 
                                controller: Access_Code,
                                decoration: InputDecoration( hintText: "Access Code received in Your registered Email",
                                                            //border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(3)),),
                                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(18),),
                                                            prefixIcon: const Icon(Icons.work)),
                                style: const TextStyle(fontSize: 14),
                                          ),
                                ),
                                const SizedBox(width: 5), 
                        ],
                  ),//
                   const SizedBox(height: 7, width: 5), 


            const SizedBox(height: 12), 
            Container(
                    padding: const EdgeInsets.only(top: 2, left: 3),
                    child: ElevatedButton( 
                      onPressed: () { 

                                        String pwdChangeDetails = jsonEncode(
                                          {
                                                    "Login_Id": Login_Id.value.text,
                                                    "Password": Password.value.text,
                                                    "Access_Code": Access_Code.value.text
                                          }
                                        );
                                        log('composed-update-request ', name: pwdChangeDetails);
                                        _postPwdUpdateData(pwdChangeDetails);
                                   },
                            style: ElevatedButton.styleFrom(shape: const StadiumBorder(),
                                                            padding: const EdgeInsets.symmetric(vertical: 12),
                                                            backgroundColor: const Color.fromARGB(255, 91, 142, 91),
                                                            ),
                            child: const Text("Sign up",style: TextStyle(  fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),),
                                          )
                      ),

                ],

              ),
             
            ),
          ),
        )
      ),
    );
  } //widget build
}