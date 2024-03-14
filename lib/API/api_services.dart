import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kaltak/model/topheadlinemodel.dart';

class ApiServices{

  ApiServices({required this.title});
  final String title;

  final String apiKey = '18a95cbc3b7048599c9c6d063a870268';
 


  Future<List<ArticlesModel>> getAllNewsApi({required int pageCount}) async{
  final headlineApi = 'https://newsapi.org/v2/top-headlines?country=in&category=$title&apiKey=$apiKey&page=${pageCount}' ;
    try{
      final response = await http.get(Uri.parse(headlineApi));
      if(response.statusCode ==200){
        Map<String,dynamic> responseData = jsonDecode(response.body);
        List<dynamic> articlesBody =responseData['articles'];
        List<ArticlesModel> articlesList = articlesBody.map((item) => ArticlesModel.fromJson(item)).toList();
        return articlesList;
      }else{
        throw 'No News Found';
      }

    }catch(error){
      print(error);
      throw error;
    }
  }
}


// class TrendingAPIServices{
//   final String apiKey = '18a95cbc3b7048599c9c6d063a870268';

//   Future<List<ArticlesModel>> getTrendingApi() async{

//     try{
//       final response = await http.get(Uri.parse('https://newsapi.org/v2/everything?q=bitcoin&apiKey=$apiKey'));
//       if(response.statusCode == 200){
//         Map<String, dynamic> responseData = jsonDecode(response.body);
//         List<dynamic> articlesBody
//       }
//     }
//   }
// }
