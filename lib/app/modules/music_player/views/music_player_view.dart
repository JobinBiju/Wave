import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:wave/app/theme/text_theme.dart';

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
  final SongInfo songInfo;
  final Function changeTrack;
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
  bool isFav = false;
  String shuffleState, repeatState;
  List<String> shuffle = [
    'assets/shuffleOff.png',
    'assets/shuffleOn.png',
  ];
  List<String> repeat = [
    'assets/repeatOff.png',
    'assets/repeatOn.png',
    'assets/repeatOnOne.png'
  ];
  final AudioPlayer player = AudioPlayer();

  void initState() {
    super.initState();
    setSong(widget.songInfo);
    shuffleState = shuffle.first;
    player.setShuffleModeEnabled(false);
    repeatState = repeat.first;
    player.setLoopMode(LoopMode.off);
  }

  void dispose() {
    super.dispose();
    player?.dispose();
  }

  void setSong(SongInfo songInfo) async {
    //widget.songInfo = songInfo;
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
              Get.back();
            },
          ),
        ),
        title: Column(
          children: [
            Text(
              'Playing from',
              style: kPlayingFromTextStyle.copyWith(
                  color: Theme.of(context).primaryColorDark),
            ),
            Text(
              widget.songInfo.album.toString().toUpperCase(),
              style: kAlbumTitleTextStyle.copyWith(
                  color: Theme.of(context).primaryColorDark),
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
                      ? AssetImage('assets/noAlbum.jpg')
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
                      icon: Icon(
                        isFav
                            ? FontAwesomeIcons.solidHeart
                            : FontAwesomeIcons.heart,
                        color: Theme.of(context).primaryColor,
                        size: 25,
                      ),
                      onPressed: () {
                        isFav = !isFav;
                        setState(() {});
                      }),
                  Row(
                    children: [
                      IconButton(
                          icon:
                              Image(image: AssetImage(repeatState), width: 20),
                          onPressed: () {
                            if (repeatState == repeat.first) {
                              repeatState = repeat.elementAt(1);
                              player.setLoopMode(LoopMode.all);
                            } else if (repeatState == repeat.elementAt(1)) {
                              repeatState = repeat.last;
                              player.setLoopMode(LoopMode.one);
                            } else if (repeatState == repeat.last) {
                              repeatState = repeat.first;
                              player.setLoopMode(LoopMode.off);
                            }
                            setState(() {});
                          }),
                      IconButton(
                          icon:
                              Image(image: AssetImage(shuffleState), width: 20),
                          onPressed: () {
                            if (shuffleState == shuffle.first) {
                              shuffleState = shuffle.last;
                              player.setShuffleModeEnabled(true);
                            } else {
                              shuffleState = shuffle.first;
                              player.setShuffleModeEnabled(false);
                            }
                            setState(() {});
                          }),
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
                      style: kSongTitleTextStyle.copyWith(
                          color: Theme.of(context).primaryColorDark),
                      maxLines: 1),
                  Text(widget.songInfo.artist,
                      style: kSongArtistTextStyle.copyWith(
                          color: Theme.of(context).primaryColorDark)),
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
                value:
                    currentValue < maximumValue ? currentValue : maximumValue,
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
                  Text(currentTime,
                      style: kSongArtistTextStyle.copyWith(
                          color: Theme.of(context).primaryColorDark)),
                  Text(endTime,
                      style: kSongArtistTextStyle.copyWith(
                          color: Theme.of(context).primaryColorDark)),
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
                        shape: NeumorphicShape.concave,
                        boxShape: NeumorphicBoxShape.circle(),
                        depth: 20,
                        lightSource: LightSource.topLeft,
                        shadowLightColor: Colors.white30,
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
                        shape: NeumorphicShape.concave,
                        boxShape: NeumorphicBoxShape.circle(),
                        depth: 20,
                        lightSource: LightSource.topLeft,
                        shadowLightColor: Colors.white30,
                        shadowDarkColorEmboss: Colors.amber,
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
                        shape: NeumorphicShape.concave,
                        boxShape: NeumorphicBoxShape.circle(),
                        depth: 20,
                        lightSource: LightSource.topLeft,
                        shadowLightColor: Colors.white30,
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
