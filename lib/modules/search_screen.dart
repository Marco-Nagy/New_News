import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_api/cubit/app_cubit.dart';
import 'package:simple_api/components.dart';
import 'package:simple_api/cubit/news_cubit.dart';
import 'package:simple_api/cubit/news_states.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultTextField(context,
                  controller: searchController,
                  type: TextInputType.text,
                  onChange: (value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Search must not be Empty";
                    }
                    return null;
                  },
                  label: 'Search',
                  prefixIcon: Icons.search,
                  inputAction: TextInputAction.search,
                ),
              ),
              Expanded(
                  child: Visibility(
                    visible: NewsCubit.get(context).isNewsVisible,
                    child: myNewsListView(
                NewsCubit.get(context).searchNewsList,
              ),
                  ))
            ],
          ),
        );
      },
    );
  }
}
