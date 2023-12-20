import 'package:hive_flutter/hive_flutter.dart';

import 'cubit/drag_drop_cubit.dart';
import 'injector.dart';
import 'screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(DragDropApp());
}

class DragDropApp extends StatelessWidget {
  const DragDropApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DragDropCubit(),
      child: LayoutBuilder(builder: (context, layout) {
        return OrientationBuilder(builder: (context, orientation) {
          size.init(layout, orientation);
          return MaterialApp(
            title: 'DragDrop GridView',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: Home(),
          );
        });
      }),
    );
  }
}
