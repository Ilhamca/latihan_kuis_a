import 'package:flutter/material.dart';
import 'package:latihan_kuis_a/models/movie_model.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({super.key, required this.movie});

  final MovieModel movie;

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  _launchURL() async {
    var url = Uri.parse(widget.movie.movieUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login gagal: Username atau Password salah'),
            duration: Duration(seconds: 2),
          ),
        );
      }
      throw 'Could not launch ${widget.movie.movieUrl}';
    }
  }

  Widget _movieDetail() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,

      child: Column(
        children: [
          Image.network(widget.movie.imgUrl),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '${widget.movie.title} (${widget.movie.year})',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),

              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Directed by ${widget.movie.director}',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 12.0),
                  textDirection: TextDirection.ltr,
                ),
              ),

              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  widget.movie.synopsis,
                  style: TextStyle(fontSize: 12.0),
                  textAlign: TextAlign.left,
                ),
              ),

              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Genre: ${widget.movie.genre}',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),

              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Rating: ${widget.movie.rating}',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),

          SizedBox(height: 8.0),
          _wikiButton(),
          SizedBox(height: 40.0),
        ],
      ),
    );
  }

  Widget _wikiButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        backgroundColor: Colors.grey,
      ),
      onPressed: () {
        _launchURL();
      },
      child: Text('Go to Wikipedia', style: TextStyle(color: Colors.black)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Movie Details'), centerTitle: true),
      body: _movieDetail(),
    );
  }
}
