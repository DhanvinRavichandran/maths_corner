import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maths_corner/login%20page.dart';
import 'clspage.dart';

class registerpage extends StatelessWidget {
  var _usernameController = TextEditingController();
  var _passwordController = TextEditingController();
  var confirmpasswordfield = TextEditingController();
  var form = GlobalKey<FormState>();

  Future<String> _registerUser() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    final user = await DatabaseHelper.getUserByUsername(username);
    if (user == null) {
      await DatabaseHelper.insertUser({
        'username': username,
        'password': password,
      });
      // Handle successful registration (e.g., show a success dialog)
      return "succeddfully registration";
    } else {
      // Handle username already exists
      return "username alredy exists";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Center(child:Column(children: [SizedBox(height: 30,),Image.network("https://static.wixstatic.com/media/5d1234_c5a83e578d6d43ed8b3a1a390b1b74aa~mv2.jpg/v1/fill/w_280,h_280,al_c,q_80,usm_0.66_1.00_0.01,enc_auto/unnamed.jpg") ,const SizedBox(height: 50,)
          ,Form( key: form ,child:Column (mainAxisAlignment: MainAxisAlignment.center,
            children: [ Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(controller: _usernameController ,keyboardType:TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: "Enter the Email Id",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),)),
                validator: (value){
                  if(value!=null){
                    if(value.length>5 && value.contains("@gmail")&& value.endsWith(".com")){
                      return null ;
                    }
                    return " Enter valid user name ";
                  }
                  return null;
                },),
            ),
              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(controller:_passwordController ,
                    decoration: InputDecoration(
                        hintText: "Enter the Password",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),)),
                    validator: (value) {
                      RegExp text = RegExp(r'^(?=.?[A-Z])(?=.?[a-z])(?=.?[0-9])(?=.?[!@#&*~]).{8,}$');
                      if (value!.isEmpty) {
                        if (text.hasMatch(value)) {
                          return null;
                        }


                        return "please enter the valid password";
                      }
                      return null;
                    }),
              ),
              const SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(controller: confirmpasswordfield ,
                    decoration: InputDecoration(
                        hintText: "Enter the Password",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),)),
                    validator: (val){
                      if(val!.isEmpty)
                        return 'Empty';
                      if(val != _passwordController.text)
                        return 'Not Match';
                      return null;
                    }),
              ),
              const SizedBox(height: 10,),



              ElevatedButton(onPressed: (){
                _registerUser();
                if(form.currentState!.validate()){
                  Navigator.pushReplacementNamed(context, '/login');
                }
              }, child: Text("Register")),


            ]

            ,) ,),],)
        ),
      ),
    );
  }
}

