import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/constants/colors.dart';
import 'cubit/drag_drop_cubit.dart';
import 'injector.dart';
import 'screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const DragDropApp());
}

class DragDropApp extends StatelessWidget {
  const DragDropApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DragDropCubit()..init(),
      child: LayoutBuilder(builder: (context, layout) {
        size.init(layout, context);
        return MaterialApp(
          title: 'DragDrop GridView',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: kP),
            useMaterial3: false,
            scaffoldBackgroundColor: kWhite,
          ),
          home: const Home(),
        );
      }),
    );
  }
}
