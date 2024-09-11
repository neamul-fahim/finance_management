import 'package:finance_management/auth/login.dart';
import 'package:finance_management/firebase_options.dart';
import 'package:finance_management/provider/expense_provider.dart';
import 'package:finance_management/provider/income_provider.dart';
import 'package:finance_management/provider/total_income_expense_provider.dart';
import 'package:finance_management/provider/user_data_provider.dart';
import 'package:finance_management/repository/expense_repository.dart';
import 'package:finance_management/repository/income_repository.dart';
import 'package:finance_management/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


Future <void> main() async{
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);

  runApp(
    MultiProvider(providers: [
     ChangeNotifierProvider(create: (context)=> ExpenseProvider(ExpenseRepository())),
     ChangeNotifierProvider(create: (context)=> IncomeProvider(IncomeRepository())),
     ChangeNotifierProvider(create: (context)=> TotalIncomeExpenseProvider()),
     ChangeNotifierProvider(create: (context)=> UserDataProvider()),


    ],
    child: MyApp(),
    )
    
  );}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print('FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF');
    print(FirebaseAuth.instance.currentUser?.email);
    return MaterialApp(
      title: 'Exin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FirebaseAuth.instance.currentUser?.uid==null? LogIN():HomePage(),
    );
  }
}
