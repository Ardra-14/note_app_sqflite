class Note{

  late int _id;
  late String _title;
  late String _description;
  late String _date;

  Note(this._id ,this._title,  this._description,this._date);
  
  int get id => _id;
  String get title => _title;
  String get description => _description;
  String get date => _date;

  set title(String newTitle){
    if(newTitle.length <= 255){
      this._title = newTitle;
    }
  }

  set description(String newDesc){
    if(newDesc.length <= 255){
      this._description = newDesc;
    }
  }

  set date(String newDate){
    this._date = newDate;
  }

  //convert note object into map object
  
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if(id != null){
      map['id'] = _id;
    }

    map['title'] = _title;
    map['description'] = _description;
    map['date'] = _date;

    return map;
  }


  //extract note object from map object

    Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._date = map['date'];
  }
}