import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kaltak/API/api_services.dart';
import 'package:kaltak/model/topheadlinemodel.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchItem extends StatefulWidget {
  const SearchItem({super.key, required this.searchItemrTitle});

  final String searchItemrTitle;
  @override
  State<SearchItem> createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  late ApiServices apiService;

  @override
  void initState() {
    super.initState();
    apiService = ApiServices(title: widget.searchItemrTitle);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        // leading: const SizedBox(height: 0,width: 0,),
        title: Container(
            margin: EdgeInsets.only(left: width * 0.15),
            child: Text(
              widget.searchItemrTitle,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            )),
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: FutureBuilder<List<ArticlesModel>>(
          future: apiService.getAllNewsApi(pageCount: 1),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SpinKitCircle(
                  size: 75,
                  color: Colors.blue,
                ),
              );
            } else {
              List<ArticlesModel> articlesList = snapshot.data ?? [];
              return ListView.builder(
                itemCount: articlesList.length,
                itemBuilder: (context, index) {
                  String date = articlesList[index].publishedAt.toString();
                  DateTime dates = DateTime.parse(date);
                  String formattedDates =
                      DateFormat('dd-MM-yyyy').format(dates);

                  return Container(
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
                          borderRadius: BorderRadius.circular(15),
                          child: CachedNetworkImage(
                            imageUrl: articlesList[index].urlToImage.toString(),
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              child: spin2,
                            ),
                            errorWidget: (context, url, error) => Image.network(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTw7HjpHNuzVssA9WGGtdCI0kC6gnLmjbMVuw&usqp=CAU',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                height: height * 0.05,
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(top: 5),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 5),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  articlesList[index].source!.name.toString(),
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
                          height: 10,
                        ),
                        Text(
                          articlesList[index].title.toString(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          articlesList[index].description.toString(),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final Uri uri =
                                Uri.parse(articlesList[index].url.toString());
                            if (!await launchUrl(uri)) {
                              throw Exception(
                                  'Could not launch ${articlesList[index].url}');
                            }
                            launchUrl(uri);
                          },
                          child: const Text('Read More'),
                        ),
                        if (index == articlesList.length - 1)
                          InkWell(
                            onTap: () {
                              print('loaded successfully');
                              // loadMore();
                            },
                            child: Container(
                              height: 60,
                              width: double.infinity,
                              color: Colors.grey.shade100,
                              child: const Center(
                                child: Text('Load More',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

const spin2 = SpinKitFadingCircle(
  color: Colors.amber,
  size: 75,
);
