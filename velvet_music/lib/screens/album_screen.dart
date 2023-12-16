// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../models/album_model.dart';
import '../services/database_helper.dart';

class AlbumScreen extends StatelessWidget {
  final Album? album;
  const AlbumScreen({super.key, this.album});

  @override
  Widget build(BuildContext context) {
    final albumNameController = TextEditingController();
    final albumIdController = TextEditingController();
    final artistIdController = TextEditingController();
    final releaseDateController = TextEditingController();
    final labelIdController = TextEditingController();
    final classIdController = TextEditingController();
    final artIdController = TextEditingController();
    final trackListIdController = TextEditingController();

    if (album != null) {
      albumNameController.text = album!.albumName;
      albumIdController.text = album!.albumId.toString();
      artistIdController.text = album!.artistId.toString();
      releaseDateController.text = album!.releaseDate!;
      labelIdController.text = album!.labelId.toString();
      classIdController.text = album!.classId.toString();
      artIdController.text = album!.artId.toString();
      trackListIdController.text = album!.trackListId.toString();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(album == null ? 'Add an album' : 'Edit album'),
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
                      controller: albumNameController,
                      maxLines: 1,
                      decoration: const InputDecoration(
                          labelText: 'Album name',
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
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    controller: releaseDateController,
                    maxLines: 1,
                    decoration: const InputDecoration(
                        labelText: 'Release date',
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
                    controller: classIdController,
                    maxLines: 1,
                    decoration: const InputDecoration(
                        labelText: 'Class id',
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
                        controller: labelIdController,
                        maxLines: 1,
                        decoration: const InputDecoration(
                            labelText: 'Label id',
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
                      height: 55.0,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          onPressed: () async {
                            final albumName = albumNameController.value.text;
                            final albumId = int.parse(albumIdController.text);
                            final artistId = int.parse(artistIdController.text);
                            final releaseDate =
                                releaseDateController.value.text;
                            final labelId = int.parse(labelIdController.text);
                            final classId = int.parse(classIdController.text);
                            final artId = int.parse(artIdController.text);
                            final trackListId =
                                int.parse(trackListIdController.text);

                            if (albumName.isEmpty) {
                              return;
                            }

                            final Album model = Album(
                              albumName: albumName,
                              albumId: albumId,
                              artistId: artistId,
                              releaseDate: releaseDate,
                              labelId: labelId,
                              classId: classId,
                              artId: artId,
                              trackListId: trackListId,
                            );
                            if (album == null) {
                              await DatabaseHelper.addAlbum(model);
                            } else {
                              await DatabaseHelper.updateAlbum(model);
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
                            album == null ? 'Save' : 'Edit',
                            style: const TextStyle(fontSize: 20),
                          )),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      "WARNING: Do not save without entering an album name AND an album id",
                    ),
                  ),
                ]),
          )
        ]));
  }
}
