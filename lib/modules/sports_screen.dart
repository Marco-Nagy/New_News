import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_api/cubit/news_cubit.dart';
import 'package:simple_api/cubit/news_states.dart';

import '../components.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {},
      builder: (context,  state) {
        return Scaffold(
          body: myNewsListView(NewsCubit.get(context).sportsNewsList),
        );
      },
    );
  }
}