import 'package:flutter/material.dart';
import 'package:my_app/models/note.dart';
import 'package:my_app/utils/database_helper.dart';

class NoteDetails extends StatefulWidget {

final String appBarTitle;
final Note note;

 
 NoteDetails({super.key, required this.appBarTitle, required this.note});

  @override
  State<NoteDetails> createState() => _NoteDetailsState();
}

class _NoteDetailsState extends State<NoteDetails> {

  DatabaseHelper databaseHelper = DatabaseHelper();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController.text = widget.note.title;
    _descController.text = widget.note.description;
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(widget.appBarTitle) ,
        leading : IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,)
      ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            TextField(
              controller: _titleController ,
              onChanged: (value){
                widget.note.title = value;
              },
              decoration: InputDecoration(
                hintText: 'Title'
              ),
            ),
            SizedBox(height: 20,),
             TextField(
              controller: _descController ,
              onChanged: (value){
                widget.note.description = value;
              },
              decoration: InputDecoration(
                hintText: 'Description'
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.pink[100]),
                      ),
                      onPressed: (){
                            _save();
                      },
                      child: Text('Save'),
                      ),
                  ),
                  Container(width: 10,),
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.pink[100]),
                      ),
                      onPressed: (){
                              _delete();
                      },
                      child: Text('Delete'),
                      ),
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _save() async{
    widget.note.title = _titleController.text;
    widget.note.description = _descController.text;

    if(widget.note.id != null){
      await databaseHelper.updateNote(widget.note);
    }else{
      await databaseHelper.insertNote(widget.note);
    }
    Navigator.pop(context);
  }

  void _delete() async{
    if(widget.note.id == null){
      return;
    }
    await databaseHelper.deleteNote(widget.note.id!);
    Navigator.pop(context);
  }
}