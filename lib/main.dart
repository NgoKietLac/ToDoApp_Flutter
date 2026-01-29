import 'package:app_todo_application/FirestoreService/firestore_service.dart';
import 'package:app_todo_application/SplashScreen/splash_screen.dart';
import 'package:app_todo_application/cubit/auth_cubit.dart';
import 'package:app_todo_application/cubit/task_cubit.dart';
import 'package:app_todo_application/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  // Đảm bảo các Widget của Flutter đã được khởi tạo xong
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo Firebase với "chìa khóa" kết nối
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TaskCubit(FirestoreService())..loadTasks(),
        ),
        BlocProvider(create: (context) => AuthCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AppToDo',
      home: SplashScreen(),
      // home: ListPage(),
    );
  }
}
