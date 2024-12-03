import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student_app_provider/db/functions/data/data_model.dart';
import 'package:student_app_provider/domain/student_all_list/student_all_list.dart';

//ValueNotifier<List<StudentModel>> studentModelListNotifier = ValueNotifier([]);

late Database db;


Future<void> initializeData() async {
  db = await openDatabase(
    'student.db',
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute(
        'CREATE TABLE student(id INTEGER PRIMARY KEY, name TEXT, age TEXT, gName TEXT, phone TEXT, profilePath TEXT)',
      );
    },
  );
}



Future<void> addStudent(StudentModel val,BuildContext context) async {
  await db.rawInsert(
    'INSERT INTO student (name, age, gName, phone, profilePath) VALUES (?,?,?,?,?)',
    [val.name, val.age, val.gName, val.phone, val.profilePath],
  );
  Provider.of<StudentAllList>(context,listen: false).studentList(val);
  //await getAllStudent(context);
}

Future<void>deleteStudent(int id,BuildContext context)async{
  await db.rawDelete('DELETE FROM student WHERE id = ?',[id]);
  await getAllStudent(context);
}

Future<void> getAllStudent(BuildContext context) async {
  Provider.of<StudentAllList>(context,listen: false).studentAll.clear;
  Provider.of<StudentAllList>(context,listen: false).clear();
  //studentModelListNotifier.value.clear();
  final values = await db.rawQuery('SELECT * FROM student');
  
  for (var map in values) {
    final student = StudentModel.fromMap(map);
    Provider.of<StudentAllList>(context,listen: false).studentList(student);
    
  }
}

Future<void> update(int id, String newName,String newAge,String newgName,String newPhone, String newProfilePath,BuildContext context) async {
  await db.rawUpdate(
    'UPDATE student SET name = ?, age = ?, gName = ?, phone = ?, profilePath = ? WHERE id = ?',
    [newName,newAge,newgName,newPhone, newProfilePath, id],
  );
  getAllStudent(context);
}
