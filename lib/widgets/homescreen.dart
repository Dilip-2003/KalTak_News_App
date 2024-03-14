import 'package:flutter/material.dart';
import 'package:kaltak/widgets/categorie.dart';
import 'package:kaltak/widgets/trendingnews.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        leading: const SizedBox(width: 5,),
        title: Container(
          padding: const EdgeInsets.only(left: 85),
          child: const Text('KalTak',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,),)),
      ),

      body: Container(
        child: Column( 
          children: [ 
            const NewsCategory(),
            Container(
          padding:  const EdgeInsets.all(10),
          child:const Center(child: Text('Trending News',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),)),
        ),
        const Flexible(child: TrendingNews()),
          ],
        ),
      ),
    );
  }



}