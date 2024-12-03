import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app_provider/db/functions/db_functions.dart';
import 'package:student_app_provider/domain/student_all_list/student_all_list.dart';
import 'package:student_app_provider/pages/home_screen.dart';
import 'package:student_app_provider/pages/splash_screen.dart';
Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await initializeData();
  //getAllStudent();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //getAllStudent(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>StudentAllList())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.indigo,
        ),
        home: const SplashScreen(),
        routes: {
          'HomeScreen':(context)=>const HomeScreen()
        },
      ),
    );
  }
}