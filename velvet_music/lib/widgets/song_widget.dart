import 'package:flutter/material.dart';
import '../models/song_model.dart';

class SongWidget extends StatelessWidget {
  final Song song;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  const SongWidget(
      {super.key,
      required this.song,
      required this.onTap,
      required this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPress,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6),
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    song.songName,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),

                //TODO: Parse artistId into an artist name

                // const Padding(
                //   padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                //   child: Divider(
                //     thickness: 1,
                //   ),
                // ),
                // Text(song.,
                //     style: const TextStyle(
                //         fontSize: 16, fontWeight: FontWeight.w400))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
