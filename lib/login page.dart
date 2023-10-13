import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maths_corner/registerpage.dart';
import 'clspage.dart';
import 'main.dart';

class loginpage extends StatelessWidget {
  var _usernameController = TextEditingController();
  var _passwordController = TextEditingController();

  Future<void> _loginUser(BuildContext context) async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    final user = await DatabaseHelper.getUserByUsername(username);
    if (user != null && user['password'] == password) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => secondpage(userName: _usernameController.text)));
    }
      else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
          content: Text('Invalid username or password.'),
    duration: Duration(seconds: 2)
          ),);
      }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Center(child:Column(children: [SizedBox(height: 30,),Image.network("https://static.wixstatic.com/media/5d1234_c5a83e578d6d43ed8b3a1a390b1b74aa~mv2.jpg/v1/fill/w_280,h_280,al_c,q_80,usm_0.66_1.00_0.01,enc_auto/unnamed.jpg") ,const SizedBox(height: 50,)
          ,Padding(
            padding: const EdgeInsets.all(13.0),
            child: TextField(controller: _usernameController,decoration: InputDecoration(labelText: 'Username',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),),
          ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: TextField(controller: _passwordController,decoration: InputDecoration(labelText: 'Password',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),obscureText: true),
          ),
          SizedBox(height: 10,),
          ElevatedButton(
              onPressed: () => _loginUser(context),
              child: Text("LOGIN")),
          SizedBox(height: 15,),
          ElevatedButton(onPressed: (){}, child: Text("Login with Google")),
          SizedBox(height: 15,),
          Center(child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
            Text("Not a user?",style:TextStyle(fontSize: 20,),textAlign: TextAlign.center,),
            TextButton(onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => registerpage()));

            }, child: Text("Click here",style:TextStyle(fontSize: 20,),textAlign: TextAlign.center,))
          ],),)



        ],),
    ),),);
  }
}


//Navigator.push(context, MaterialPageRoute(builder: (context) => secondpage(userName: _usernameController.text,passWord: _passwordController.text,)));