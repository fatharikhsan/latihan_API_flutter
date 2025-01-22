import 'package:flutter/material.dart';
import 'http_service.dart';
import 'post_model.dart';

class PostsPage extends StatelessWidget {
  final HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Posts",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<List<Post>>(
        future: httpService.getPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final posts = snapshot.data!;
            return ListView.separated(
              padding: const EdgeInsets.all(10),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: Text(
                        post.userId.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      post.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      "User ID: ${post.userId}",
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 10),
            );
          } else {
            return const Center(
              child: Text(
                "No posts available",
                style: TextStyle(fontSize: 16),
              ),
            );
          }
        },
      ),
    );
  }
}
