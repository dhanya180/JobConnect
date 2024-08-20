import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:jobconnect_app/jc_addjob.dart';
import 'package:jobconnect_app/jc_signuppage.dart';
import 'package:form_field_validator/form_field_validator.dart'; 
import 'package:jobconnect_app/services/loginverify_api_service.dart';
import 'package:jobconnect_app/screens/home.dart';

import 'dart:developer';

void main() => runApp(const SignInApp());

class SignInApp extends StatelessWidget {
  const SignInApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
     // '/': (context) => const AddJobScreen(),
                 '/': (context) => const SignInScreen(),
                 '/signup': (context) => const SignupPage(),
                 '/addJob': (context) => const AddJobScreen(),
                 '/jobspage': (context) => const ShowJobsScreen(),
              },

    );
  }
}

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                          _header(context),
                          _inputField(context),
                          _forgotPassword(context),
                          _signup(context),
                      ],
                    ),
                  ),
              );
           } //Widget build
} // class SignInScreen

  _header(context) {
    return const Column(
      children: [
        Text( "JobConnect",
              style: TextStyle(color: Color.fromARGB(255, 134, 100, 192), fontSize: 40, fontWeight: FontWeight.bold),
            ),
        Text("Your job partner is just a click away",
              style: TextStyle(color: Color.fromARGB(255, 107, 115, 110), fontSize: 14),
            ),
        SizedBox(height: 50),
          ], //children
    );
  }

  _inputField(context) {
    return Column(
      children: [SizedBox( width: 380,
          child: Card(
                      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(12.0),
                      side: const BorderSide( color: Color.fromARGB(255, 115, 128, 115), width: 1.0, ), ),
                      elevation: 90,
                      child: const SignInForm(),
                    ),
                    ),],
          );
   }

    _forgotPassword(context) {
      return Row ( mainAxisAlignment: MainAxisAlignment.center,
      children: [ const SizedBox(height: 34),
          TextButton( 
                      onPressed: () {


                                    },
                      child: const Text("Forgot password?", style: TextStyle(color: Colors.purple, fontSize: 16),),
                    ),
                ],
              );
  }
   
  _signup(context) {

      void showRegisterScreen() { Navigator.of(context).pushNamed('/signup');  }
      return Row( mainAxisAlignment: MainAxisAlignment.center,
        children: [ const SizedBox(height: 34),
                    const Text("Dont have an account? "),
              TextButton(
                          onPressed: () {  showRegisterScreen();   },
                          child: const Text("Sign Up", style: TextStyle(color: Colors.purple, fontSize: 16),)
                        )
                  ],
                );
  }


class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _loginIdTextController = TextEditingController();
  final _PasswordTextController = TextEditingController();
  static final _formkey = GlobalKey<FormState>();
  bool passwordVisible=true; 

  double _formProgress = 0;

  void _updateFormProgress() {
    if ((_loginIdTextController.value.text.isNotEmpty) & (_PasswordTextController.value.text.isNotEmpty))
    {
            setState(() { _formProgress = 1; });
    }
    else{
      setState(() { _formProgress = 0; });
    }
  }

  void _validateSignIn(){

                   String loginDetails = jsonEncode(
                              { 
                                "Login_Id": _loginIdTextController.value.text,
                                "Password": _PasswordTextController.value.text
                              }
                          );
                    _postLoginVerifyData(loginDetails);
    
  }

      void _postLoginVerifyData(String newrequest) async {
    final StatusReceived = (await PostLoginVerifyApiService().verifyLogin(newrequest));

      Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
      log('Login status is ',  name: StatusReceived);
      if (StatusReceived == "Success")
      {
        _showJobsScreen();

      }
      else if (StatusReceived == "Email not yet verified")
      {
         _showJobsScreen();
      }
      else if (StatusReceived == "Failure") 
      {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                                title: const Text("Login Status"),
                                content: const Text("Invalid Password. Please check."),
                                actions: [ TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')) ]
                            )
                     );// showDialog
      }
      else if (StatusReceived == "User not found") //
      {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                                title: const Text("Login Status"),
                                content: const Text("Invalid Login Id.\nPlease use signup option to create a new account."),
                                actions: [ TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')) ]
                            )
                     );// showDialog
      }
      
  }

  void _showJobsScreen() {
    Navigator.of(context).pushNamed('/jobspage');
  }

    void _showRegisterScreen() {
    Navigator.of(context).pushNamed('/signup');
  }

  @override
  Widget build(BuildContext context) {
     
    return Form(
     key: _formkey, 
      onChanged: _updateFormProgress,
      child: Column(
        
        mainAxisSize: MainAxisSize.min,
        children: [
          //AnimatedProgressIndicator(value: _formProgress),
          const SizedBox(height: 7),
          Text('Here We Go...', style: Theme.of(context).textTheme.headlineSmall,),
          const SizedBox(height: 9),
          Padding(
            padding: const EdgeInsets.all(8),
            
            child: TextFormField(
                           						validator: MultiValidator([ 
						RequiredValidator(errorText: 'Please enter your Login Id'), 
						MinLengthValidator(6, 
							errorText: 'Login Id must be minimum 6 charecters'), 
						]).call, 
             onChanged:(text) {
                _updateFormProgress();
              } , 
              controller: _loginIdTextController,
              decoration: const InputDecoration(hintText: 'Login Id ',),
              style: const TextStyle(fontSize: 14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
             						validator: MultiValidator([ 
                        RequiredValidator(errorText: 'Please enter your password'), 
                        MinLengthValidator(4, errorText: 'Password must be minimum 4 charecters'), ]).call, 
                        controller: _PasswordTextController,
                        obscureText: passwordVisible, 
                        onChanged:(text) { _updateFormProgress(); } , 
                        decoration: InputDecoration(hintText: "Password", 
                        suffixIcon: IconButton( 
                            icon: Icon(passwordVisible 
                            ? Icons.visibility 
                            : Icons.visibility_off), 
                        onPressed: () { setState(() { passwordVisible = !passwordVisible;}, ); }, 
                                              ), 
                                          ), 
                        keyboardType: TextInputType.visiblePassword, 
                        style: const TextStyle(fontSize: 14),
                    ),
                ),
          const SizedBox(height: 7),
          TextButton(
            style: ButtonStyle(
              foregroundColor: WidgetStateProperty.resolveWith((states) {
                return states.contains(WidgetState.disabled)
                    ? null
                    : Colors.white;
              }),
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                return states.contains(WidgetState.disabled)
                    ? null
                    : const Color.fromARGB(255, 91, 142, 91);
              }),
            ),
            onPressed: () {
                            //_formProgress == 1 ? _validateSignIn : null,

              							if (_formkey.currentState!.validate()) { 
                                    if(_formProgress == 1 )
                                    {
                                      _validateSignIn();
                                    }
							                }  
            },
            child: const Text("Sign in",style: TextStyle(  fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255), fontSize: 16),),
          ),
          const SizedBox(height: 10),
        ],
      )
     );
  }
}