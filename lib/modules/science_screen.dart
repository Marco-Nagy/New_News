import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:simple_api/cubit/news_cubit.dart';
import 'package:simple_api/cubit/news_states.dart';


import '../components.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List list =NewsCubit.get(context).scienceNewsList;
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {},
      builder: (context,  state) {
        return
          ScreenTypeLayout(
          mobile:buildMobileLayout(context,list),
          desktop: buildDesktopLayout(context,list),
          tablet: buildDesktopLayout(context,list),
          breakpoints: ScreenBreakpoints(
            desktop: 700,
            tablet: 570,
            watch: 100,
          ),
        );
      },
    );
  }
}