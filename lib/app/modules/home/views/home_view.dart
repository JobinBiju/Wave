import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import 'package:get/get.dart';
import 'package:wave/app/modules/music_player/views/music_player_view.dart';
import 'package:wave/app/theme/text_theme.dart';

import '../controllers/home_controller.dart';

// class HomeView extends GetView<HomeController> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(backgroundColor: Colors.white,leading: Icon(Icons.music_note,color: Colors.black),title: Text('Music App', style: TextStyle(color: Colors.black)),),
//       body: ListView.separated(separatorBuilder:(context,index)=>Divider(),itemCount: songs.length,itemBuilder: (context,index)=>ListTile(leading: CircleAvatar(backgroundImage: songs[index].albumArtwork==null?AssetImage('assets/images/music_gradient.jpg'):FileImage(File(songs[index].albumArtwork)),),title: Text(songs[index].title),subtitle: Text(songs[index].artist),onTap: ()  {
// currentIndex=index;
// Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MusicPlayer(changeTrack: changeTrack,songInfo: songs[currentIndex],key: key)));
//       },),),
//     );
//   }
// }
class HomeView extends StatefulWidget {
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  List<SongInfo> songs = [];
  int currentIndex = 0;
  final GlobalKey<MusicPlayerViewState> key = GlobalKey<MusicPlayerViewState>();
  void initState() {
    super.initState();
    getTracks();
  }

  void getTracks() async {
    songs = await audioQuery.getSongs();
    setState(() {
      songs = songs;
    });
  }

  void changeTrack(bool isNext) {
    if (isNext) {
      if (currentIndex != songs.length - 1) {
        currentIndex++;
      }
    } else {
      if (currentIndex != 0) {
        currentIndex--;
      }
    }
    key.currentState.setSong(songs[currentIndex]);
  }

  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(Icons.music_note, color: Colors.white),
        title: Text('All Songs', style: TextStyle(color: Colors.white)),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        itemCount: songs.length,
        itemBuilder: (context, index) => ListTile(
          leading: CircleAvatar(
            backgroundImage: songs[index].albumArtwork == null
                ? AssetImage('assets/music_gradient.jpg')
                : FileImage(File(songs[index].albumArtwork)),
          ),
          title: Text(songs[index].title,
              style: kSongArtistTextStyle.copyWith(color: Colors.white)),
          subtitle: Text(songs[index].artist,
              style: kSongArtistTextStyle.copyWith(color: Colors.white)),
          onTap: () {
            currentIndex = index;
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MusicPlayerView(
                    changeTrack: changeTrack,
                    songInfo: songs[currentIndex],
                    key: key)));
          },
        ),
      ),
    );
  }
}
