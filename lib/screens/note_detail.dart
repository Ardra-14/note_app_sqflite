import 'package:flutter/material.dart';

class NoteDetails extends StatefulWidget {

final String appBarTitle;
 NoteDetails({super.key, required this.appBarTitle});

  @override
  State<NoteDetails> createState() => _NoteDetailsState();
}

class _NoteDetailsState extends State<NoteDetails> {


  final _titleController = TextEditingController();
  final _descController = TextEditingController();
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
              onChanged: (value){},
              decoration: InputDecoration(
                hintText: 'Title'
              ),
            ),
            SizedBox(height: 20,),
             TextField(
              controller: _descController ,
              onChanged: (value){},
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
                        backgroundColor: WidgetStatePropertyAll(Colors.pink[100]),
                      ),
                      onPressed: (){
                            
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
}