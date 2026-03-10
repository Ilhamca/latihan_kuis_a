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
            content: Text('Link tidak dapat dibuka'),
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
                padding: EdgeInsets.fromLTRB(12.0, 10, 12.0, 0),
                child: Text(
                  '${widget.movie.title} (${widget.movie.year})',
                  style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(12.0, 1, 12.0, 0),
                child: Text(
                  'Directed by ${widget.movie.director}',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: const Color.fromARGB(255, 129, 129, 129),
                  ),
                  textDirection: TextDirection.ltr,
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(12.0, 5, 12.0, 0),
                child: Text(
                  widget.movie.synopsis,
                  style: TextStyle(fontSize: 12.0),
                  textAlign: TextAlign.left,
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(12.0, 7, 12.0, 0),
                child: Text(
                  'Genre : ${widget.movie.genre} \n'
                  'Cast   : ${widget.movie.casts.join(', ')}',
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(12.0, 10, 12.0, 0),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 26.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  WidgetSpan(
                    child: Icon(Icons.star, color: Colors.orange, size: 30),
                  ),
                  TextSpan(text: ' Rated ${widget.movie.rating} / 10'),
                ],
              ),
            ),
          ),

          SizedBox(height: 8.0),
          _wikiButton(),
          SizedBox(height: 40.0),
        ],
      ),
    );
  }

  Widget _wikiButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          backgroundColor: Colors.grey,
        ),
        onPressed: () {
          _launchURL();
        },
        child: Text('Go to Wikipedia', style: TextStyle(color: Colors.black)),
      ),
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
