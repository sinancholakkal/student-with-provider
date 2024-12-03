import 'package:flutter/material.dart';
import 'package:student_app_provider/db/functions/data/data_model.dart';

class StudentAllList with ChangeNotifier{
  List<StudentModel> studentAll =[];
  void clear(){
    studentAll.clear();
    notifyListeners();
  }
  void studentList(StudentModel data){
    studentAll.add(data);
    notifyListeners();
  }
}