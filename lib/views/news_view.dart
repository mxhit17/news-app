import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/riverpod_sm/news_provider.dart';
import 'package:news_app/views/reading_article_view.dart';

class NewsPage extends ConsumerWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsList = ref.watch(newsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'N E W S',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        actions: [
          TextButton(
            onPressed: () {
              ref.read(newsProvider.notifier).fetchNews();
            },
            child: const Icon(
              Icons.replay,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: newsList.length,
                itemBuilder: (context, index) {
                  final item = newsList[index];
                  var author = item['author'] ?? 'null';
                  var title = item['title'];
                  var image = item['urlToImage'] ??=
                      'https://photos.google.com/u/1/photo/AF1QipM77UCF4qRAE5k87QYf8tD98KYe5pKxOwSFh3Co';
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(130, 224, 176, 255),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        height: 100,
                        child: GestureDetector(
                          onLongPressStart: (details) {
                            showDescriptionDialog(context, item['description']);
                          },
                          onLongPressEnd: (details) {
                            if (Navigator.of(context).canPop()) {
                              Navigator.of(context).pop();
                            }
                          },
                          child: ListTile(
                            leading: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.network(image),
                            ),
                            title: Text(
                              title,
                              maxLines: 2,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  author,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReadingArticle(
                                    data: newsList[index],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const Opacity(
                        opacity: 0,
                        child: Divider(
                          thickness: 8,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.deepPurple,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'NEWSPAPER',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'TRENDING',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'PROFILE',
          ),
        ],
      ),
    );
  }

  void showDescriptionDialog(BuildContext context, String descTxt) {
    Widget alertDialog = AlertDialog(
      title: const Text('Description'),
      content: Text(descTxt),
      backgroundColor: const Color.fromARGB(255, 224, 176, 255),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }
}
