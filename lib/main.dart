import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:td2_2223/viewmodels/TaskViewModel.dart';
import 'package:td2_2223/viewmodels/settingviewmodel.dart';
import 'home.dart';
import 'mytheme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) {
                SettingViewModel settingViewModel = SettingViewModel();
                return settingViewModel;
              }),
          ChangeNotifierProvider(
              create: (_) {
                TaskViewModel taskViewModel = TaskViewModel();
                taskViewModel.generateTasks();
                return taskViewModel;
              })
        ],
        child: Consumer<SettingViewModel>(
            builder: (context, SettingViewModel notifier, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: notifier.isDark ? MyTheme.dark() : MyTheme.light(),
                title: 'Liste des tâches',
                home: HomePage(),
              );
            }
        )
    );
  }
}
