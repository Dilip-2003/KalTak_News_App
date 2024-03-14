
import 'package:flutter/material.dart';
import 'package:kaltak/widgets/searchitem.dart';

class NewsCategory extends StatefulWidget {
 const NewsCategory({super.key,});
  @override
  State<NewsCategory> createState() => _NewsCategoryState();
}

class _NewsCategoryState extends State<NewsCategory> {

  List<String> categorieUrlList = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXNTGTyF9ZkoqwkkqNVHyvrmMW0QBk2envaw&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZgv0rMgE-8_F6IgroEplCmcZRfaKzLNYkCg&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaKs-GfErywGvfFWaPePbORKDEwqMvIyRahw&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRUg_8ZD6RHxQkJrnj64sVwmW5n6pGV8FkNA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOdnQjnSrwuLIf4qgP6sQm9reG3-IsPwu_vA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdGsY8ZMzCuZOedVpbq-dTG5LcaH5qndYndA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRKCUJqY9odWSPcsrdCmyE2PgaedWkTKd6O4A&usqp=CAU'
  ];

  List<String> catogorieTitleList = [
    'politics',
    'Science',
    'Business',
    'Technology',
    'Health',
    'Sports',
    'Entertainment'
  ]; 


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration( 
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10),),
        color: Colors.grey.shade200,
      ),
      height: 125,
      child: ListView.builder(
        itemCount:categorieUrlList.length,
        scrollDirection: Axis.horizontal,

        itemBuilder: (context, index) {
          return InkWell( 
            onTap: () {
              
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchItem(searchItemrTitle: catogorieTitleList[index]);
              },));
            },

            child: Column(
              children: [ 
                Container( 
                  height: 75,
                  width: 140,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(categorieUrlList[index],
                    height: 50,
                    width: 120,
                    fit: BoxFit.cover,),
                  ),
                ),

                Text(catogorieTitleList[index],style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w900,color: Colors.black54),), 
              ],
            ),
          );

      },),
    );
  }
}