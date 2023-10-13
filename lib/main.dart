import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'login page.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(const Mathscorner());
}

class Mathscorner extends StatelessWidget {
  const Mathscorner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Maths Corner",
      theme: ThemeData(primarySwatch:Colors.lightGreen),
      home:Splashscreen(),
      routes: {
        '/login': (context) => loginpage(),
        // Add more routes as needed
      },
    );
  }
}
class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 5),(){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> loginpage()));

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [Image.network("https://static.wixstatic.com/media/5d1234_c5a83e578d6d43ed8b3a1a390b1b74aa~mv2.jpg/v1/fill/w_280,h_280,al_c,q_80,usm_0.66_1.00_0.01,enc_auto/unnamed.jpg"),

        ],),),
    );
  }
}


class secondpage extends StatefulWidget {
  const secondpage({Key? key,required this.userName}) : super(key: key);
  final String userName;
  @override
  State<secondpage> createState() => _secondpageState();
}

class _secondpageState extends State<secondpage> {
  Future<List>getData()async{
    var urlsring = "https://api.github.com/users/hadley/repos";
    var url = Uri.parse(urlsring);
    var Response = await http.get(url);
    List resp = jsonDecode(Response.body);
    return resp;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(centerTitle: true,title: Text("Welcome ${widget.userName}"),backgroundColor: Colors.lightGreen,),
      body: Center(child: FutureBuilder(future: getData(),
        builder: (BuildContext context,AsyncSnapshot snapshot)
        {
          if(snapshot.hasData){
            List totalData = snapshot.data;
            return ListView.builder(itemCount: totalData.length,
                itemBuilder: (BuildContext context,index)
                {
                  Map singleData = totalData[index];
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(elevation: 30,shadowColor: Colors.green,borderOnForeground: true,
                      color: Colors.greenAccent,
                      child:ExpansionTile(
                        leading: Image.network("https://avatars.githubusercontent.com/u/4196?v=4"),
                        title: Text(singleData["id"].toString(),style: TextStyle(color: Colors.purple,fontWeight: FontWeight.bold),),
                        subtitle: Text(singleData["node_id"].toString(),style: TextStyle(color: Colors.purple,fontWeight: FontWeight.bold),),
                        trailing: Icon(Icons.arrow_right),
                      ) ,

                    ),
                  );


                });
          }
          else{
            return Text("failure");
          }
        },),),

    );
  }
}
