import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(image: AssetImage(
            'assets/images/nointernet.jpg'
          )),
          SizedBox(height: 40,),
          Column(
            children: [
              Text('No Internet ',style: GoogleFonts.aBeeZee(

                color: Colors.black45,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center
                ,
                children: [
                  Text(' check connection',style: GoogleFonts.aBeeZee(

                    color: Colors.black45,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                  SizedBox(width: 5,),
                  Icon(Icons.check_circle_outline,color: Colors.black45,)
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
