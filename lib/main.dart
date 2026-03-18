import 'package:app_todo_application/module/data/repositories/firestore_service.dart';
import 'package:app_todo_application/module/data/repositories/mockoon_api_service.dart';
import 'package:app_todo_application/module/domain/repositories/service.dart';
import 'package:app_todo_application/module/domain/usecases/add_task_usecase.dart';
import 'package:app_todo_application/module/presentation/screens/splash_screen/splash_screen.dart';
import 'package:app_todo_application/module/presentation/cubits/auth_cubit.dart';
import 'package:app_todo_application/module/presentation/cubits/task_cubit.dart';
import 'package:app_todo_application/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum DataSource { firebase, mockoon }

const DataSource currentDataSource = DataSource.firebase;

void main() async {
  // Đảm bảo các Widget của Flutter đã được khởi tạo xong
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  // Khởi tạo Firebase với "chìa khóa" kết nối
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  late IService dataService;

  if (currentDataSource == DataSource.firebase) {
    dataService = FirestoreService();
    print(" Đang chạy với FIREBASE");
  } else {
    dataService = MockoonApiService();
    print(" Đang chạy với MOCKOON API");
  }
  final addTaskUsecase = AddTaskUsecase(dataService);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              TaskCubit(addTaskUsecase, dataService)..loadTasks(),
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
