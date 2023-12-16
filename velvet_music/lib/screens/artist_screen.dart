// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../models/artist_model.dart';
import '../services/database_helper.dart';

class ArtistScreen extends StatelessWidget {
  final Artist? artist;
  const ArtistScreen({super.key, this.artist});

  @override
  Widget build(BuildContext context) {
    final artistIdController = TextEditingController();
    final artistNameController = TextEditingController();
    final labelIdController = TextEditingController();

    if (artist != null) {
      artistNameController.text = artist!.artistName;
      artistIdController.text = artist!.artistId.toString();
      labelIdController.text = artist!.labelId.toString();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(artist == null ? 'Add an artist' : 'Edit artist'),
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
                      controller: artistNameController,
                      maxLines: 1,
                      decoration: const InputDecoration(
                          labelText: 'Artist name',
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
                      height: 55.0,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          onPressed: () async {
                            final artistId = int.parse(artistIdController.text);
                            final artistName = artistNameController.value.text;
                            final labelId = int.parse(labelIdController.text);

                            if (artistName.isEmpty) {
                              return;
                            }

                            final Artist model = Artist(
                              artistId: artistId,
                              artistName: artistName,
                              labelId: labelId,
                            );
                            if (artist == null) {
                              await DatabaseHelper.addArtist(model);
                            } else {
                              await DatabaseHelper.updateArtist(model);
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
                            artist == null ? 'Save' : 'Edit',
                            style: const TextStyle(fontSize: 20),
                          )),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text("WARNING: Do not save without entering an artist name AND an artist id",),
                  ),
                ]),
          )
        ]));
  }
}
