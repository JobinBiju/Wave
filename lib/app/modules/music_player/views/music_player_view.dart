import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:wave/app/theme/text_theme.dart';

import '../controllers/music_player_controller.dart';

// class MusicPlayerView extends GetView<MusicPlayerController> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('MusicPlayerView'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Text(
//           'MusicPlayerView is working',
//           style: TextStyle(fontSize: 20),
//         ),
//       ),
//     );
//   }
// }
class MusicPlayerView extends StatefulWidget {
  SongInfo songInfo;
  Function changeTrack;
  final GlobalKey<MusicPlayerViewState> key;
  MusicPlayerView({this.songInfo, this.changeTrack, this.key})
      : super(key: key);
  @override
  MusicPlayerViewState createState() => MusicPlayerViewState();
}

class MusicPlayerViewState extends State<MusicPlayerView> {
  double minimumValue = 0.0, maximumValue = 0.0, currentValue = 0.0;
  String currentTime = '', endTime = '';
  bool isPlaying = false;
  final AudioPlayer player = AudioPlayer();

  void initState() {
    super.initState();
    setSong(widget.songInfo);
  }

  void dispose() {
    super.dispose();
    player?.dispose();
  }

  void setSong(SongInfo songInfo) async {
    widget.songInfo = songInfo;
    await player.setUrl(widget.songInfo.uri);
    currentValue = minimumValue;
    maximumValue = player.duration.inMilliseconds.toDouble();
    setState(() {
      currentTime = getDuration(currentValue);
      endTime = getDuration(maximumValue);
    });
    isPlaying = false;
    changeStatus();
    player.positionStream.listen((duration) {
      currentValue = duration.inMilliseconds.toDouble();
      setState(() {
        currentTime = getDuration(currentValue);
      });
    });
  }

  void changeStatus() {
    setState(() {
      isPlaying = !isPlaying;
    });
    if (isPlaying) {
      player.play();
    } else {
      player.pause();
    }
  }

  String getDuration(double value) {
    Duration duration = Duration(milliseconds: value.round());

    return [duration.inMinutes, duration.inSeconds]
        .map((element) => element.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: Transform.rotate(
          angle: -90 * pi / 180,
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              size: 20,
            ),
            color: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        title: Column(
          children: [
            Text(
              'Playing from',
              style: kPlayingFromTextStyle,
            ),
            Text(
              widget.songInfo.album.toString().toUpperCase(),
              style: kAlbumTitleTextStyle,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert,
              size: 24,
            ),
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            NeumorphicSongCover(
              child: Container(
                height: 170,
                width: 170,
                child: Image(
                  image: widget.songInfo.albumArtwork == null
                      ? AssetImage('assets/music_gradient.jpg')
                      : FileImage(File(widget.songInfo.albumArtwork)),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      icon: Icon(FontAwesomeIcons.heart,
                          color: Theme.of(context).primaryColor),
                      onPressed: () {}),
                  Row(
                    children: [
                      IconButton(
                          icon: Icon(FontAwesomeIcons.heart,
                              color: Theme.of(context).primaryColorLight),
                          onPressed: () {}),
                      IconButton(
                          icon: Icon(FontAwesomeIcons.heart,
                              color: Theme.of(context).primaryColorLight),
                          onPressed: () {}),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 45),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.songInfo.title,
                      style: kSongTitleTextStyle, maxLines: 1),
                  Text(widget.songInfo.artist, style: kSongArtistTextStyle),
                  SizedBox(height: 8),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22),
              child: Slider(
                inactiveColor: Theme.of(context).primaryColorLight,
                activeColor: Theme.of(context).primaryColor,
                min: minimumValue,
                max: maximumValue,
                value: currentValue,
                onChanged: (value) {
                  currentValue = value;
                  player.seek(Duration(milliseconds: currentValue.round()));
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 45),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(currentTime, style: kSongArtistTextStyle),
                  Text(endTime, style: kSongArtistTextStyle),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 70),
              child: Container(
                width: 400,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Neumorphic(
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        boxShape: NeumorphicBoxShape.circle(),
                        depth: 20,
                        lightSource: LightSource.topLeft,
                        shadowLightColor: Colors.white38,
                        shadowDarkColor: Colors.black87,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: IconButton(
                            icon: Icon(
                              Icons.skip_previous,
                              color: Theme.of(context).primaryColor,
                              size: 30,
                            ),
                            onPressed: () {
                              widget.changeTrack(false);
                            }),
                      ),
                    ),
                    Neumorphic(
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        boxShape: NeumorphicBoxShape.circle(),
                        depth: 20,
                        lightSource: LightSource.topLeft,
                        shadowLightColor: Colors.white38,
                        shadowDarkColor: Colors.black87,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: IconButton(
                          icon: Icon(
                            isPlaying
                                ? FontAwesomeIcons.pause
                                : FontAwesomeIcons.play,
                            color: Theme.of(context).primaryColor,
                            size: 30,
                          ),
                          onPressed: () {
                            changeStatus();
                          },
                        ),
                      ),
                    ),
                    Neumorphic(
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        boxShape: NeumorphicBoxShape.circle(),
                        depth: 20,
                        lightSource: LightSource.topLeft,
                        shadowLightColor: Colors.white38,
                        shadowDarkColor: Colors.black87,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: IconButton(
                          icon: Icon(
                            Icons.skip_next,
                            color: Theme.of(context).primaryColor,
                            size: 30,
                          ),
                          onPressed: () {
                            widget.changeTrack(true);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 50),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Theme.of(context).primaryColor,
              ),
              child: IconButton(
                icon: Transform.rotate(
                  angle: 90 * pi / 180,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 20,
                    ),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                ),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NeumorphicSongCover extends StatelessWidget {
  final Widget child;
  const NeumorphicSongCover({
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.circle(),
        depth: 24,
        lightSource: LightSource.topLeft,
        shadowLightColor: Colors.white.withOpacity(0.4),
        shadowDarkColor: Colors.black,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Neumorphic(
          style: NeumorphicStyle(
            shape: NeumorphicShape.flat,
            boxShape: NeumorphicBoxShape.circle(),
            depth: 8,
            lightSource: LightSource.topLeft,
            shadowLightColor: Colors.white30,
            shadowDarkColor: Colors.black87,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Neumorphic(
              style: NeumorphicStyle(
                shape: NeumorphicShape.flat,
                boxShape: NeumorphicBoxShape.circle(),
                depth: 20,
                lightSource: LightSource.topLeft,
                shadowLightColor: Colors.black87,
                shadowDarkColor: Colors.white24,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
