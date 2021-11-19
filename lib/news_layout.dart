import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_api/app_cubit.dart';
import 'package:simple_api/components.dart';
import 'package:simple_api/cubit/news_cubit.dart';
import 'package:simple_api/cubit/news_states.dart';
import 'package:simple_api/modules/search_screen.dart';

class NewsLayout extends StatefulWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  _NewsLayoutState createState() => _NewsLayoutState();
}

class _NewsLayoutState extends State<NewsLayout> {
  List<String> title = ['Business','Science','Sports',];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit(NewsInitialState())..getAllNews(),
      child: BlocConsumer<NewsCubit, NewsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = NewsCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: Text(title[cubit.currentIndex]),
                actions: [
                  IconButton(
                    onPressed: () {
                    AppCubit.get(context).changeAppMood();
                    },
                    icon: Icon(Icons.brightness_4),
                  ),
                  IconButton(
                    onPressed: () {
                      navigateTo(context, SearchScreen(),);
                    },
                    icon: Icon(Icons.search),
                  ),
                ],
              ),
              body: cubit.screens[cubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                items: cubit.bottomItems,
                onTap: (index) {
                  cubit.changeBottomNavigationBar(index);
                },
              ),
            );
          }),
    );
  }
}
