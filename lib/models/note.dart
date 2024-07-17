class Note{

  int? id;
  late String  title;
  late String description;
  late String date;

  Note(this.title,  this.description,this.date,{this.id});
  
  
  //convert note object into map object
  
  
  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'title': title,
      'description': description,
      'date': date,
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  // Extract a Note object from a Map object
  Note.fromMapObject(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    description = map['description'];
    date = map['date'];
  }
}