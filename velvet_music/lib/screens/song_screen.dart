// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../models/song_model.dart';
import '../services/database_helper.dart';

class SongScreen extends StatelessWidget {
  final Song? song;
  const SongScreen({super.key, this.song});

  @override
  Widget build(BuildContext context) {
    final songIdController = TextEditingController();
    final songNameController = TextEditingController();
    final artistIdController = TextEditingController();
    final songLinkController = TextEditingController();
    final artIdController = TextEditingController();
    final trackListIdController = TextEditingController();
    final albumIdController = TextEditingController();

    if (song != null) {
      songNameController.text = song!.songName;
      songIdController.text = song!.songId.toString();
      artistIdController.text = song!.artistId.toString();
      songLinkController.text = song!.songLink!;
      artIdController.text = song!.artId.toString();
      trackListIdController.text = song!.trackListId.toString();
      albumIdController.text = song!.albumId.toString();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(song == null ? 'Add a song' : 'Edit song'),
          backgroundColor: Colors.purple.shade400,
          centerTitle: true,
        ),
        body: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      controller: songNameController,
                      maxLines: 1,
                      decoration: const InputDecoration(
                          labelText: 'Song name',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 0.75,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ))),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    controller: songIdController,
                    maxLines: 1,
                    decoration: const InputDecoration(
                        labelText: 'Song id',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 0.75,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    controller: trackListIdController,
                    maxLines: 1,
                    decoration: const InputDecoration(
                        labelText: 'Track list id',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 0.75,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ))),
                  ),
                ),
              ),
              Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        controller: albumIdController,
                        maxLines: 1,
                        decoration: const InputDecoration(
                            labelText: 'Album id',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 0.75,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ))),
                      ),
                    ),
                  ),
            ]),
          ),
          Expanded(
            child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        controller: artistIdController,
                        maxLines: 1,
                        decoration: const InputDecoration(
                            labelText: 'Artist id',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 0.75,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        controller: artIdController,
                        maxLines: 1,
                        decoration: const InputDecoration(
                            labelText: 'Art id',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 0.75,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        controller: songLinkController,
                        maxLines: 1,
                        decoration: const InputDecoration(
                            labelText: 'Song link',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 0.75,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SizedBox(
                      height: 55.0,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          onPressed: () async {
                            final songName = songNameController.text;
                            final songId = int.parse(songIdController.text);
                            final artistId = int.parse(artistIdController.text);
                                final songLink = songLinkController.value.text;
                            final artId = int.parse(artIdController.text);
                            final trackListId =
                                int.parse(trackListIdController.text);
                                final albumId = int.parse(albumIdController.text);

                            if (songName.isEmpty) {
                              return;
                            }

                            final Song model = Song(
                              songId: songId,
                              songName: songName,
                              artistId: artistId,
                              songLink: songLink,
                              artId: artId,
                              trackListId: trackListId,
                              albumId: albumId,
                            );
                            if (song == null) {
                              await DatabaseHelper.addSong(model);
                            } else {
                              await DatabaseHelper.updateSong(model);
                            }

                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: Colors.white,
                                        width: 0.75,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      )))),
                          child: Text(
                            song == null ? 'Save' : 'Edit',
                            style: const TextStyle(fontSize: 20),
                          )),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      "WARNING: Do not save without entering an song name AND an song id",
                    ),
                  ),
                ]),
          )
        ]));
  }
}
