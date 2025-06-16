import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List users = [] ;
  Future<void> fetchUsers() async{
    final response = await http.get(Uri.parse("http://jsonplaceholder.typicode.com/users"));
    if(response.statusCode ==200){
      users = jsonDecode(response.body) ;
    }else{
      throw Exception('Error ${response.statusCode}') ;
    }
    print(response.statusCode) ;
  }
  @override
  void initState(){
    fetchUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('API',style: TextStyle(color: Colors.white),),
      ),

      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index){
            final user =  users[index] ;
            return Card(
              margin: EdgeInsets.all(6),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: Text(user["name"][0]),
                ),
                title: Text(user["name"], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4,),
                    Text('Username: ${user["username"]} ', style: TextStyle(color:Colors.grey,)),
                    Text('email: ${user["email"]}', style: TextStyle(color:Colors.grey,)),
                    Text('Phone: ${user["phone"]}', style: TextStyle(color:Colors.grey,)),
                    Text('Website: ${user["website"]}', style: TextStyle(color:Colors.grey,)),

                  ],
                ),

              ),
            );
          }),
    );
  }
}
