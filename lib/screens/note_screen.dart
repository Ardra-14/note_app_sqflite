import 'package:flutter/material.dart';
import 'package:my_app/screens/note_detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int count = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
         navigateToDetail('Add notes');
        },
        child: Icon(Icons.add),
        ),
      appBar: AppBar(
        title: Text('Notes'),
        backgroundColor: Colors.green[100],
      ),
      body : ListView.builder(
        itemCount: count,
        itemBuilder:(context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 15,right: 15, top: 15, bottom: 5),
            child: Card(
              color :Colors.white,
              elevation: 5.0,
              child: ListTile(
                onTap:() {
                  navigateToDetail('Edit note');
                },
                title: Text('Note 1',
                style: TextStyle(
                  fontSize: 20
                ),
                ),
                subtitle: Text('Note 1 description',
                style: TextStyle(
                  fontSize: 12
                ),
                ),
                trailing: IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.delete),),
              ),
            ),
          );
        },
        ),
      );
  }

  void navigateToDetail(String title){
    Navigator.push(context, MaterialPageRoute(builder:(context) => NoteDetails(appBarTitle: title,),));
  }
}