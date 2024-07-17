import 'package:flutter/material.dart';
import 'package:my_app/screens/note_detail.dart';
import 'package:my_app/utils/database_helper.dart';
import 'package:my_app/models/note.dart';
import 'package:sqflite/sqflite.dart';



class HomeScreen extends StatefulWidget {



  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    //singleton instance of database helper class
  DatabaseHelper databaseHelper = DatabaseHelper();

  //notelist declaration -> used to display all notes in the list

  List<Note> noteList = [];



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _updateListView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
         navigateToDetail('Add notes',Note('', '', DateTime.now().toString()));
        },
        child: Icon(Icons.add),
        ),
      appBar: AppBar(
        title: Text('Notes'),
        backgroundColor: Colors.green[100],
      ),
      body : ListView.builder(
        itemCount: noteList.length,
        itemBuilder:(context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 15,right: 15, top: 15, bottom: 5),
            child: Card(
              color :Colors.white,
              elevation: 5.0,
              child: ListTile(
                onTap:() {
                  navigateToDetail('Edit note',noteList[index]);
                },
                title: Text(noteList[index].title,
                style: TextStyle(
                  fontSize: 20
                ),
                ),
                subtitle: Text(noteList[index].description,
                style: TextStyle(
                  fontSize: 12
                ),
                ),
                trailing: IconButton(
                  onPressed: (){
                    delete(context, noteList[index]);
                  },
                  icon: Icon(Icons.delete),),
              ),
            ),
          );
        },
        ),
      );
  }

  void navigateToDetail(String title,Note note) async{
   bool result = await Navigator.push(context, MaterialPageRoute(builder:(context) => NoteDetails(appBarTitle: title,note: note,),));

   if(result == true){
    _updateListView();
   }
  }

  void delete(BuildContext context ,Note note) async{
    int result = await databaseHelper.deleteNote(note.id!);
    if(result != 0){
      showSnackBar(context, 'Note deleted successfully');
      _updateListView();
    }
  }
  void showSnackBar(BuildContext context, String message){
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


  void _updateListView() {
    final Future<List<Note>> futureNotes = databaseHelper.getNoteList();
    futureNotes.then((noteList) {
      setState(() {
        this.noteList = noteList;
       
      });
    });
  }
}