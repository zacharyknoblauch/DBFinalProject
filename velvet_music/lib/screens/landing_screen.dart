// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:velvet_music/screens/label_screen.dart';
import 'package:velvet_music/screens/search_results_screen.dart';
import '../services/database_helper.dart';
import 'album_screen.dart';
import 'albums_screen.dart';
import 'artist_screen.dart';
import 'artists_screen.dart';
import 'labels_screen.dart';
import 'song_screen.dart';
import 'songs_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final TextEditingController selectParasController = TextEditingController();
  final TextEditingController joinParasController = TextEditingController();
  final TextEditingController extraParasController = TextEditingController();
  String selectParameters = '';
  String ddTableSelection = 'Album';
  String extraParameters = '';
  String advancedSearchString = 'Normal Search';
  bool advancedSearch = false;
  String ddJoinTableSelection = 'Album';
  String joinParameters = '';
  List<Map> queryResult = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text(
                    'What would you like to see?',
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AlbumsScreen()));
                          setState(() {});
                        },
                        child: const Text("All albums")),
                    ElevatedButton(
                        onPressed: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ArtistsScreen()));
                          setState(() {});
                        },
                        child: const Text("All artists")),
                    ElevatedButton(
                        onPressed: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SongsScreen()));
                          setState(() {});
                        },
                        child: const Text("All songs")),
                    ElevatedButton(
                        onPressed: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LabelsScreen()));
                          setState(() {});
                        },
                        child: const Text("All labels")),
                  ],
                );
              },
            );
          },
          icon: const Icon(Icons.search),
        ),
        title: const Text('Velvet Music'),
        backgroundColor: Colors.purple.shade400,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text(
                  'What would you like to add?',
                  textAlign: TextAlign.center,
                ),
                actions: [
                  ElevatedButton(
                      onPressed: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AlbumScreen()));
                        setState(() {});
                      },
                      child: const Text("Album")),
                  ElevatedButton(
                      onPressed: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ArtistScreen()));
                        setState(() {});
                      },
                      child: const Text("Artist")),
                  ElevatedButton(
                      onPressed: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SongScreen()));
                        setState(() {});
                      },
                      child: const Text("Song")),
                  ElevatedButton(
                      onPressed: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LabelScreen()));
                        setState(() {});
                      },
                      child: const Text("Label")),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text(
                        'What would you like to search for?',
                        textAlign: TextAlign.center,
                      ),
                      actions: [
                        const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            'Select the variables (Use \'*\' for all variables):',
                          ),
                        ),
                        TextFormField(
                          controller: selectParasController,
                          maxLines: 1,
                          decoration: const InputDecoration(
                              labelText: 'Select parameters',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 0.75,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ))),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            'From the table:',
                          ),
                        ),
                        DropdownButtonFormField<String>(
                            value: ddTableSelection,
                            onChanged: (String? selection) {
                              ddTableSelection = selection!;
                              setState(() {
                                ddTableSelection;
                              });
                            },
                            items: <String>['Album', 'Artist', 'Song', 'Label']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList()),
                        const Padding(
                          padding: EdgeInsets.all(5.0),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            'Where (If not using WHERE, leave blank):',
                          ),
                        ),
                        TextFormField(
                          controller: extraParasController,
                          maxLines: 1,
                          decoration: const InputDecoration(
                              labelText:
                                  'Where parameters (Ex):album.albumId = 1):',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 0.75,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ))),
                        ),
                        DropdownButtonFormField<String>(
                            value: advancedSearchString,
                            onChanged: (String? searchSelection) {
                              if (searchSelection == 'Advanced Search') {
                                advancedSearchString = searchSelection!;
                                advancedSearch = true;
                              } else {
                                advancedSearchString = searchSelection!;
                                advancedSearch = false;
                              }
                              setState(() {
                                advancedSearch;
                              });
                            },
                            items: <String>[
                              'Normal Search',
                              'Advanced Search',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList()),
                        const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text('If Using Advanced Search:'),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            'Joining with Table:',
                          ),
                        ),
                        DropdownButtonFormField<String>(
                            value: ddJoinTableSelection,
                            onChanged: (String? selection) {
                              ddJoinTableSelection = selection!;
                              setState(() {
                                ddJoinTableSelection;
                              });
                            },
                            items: <String>['Album', 'Artist', 'Song', 'Label']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList()),
                        const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            'Join parameters:',
                          ),
                        ),
                        TextFormField(
                          controller: joinParasController,
                          maxLines: 1,
                          decoration: const InputDecoration(
                              labelText: 'Join parameters',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 0.75,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ))),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ElevatedButton(
                              onPressed: () async {
                                selectParameters = selectParasController.text;
                                extraParameters = extraParasController.text;
                                print('\'$extraParameters\'');
                                joinParameters = joinParasController.text;
                                queryResult = await DatabaseHelper.searchDb(
                                    selectParameters,
                                    ddTableSelection,
                                    extraParameters,
                                    advancedSearch,
                                    ddJoinTableSelection,
                                    joinParameters);
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SearchResultsScreen(
                                                searchResult: queryResult)));
                                setState(() {});
                              },
                              child: const Text("Search")),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text("Refined Search"),
            ),
            // const Text("Hell yeah"),
            // ListView.builder(
            //   itemCount: queryResult.length,
            //   prototypeItem: ListTile(
            //     title: Text(json.encode(queryResult)),
            //   ),
            //   itemBuilder: (context, index) {
            //     return ListTile(
            //       title: Text(json.encode(queryResult)),
            //     );
            //   },
            // ),

            // FutureBuilder<List<Map>?> (
            //   future: DatabaseHelper.searchDb(
            //                         selectParameters,
            //                         ddTableSelection,
            //                         extraParameters,
            //                         advancedSearch,
            //                         ddJoinTableSelection,
            //                         joinParameters),
            //   builder: (context, AsyncSnapshot<List<Map>?> snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return const CircularProgressIndicator();
            //     } else if (snapshot.hasError) {
            //       return Center(child: Text(snapshot.error.toString()));
            //     } else if (snapshot.hasData) {
            //       if (snapshot.data != null) {
            //         return ListView.builder(
            //           itemBuilder: (context, index) => QueryResultWidget(
            //             result: queryResult.result,
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
            //         child: Text('No albums yet'),
            //       );
            //     }
            //     return const SizedBox.shrink();
            //   },
            // )
          ],
        ),
      ),
    );
  }
}
