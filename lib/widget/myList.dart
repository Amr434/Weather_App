import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whether_app/controler/homecontroler.dart';
import 'package:whether_app/models/current_weather.dart';


class MyList extends GetView<Homecontroler> {

  @override
  Widget build(BuildContext context) {
    return
      Container(
        height: 150,
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) =>
              VerticalDivider(
                color: Colors.transparent,
                width: 5,
              ),
          itemCount: 3,
          itemBuilder: (context, index) {
            // CurrentWeather? data;
            // (controller.dataList.length > 0)
            //     ? data = controller.dataList[index]
            //     : data = null;
            return Container(
              width: 140,
              height: 150,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        // (data != null)?
                        '${'london'}'
                        //  : '',
                        ,
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black45,
                          fontFamily: 'flutterfonts',
                        ),
                      ),
                      Text(
                        // (data != null)?
                        '${(1632 - 273.15).round().toString()}\u2103'
                        //   : ''
                        ,
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black45,

                        ),
                      ),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset(

                            'assets/images/icon.png'
                        ),
                      ),
                      Text(
                        // (data != null) ?
                        'descripto'
                        // : '',
                        ,
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(
                          color: Colors.black45,

                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
  }
}
