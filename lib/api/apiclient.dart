
import 'package:get/get.dart';

class Apiclient  extends GetConnect implements GetxService {

  String baseurl;
  Apiclient({required this.baseurl}){
    baseUrl=baseurl;
  }
  //https://api.openweathermap.org/data/2.5/forecast?q=cairo&appid=4e9c5501ef9621fdea76a49c19bb7e33



  Future<Response>getdata(url) async{
    try{
      return await get(url);

    }
    catch(e){
      return Response(
          statusCode: 1,
          statusText: e.toString()
      );
    }


  }


 }




