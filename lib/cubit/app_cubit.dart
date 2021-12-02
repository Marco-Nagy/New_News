import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_api/data/my_shared.dart';


abstract class AppState {}
class InitAppsState extends AppState {}
class ChangeMoodState extends AppState{}
//class GetSearchNewsState extends AppState{}
class AppCubit extends Cubit<AppState> {
  AppCubit() : super(InitAppsState());





  static AppCubit get(context) => BlocProvider.of(context);
  ThemeMode themeMode =ThemeMode.dark;
  bool isDark = false;
  void getAppMode(){
   isDark = MyShared.sharedPreferences.getBool("isDark")??false;
   themeMode =(isDark)? ThemeMode.dark: ThemeMode.light;
    emit(ChangeMoodState());
  }
  void changeAppMood() {
    isDark = !isDark;
    themeMode =(isDark)? ThemeMode.dark: ThemeMode.light;
    MyShared.saveData(key: 'isDark', value: isDark);
    emit(ChangeMoodState());
  }

}