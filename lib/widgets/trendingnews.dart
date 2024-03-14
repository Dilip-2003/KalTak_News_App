import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class TrendingNews extends StatefulWidget {
  const TrendingNews({Key? key}) : super(key: key);

  @override
  State<TrendingNews> createState() => _TrendingNewsState();
}

class _TrendingNewsState extends State<TrendingNews> {
  List articlesList = [];
  int page = 1;
  bool isLoading = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getNewsApi();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      // At the bottom of the list
      if (!isLoading) {
        setState(() {
          isLoading = true;
          page++;
        });
        loadMore();
      }
    }
  }

  Future<void> getNewsApi() async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/everything?q=business&q=politics&q=entertainment&q=health&q=science&q=technology&page=1&pageSize=100&apiKey=18a95cbc3b7048599c9c6d063a870268'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      if (data.containsKey('articles') && data['articles'] is List) {
        setState(() {
          articlesList = List.from(data['articles']);
        });
      }
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<void> loadMore() async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/everything?q=business&q=politics&q=entertainment&q=health&q=science&q=technology&page=$page&pageSize=100&apiKey=18a95cbc3b7048599c9c6d063a870268'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      if (data.containsKey('articles') && data['articles'] is List) {
        setState(() {
          articlesList.addAll(data['articles']);
          isLoading = false;
        });
      }
    } else {
      throw Exception('Failed to load more news');
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: articlesList.length,
              itemBuilder: (context, index) {
                String date = articlesList[index]['publishedAt'].toString();
                DateTime dates = DateTime.parse(date);
                String formattedDates = DateFormat('dd-MM-yyyy').format(dates);
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      padding: const EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(
                          horizontal: width * 0.010, vertical: height * 0.005),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl:
                                  articlesList[index]['urlToImage'].toString(),
                              // height: 200,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) => Image.network(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTw7HjpHNuzVssA9WGGtdCI0kC6gnLmjbMVuw&usqp=CAU',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  height: height * 0.04,
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(top: 5),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    articlesList[index]['source']['name']
                                        .toString(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )),
                              Text(
                                formattedDates,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            articlesList[index]['title'].toString(),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            articlesList[index]['description'].toString(),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              final Uri uri =
                                  Uri.parse(articlesList[index]['url'].toString());
                              if (!await launchUrl(uri)) {
                                throw Exception(
                                    'Could not launch ${articlesList[index]['url'].toString()}');
                              }
                              launchUrl(uri);
                            },
                            child: const Text('Read More'),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Visibility(
            visible: isLoading,
            child: Container(
              height: 60,
              width: double.infinity,
              color: Colors.grey.shade100,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
