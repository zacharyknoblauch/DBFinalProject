// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:velvet_music/screens/label_screen.dart';
import 'package:velvet_music/widgets/query_result_widget.dart';

import 'album_screen.dart';
import 'artist_screen.dart';
import 'song_screen.dart';
import 'video_screen.dart';

class SearchResultsScreen extends StatelessWidget {
  final TextEditingController videoLinkController = TextEditingController();
  String videoLink = '';

  final List<Map> searchResult;
  SearchResultsScreen({super.key, required this.searchResult});
  @override
  Widget build(BuildContext context) {
    final splitInput = json.encode(searchResult).split('":"').toString();
    // print(splitInput);
    final splitInput2 = splitInput.split('":').toString();
    // print(splitInput2);
    final splitInput3 = splitInput2.split(',"').toString();
    // print(splitInput3);
    final splitInput4 = splitInput3.split('",').toString();
    // print(splitInput4);
    final splitInput5 = splitInput4.split('[[[[{"').toString();
    // print(splitInput5);
    final splitInput6 = splitInput5.split('}]]]]]').toString();
    print(splitInput6);
    final splitInput7 = splitInput6.split(', ');
    final List columns = [];
    final List rows = [];
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text("Search Results"),
        backgroundColor: Colors.purple.shade400,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text(
                      "Please click the button after pasting video link"),
                  actions: [
                    TextFormField(
                      controller: videoLinkController,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        videoLink = videoLinkController.text;
                        // await Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const VideoScreen()));
                      },
                      child: const Text("Play Video"),
                    ),
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: searchResult.length,
        itemBuilder: (context, index) {
          return QueryResultWidget(
            // onTap: () async {

            // },
            // onLongPress: () async {},
            result: json.encode(searchResult.elementAt(index)),
          );
        },
      ),
      // Text(json.encode(searchResult)),

      // ListView.builder(
      //   itemCount: searchResult.length,
      //   itemBuilder: (context, index) {
      //     return ListTile(
      //       title: Text(json.encode(searchResult.elementAt(index))),
      //     );
      //   },
      // ),

      // FutureBuilder<List<Album>?>(
      //   future: DatabaseHelper.getAlbums(),
      //   builder: (context, AsyncSnapshot<List<Album>?> snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const CircularProgressIndicator();
      //     } else if (snapshot.hasError) {
      //       return Center(child: Text(snapshot.error.toString()));
      //     } else if (snapshot.hasData) {
      //       if (snapshot.data != null) {
      //         return ListView.builder(
      //           itemBuilder: (context, index) => AlbumWidget(
      //             album: snapshot.data![index],
      //             onTap: () async {
      //               await Navigator.push(
      //                   context,
      //                   MaterialPageRoute(
      //                       builder: (context) => AlbumScreen(
      //                             album: snapshot.data![index],
      //                           )));
      //               setState(() {});
      //             },
      //             onLongPress: () async {
      //               showDialog(
      //                   context: context,
      //                   builder: (context) {
      //                     return AlertDialog(
      //                       title: const Text(
      //                           'Are you sure you want to delete this album?'),
      //                       actions: [
      //                         ElevatedButton(
      //                           style: ButtonStyle(
      //                               backgroundColor:
      //                                   MaterialStateProperty.all(
      //                                       Colors.red)),
      //                           onPressed: () async {
      //                             await DatabaseHelper.deleteAlbum(
      //                                 snapshot.data![index]);
      //                             Navigator.pop(context);
      //                             setState(() {});
      //                           },
      //                           child: const Text('Yes'),
      //                         ),
      //                         ElevatedButton(
      //                           onPressed: () => Navigator.pop(context),
      //                           child: const Text('No'),
      //                         ),
      //                       ],
      //                     );
      //                   });
      //             },
      //           ),
      //           itemCount: snapshot.data!.length,
      //         );
      //       }
      //     } else {
      //       return const Center(
      //         child: Text('No results matching your search perameters'),
      //       );
      //     }
      //     return const SizedBox.shrink();
      //   },
      // )
    );
  }
}
