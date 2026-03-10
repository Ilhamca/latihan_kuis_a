import 'package:flutter/material.dart';
import 'package:latihan_kuis_a/models/movie_model.dart';
import 'package:latihan_kuis_a/screen/movie_detail_page.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({super.key, required this.username});
  final String username;

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  final Set<int> _bookmarkedMovies = {};

  void toggleBookmark(int movieId) {
    setState(() {
      if (_bookmarkedMovies.contains(movieId)) {
        _bookmarkedMovies.remove(movieId);
      } else {
        _bookmarkedMovies.add(movieId);
      }
    });
  }

  Widget _bookmarkButton(int movieId) {
    if (!_bookmarkedMovies.contains(movieId)) {
      return IconButton(
        icon: Icon(Icons.bookmark_outline),
        onPressed: () {
          toggleBookmark(movieId);
          bookmarkSnackbar(
            movieList[movieId].title,
            _bookmarkedMovies.contains(movieId),
          );
        },
      );
    } else {
      return IconButton(
        icon: Icon(Icons.bookmark),
        onPressed: () {
          toggleBookmark(movieId);
          bookmarkSnackbar(
            movieList[movieId].title,
            _bookmarkedMovies.contains(movieId),
          );
          // Implement bookmark functionality here
        },
      );
    }
  }

  void bookmarkSnackbar(String title, bool isBookmarked) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isBookmarked
              ? 'Movie "$title" ditambahkan ke bookmark'
              : 'Movie "$title" dihapus dari bookmark',
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }

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
                  builder: (context) =>
                      MovieDetailPage(movie: movieList[index]),
                ),
              );
            },

            child: Card(
              elevation: 5,
              margin: EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        movieList[index].imgUrl,
                        width: 100,
                        height: 150,
                        fit: BoxFit.fitHeight,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                    SizedBox(width: 12.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${movieList[index].title} (${movieList[index].year})',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(movieList[index].genre),
                          SizedBox(height: 8.0),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 20,
                                  ),
                                ),
                                TextSpan(
                                  text: ' ${movieList[index].rating} / 10',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [_bookmarkButton(index)],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
