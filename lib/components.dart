import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:simple_api/cubit/news_cubit.dart';
import 'package:simple_api/modules/web_view_screen.dart';

import 'adaptive/adaptive_indecator.dart';
List<dynamic> newsList=[];

 myNewsListView(newsList) {
  return newsList.isEmpty
      ? Center(child: AdaptiveIndicator())
      : ListView.separated(
          itemCount: newsList.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(

              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: NewsCubit.get(context).selectedListItem == index?
               Theme.of(context).cardTheme.color : Theme.of(context).primaryColor ,
              ),
              child: ScreenTypeLayout(
                mobile:  InkWell(
                  onTap: () {
                    navigateTo(context, WebViewScreen(newsList[index]['url']));
                  },
                  child: listItem(newsList, context, index),
                ),
                tablet: InkWell(
                  onTap: () {
                    NewsCubit.get(context).selectedItem(index);
                  },
                  child: listItem(newsList, context, index),
                ),
                desktop: InkWell(
                  onTap: () {
                    NewsCubit.get(context).selectedItem(index);

                  },
                  child: listItem(newsList, context,index),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => Divider(
            height: 5,
            thickness: 0.5,
            color: Colors.teal,
          ),
        );
}
 listItem(newsList,context, index){
  NewsCubit.get(context).selectedListItem == index;
  return  Row(
    children: [
      Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade300,
            image: DecorationImage(
              image: NetworkImage(
                  newsList[index]['urlToImage'] ?? ""),
              fit: BoxFit.cover,
            )),
      ),
      SizedBox(
        width: 20,
      ),
      Expanded(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                newsList[index]['title'],
                style: Theme.of(context).textTheme.bodyText1,
                maxLines: 3,
              ),
              Text(
                newsList[index]['publishedAt'],
                style: Theme.of(context).textTheme.bodyText1,
                maxLines: 1,
              )
            ],
          ),
        ),
      ),
    ],
  );
}
 myNewsDetails( newsList,context) {

  return newsList.isEmpty
      ? Center(child: AdaptiveIndicator())
      : Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Theme.of(context).cardTheme.color,
        ),

            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height/2.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade300,
                      image: DecorationImage(
                        image: NetworkImage(
                            newsList[NewsCubit.get(context).selectedListItem]['urlToImage'] ?? ""),
                        fit: BoxFit.fill,
                      )),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          newsList[NewsCubit.get(context).selectedListItem]['title'] ?? "",
                          style: Theme.of(context).textTheme.bodyText1,
                          maxLines: 3,
                        ),
                        Text(
                          newsList[NewsCubit.get(context).selectedListItem]['publishedAt'] ?? "",
                          style: Theme.of(context).textTheme.bodyText1,
                          maxLines: 1,
                        ),
                        Text(
                          newsList[NewsCubit.get(context).selectedListItem]['description'] ?? "",
                          style: Theme.of(context).textTheme.bodyText1,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );

}
buildMobileLayout(context,newsList)=> Builder(
  builder: (context) {

    return     Scaffold(

      body: myNewsListView(newsList,),

    );
  }
);
buildDesktopLayout(context, newsList)=> Row(
  children: [
    Expanded(
      flex: 1,
      child: Container(
          child: Scaffold(
            body: myNewsListView(newsList),
          )),
    ),
    Expanded(
      flex: 2,
      child: myNewsDetails(newsList, context),
    ),
  ],
);
Widget defaultTextField(
  BuildContext context, {
  required TextEditingController controller,
  TextInputType? type,
  TextInputAction inputAction = TextInputAction.next,
  required FormFieldValidator validator,
  required String label,
  required IconData prefixIcon,
  Widget? suffixIcon,
  bool obscureText = false,
  GestureTapCallback? onTap,
  ValueChanged? onChange,
  ValueChanged? onFieldSubmitted,
}) =>
    TextFormField(
      onTap: onTap,
      controller: controller,
      obscureText: obscureText,
      keyboardType: type,
      textInputAction: inputAction,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: Theme.of(context).primaryTextTheme.subtitle1,
        fillColor: Theme.of(context).primaryColor ,
        filled: true,
        border: OutlineInputBorder(borderSide: BorderSide(width: 20,color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(50),
        ),
        prefixIcon: Icon(
          prefixIcon,
        ),
        suffixIcon: suffixIcon,
      ),
      style: Theme.of(context).primaryTextTheme.subtitle1,
      validator: validator,
      onChanged: onChange,
      onFieldSubmitted: onFieldSubmitted,
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) => widget),
    );
