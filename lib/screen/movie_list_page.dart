import 'package:flutter/material.dart';
import 'package:latihan_kuis_a/models/movie_model.dart';
import 'package:latihan_kuis_a/screen/movie_detail_page.dart';

class MovieListPage extends StatelessWidget {
  const MovieListPage({super.key, required this.username});
  final String username;

  @override
  Widget build(BuildContext context) {
    /*
      implementasikan widget untuk menampilkan list movie yang sudah diambil dari dummy data
        - gunakan ListView.builder untuk menampilkan list movie
        - setiap item movie ditampilkan menggunakan Card widget yang berisi judul movie dan poster movie
        - ketika item movie ditekan, navigasikan ke halaman MovieDetailPage dengan membawa data movie yang dipilih
     */
    return Scaffold(
      appBar: AppBar(title: Text('Movie List')),
      body: ListView.builder(
        itemCount: movieList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailPage(movie: movieList[index]),
                ),
              );
            },
            child: Card(
              child: ListTile(
                leading: Image.network(movieList[index].imgUrl),
                title: Text(movieList[index].title),
                subtitle: Text(movieList[index].genre),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${movieList[index].rating}'),
                    Icon(Icons.star, color: Colors.yellow),
                  ],
                ),
                contentPadding: EdgeInsets.all(8.0),
              ),
            ),
          );
        },
      ),
    );
  }
}
