import 'package:drag_drop/injector.dart';

import 'core/constants/colors.dart';
import 'screens/home.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'cubit/drag_drop_cubit.dart';
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
      create: (context) => DragDropCubit()..init(),
      child: LayoutBuilder(builder: (context, layout) {
        size.init(layout, context);
        return MaterialApp(
          title: 'DragDrop GridView',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: kP),
              useMaterial3: true,
              appBarTheme: AppBarTheme(
                backgroundColor: kWhite,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: kP.withOpacity(.1),
                  statusBarIconBrightness: Brightness.dark,
                  statusBarBrightness: Brightness.light,
                ),
              )),
          home: Home(),
        );
      }),
    );
  }
}
