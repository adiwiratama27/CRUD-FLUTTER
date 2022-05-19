import 'package:flutter/material.dart';
import 'package:flutter_crud_api_sample_app/add-users.dart';
import 'package:flutter_crud_api_sample_app/models.dart';
import 'package:flutter_crud_api_sample_app/repository.dart';

void main() {
  runApp(MyApp());
}
  
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MOCKAPI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/home': (context) => HomePage(title: 'MOCKAPI'),
        '/add-users': (context) => AddUsers(),
      },
      home: HomePage(title: 'MOCKAPI'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Users> listUsers = [];
  Repository repository = Repository();

  getData() async {
    listUsers = await repository.getData();
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD FLUTTER'),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).popAndPushNamed('/add-users',
                  arguments: [
                    listUsers[index].id,
                    listUsers[index].nama,
                    listUsers[index].email
                  ]),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(listUsers[index].nama,
                      style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      Text(listUsers[index].email,
                      ),
                      Text(listUsers[index].id),
                    ],
                    ),
                  ),
                ),
                IconButton(onPressed: () async {
                  bool response = await repository.deleteData(listUsers[index].id);
                  if (response) {
                    print('Delete Data Done');
                  } else {
                    print('Delete Data Gagal');
                  }
                  getData();
                }, icon: Icon(Icons.delete))
              ],
            );
          },
          separatorBuilder: (context, indext) {
            return Divider();
          },
          itemCount: listUsers.length),
          floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).popAndPushNamed('/add-users');
        },
      ),

    );
  }
}
