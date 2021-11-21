import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_api/modules/web_view_screen.dart';

Widget myNewsListView(List<dynamic> newsList) {
  return newsList.isEmpty
      ? Center(child: CircularProgressIndicator.adaptive())
      : ListView.separated(
          itemCount: newsList.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Theme.of(context).cardTheme.color,
              ),
              child: InkWell(
                onTap: (){
                  navigateTo(context, WebViewScreen(newsList[index]['url']));
                },
                child: Row(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade300,
                          image: DecorationImage(
                            image:
                                NetworkImage(newsList[index]['urlToImage'] ?? ""),
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
                ),
              ),
            );
          }, separatorBuilder: (BuildContext context, int index)=>
      Divider(height: 5,thickness:0.5 ,color: Colors.teal,),
        );

}

Widget defaultTextField({
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
  ValueChanged?onFieldSubmitted,
}) =>
    TextFormField(
      onTap: onTap,
      controller: controller,
      obscureText: obscureText,
      keyboardType: type,
      textInputAction: inputAction,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        prefixIcon: Icon(
          prefixIcon,
        ),
        suffixIcon: suffixIcon,
      ),
      validator: validator,
      onChanged: onChange,
      onFieldSubmitted: onFieldSubmitted,
    );

void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
        builder: (BuildContext context) =>widget),);
