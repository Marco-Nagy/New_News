import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_api/remote/dio_helper.dart';

abstract class AppState {}
class InitAppsState extends AppState {}
class ChangeMoodState extends AppState{}
//class GetSearchNewsState extends AppState{}
class AppCubit extends Cubit<AppState> {
  AppCubit() : super(InitAppsState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  void changeAppMood() {
    isDark = !isDark;
    emit(ChangeMoodState());
  }

}