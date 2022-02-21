import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:peliculas_app/models/models.dart';

class MovieSlider extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  const MovieSlider({
    Key? key, 
    required this.movies, 
    required this.onNextPage,
    this.title

    }) : super(key: key);

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  
  final ScrollController scrollController = new ScrollController();
  //El init me permite ejecutar codigo la primera vez que el init es construido 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500){
        //TODO:llamar provider
        widget.onNextPage();
      }
      
    });
  }
  //Este es cuando el widget va a ser destruido 
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(this.widget.title != null) 
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20,),
              child: Text(this.widget.title!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
            ),
          SizedBox(height: 5),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: ( _ , int index) =>  _MoviePoster( widget.movies[index] )
            ),
          ),
        ],
      ),
    );
  }
}



class _MoviePoster extends StatelessWidget {
  final Movie movie;

  const _MoviePoster(this.movie,);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'), 
                image: NetworkImage(movie.fullPosterImg),
                width: 130,
                height: 190,
                fit: BoxFit.cover,
                ),
            ),
          ),
          const SizedBox(height: 5,),  
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
            ),

        ],
      ),
    );
  }
}