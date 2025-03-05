import 'package:app/homescreen.dart';
import 'package:app/news_controller.dart';
import 'package:app/rewarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_earning_app/news_controller.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final NewsController newsController = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.orange,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              _buildCustomClaimWidget(),
              Expanded(
                child: Obx(() {
                  if (newsController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                    itemCount: newsController.newsList.length,
                    itemBuilder: (context, index) {
                      var article = newsController.newsList[index];
                      return NewsCard(article: article);
                    },
                  );
                }),
              ),
            ],
          ),
        ),

        // Bottom Navigation Bar
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.orange,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          onTap: (index) {
            if (index == 0) {
              // Navigate to Home Screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      HomePage(), // Replace with your HomePage widget
                ),
              );
            } else if (index == 1) {
              // Navigate to Rewarding Screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      RewardingLevels(), // Replace with your RewardingScreen widget
                ),
              );
            }
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 40), label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.layers, size: 40), label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.person, size: 40), label: ""),
          ],
        ),
      ),
    );
  }

  // Custom Claim Widget
  Widget _buildCustomClaimWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF9F4), // Light cream color
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.redAccent, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 10),
              const Text(
                "10.00",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          OutlinedButton(
            onPressed: () {
              // Handle Claim button action
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text("Claim"),
          ),
        ],
      ),
    );
  }
}

// News Card Widget
class NewsCard extends StatelessWidget {
  final Map<String, dynamic> article;
  const NewsCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // News Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: article['urlToImage'] != null
                ? Image.network(article['urlToImage'],
                    height: 200, width: double.infinity, fit: BoxFit.cover)
                : Container(height: 200, color: Colors.grey[300]),
          ),

          // News Details
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article['title'] ?? "No Title",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(
                  article['description'] ?? "No description available",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  onPressed: () =>
                      Get.to(() => WebViewScreen(url: article['url'])),
                  child: const Text("Read More",
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// WebView Screen for Full Article
class WebViewScreen extends StatefulWidget {
  final String url;
  const WebViewScreen({super.key, required this.url});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("News Details"), backgroundColor: Colors.orange),
      body: WebViewWidget(controller: _controller),
    );
  }
}
