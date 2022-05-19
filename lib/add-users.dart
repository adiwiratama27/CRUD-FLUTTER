import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter_crud_api_sample_app/repository.dart';

class AddUsers extends StatefulWidget {
  const AddUsers({ Key? key }) : super(key: key);

  @override
  State<AddUsers> createState() => _AddUsersState();
}

class _AddUsersState extends State<AddUsers> {
  Repository repository = Repository();
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List<String>;
    
    if (args[1].isNotEmpty) {
      _namaController.text = args[1];
    }
    
    if (args[2].isNotEmpty) {
      _emailController.text = args[2];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman AddUsers'),
        ),
        body: Container(
          child: Column(
            children: [
              TextField(
                controller: _namaController,
                decoration: InputDecoration(hintText: 'Nama'),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(hintText: 'Email'),
              ),
              Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: [
                  ElevatedButton(onPressed: () async {
                bool response = await repository.postData(_namaController.text, _emailController.text);

                if(response){
                  Navigator.of(context).popAndPushNamed('/home');
                }else{
                  print('Post data error');
                }
              }, 
              child: Text('Submit')
              ),
              SizedBox(
                width: 20,
              ),

              ElevatedButton(
                onPressed: () async {
                bool response = await repository.putData(int.parse(args[0]),
                  _namaController.text, _emailController.text);

                if (response)   {
                  Navigator.of(context).popAndPushNamed('/home');
                } else {
                  print('Update data error');
                }
              }, 
              child: Text('Update')
              )
              ],
              ),
              ),
            ],
          ),
        ),
    );
  }
}