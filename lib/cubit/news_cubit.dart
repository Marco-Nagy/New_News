import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_api/data/dio_helper.dart';
import 'package:simple_api/modules/business_screen.dart';
import 'package:simple_api/modules/science_screen.dart';
import 'package:simple_api/modules/sports_screen.dart';


import 'news_states.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit(NewsStates initialState) : super(initialState);

  static NewsCubit get(context) => BlocProvider.of(context);
  List<dynamic> businessNewsList = [];
  List<dynamic> scienceNewsList = [];
  List<dynamic> sportsNewsList = [];
  List<dynamic> searchNewsList = [];

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.business,
        ),
        label: 'Business'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.science,
        ),
        label: 'Science'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.sports_soccer,
        ),
        label: 'Sports'),
  ];

  void changeBottomNavigationBar(int index) {
    currentIndex = index;
    emit(NewsBottomNavigateState());
  }

  List<Widget> screens = [
    BusinessScreen(),
    ScienceScreen(),
    SportsScreen(),
  ];

  Future<List<dynamic>> getNews({
    String? country = "eg",
    required String category,
  }) async {
    var response = await DioHelper.dio.get(
      'v2/top-headlines',
      queryParameters: {
        'country': country,
        'category': category,
        //a552a4a2da2c4805865c9a9c85056383
        //156ce3ce099b432dab6ae5abc6245fe6
        'apiKey': "156ce3ce099b432dab6ae5abc6245fe6",
      },
    );
    var newsList = response.data['articles'];
    emit(GetNewsSuccessState());
    return newsList;
  }

  void getAllNews() async {
    businessNewsList = await getNews(category: "business");
    scienceNewsList = await getNews(category: "science");
    sportsNewsList = await getNews(category: "sports");
  }

  Future<List<dynamic>> getSearch(String value) async {
    var response = await DioHelper.dio.get(
      'v2/everything',
      queryParameters: {
        'q': value,
        'apiKey': "156ce3ce099b432dab6ae5abc6245fe6",
      },
    );
    var searchList = response.data['articles'];
    searchNewsList = searchList;
    print('$searchList');
    emit(GetSearchNewsState());
    return searchList;
  }
}
