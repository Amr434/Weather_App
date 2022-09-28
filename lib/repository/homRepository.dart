import 'package:get/get.dart';

import '../api/apiclient.dart';


class HomRepo extends GetxService{
 final Apiclient apiclient;
  HomRepo({required this.apiclient});



  Future<Response> getcurrentdata(url)async{
    return  await apiclient.get(url);


  }

 Future<Response> getfivedays(url)async{
   return  await apiclient.get(url);


 }


}