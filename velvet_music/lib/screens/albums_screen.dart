// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../services/database_helper.dart';
import '../widgets/album_widget.dart';
import '../models/album_model.dart';
import 'album_screen.dart';

class AlbumsScreen extends StatefulWidget {
  const AlbumsScreen({super.key});

  @override
  State<AlbumsScreen> createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () async {
              Navigator.pop(context);
              setState(() {});
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text('All Albums'),
          backgroundColor: Colors.purple.shade400,
          centerTitle: true,
        ),
        body: FutureBuilder<List<Album>?>(
          future: DatabaseHelper.getAlbums(),
          builder: (context, AsyncSnapshot<List<Album>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (snapshot.hasData) {
              if (snapshot.data != null) {
                return ListView.builder(
                  itemBuilder: (context, index) => AlbumWidget(
                    album: snapshot.data![index],
                    onTap: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AlbumScreen(
                                    album: snapshot.data![index],
                                  )));
                      setState(() {});
                    },
                    onLongPress: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                  'Are you sure you want to delete this album?'),
                              actions: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.red)),
                                  onPressed: () async {
                                    await DatabaseHelper.deleteAlbum(
                                        snapshot.data![index]);
                                    Navigator.pop(context);
                                    setState(() {});
                                  },
                                  child: const Text('Yes'),
                                ),
                                ElevatedButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('No'),
                                ),
                              ],
                            );
                          });
                    },
                  ),
                  itemCount: snapshot.data!.length,
                );
              }
            } else {
              return const Center(
                child: Text('No albums yet'),
              );
            }
            return const SizedBox.shrink();
          },
        ));
  }
}
