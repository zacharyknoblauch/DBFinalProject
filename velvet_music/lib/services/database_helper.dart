import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:velvet_music/models/album_model.dart';

import '../models/artist_model.dart';
import '../models/label_model.dart';
import '../models/song_model.dart';

class DatabaseHelper {
  static const int _newVersion = 2;
  static const String _dbName = "Velvet.db";

  static Future<Database> _getDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) async => {
        await db.execute(''
            "CREATE TABLE IF NOT EXISTS Label (labelId INTEGER NOT NULL PRIMARY KEY, labelName TEXT NOT NULL, artistId INTEGER);"),
        await db.execute(''
            "CREATE TABLE IF NOT EXISTS Artist (artistId INTEGER NOT NULL PRIMARY KEY, artistName TEXT NOT NULL, labelId INTEGER);"),
        await db.execute(''
            "CREATE TABLE IF NOT EXISTS Album (albumId INTEGER NOT NULL PRIMARY KEY, albumName TEXT NOT NULL, artistId INTEGER, releaseDate TEXT, labelId INTEGER, classId INTEGER, artId INTEGER, trackListId INTEGER);"),
        await db.execute(''
            "CREATE TABLE IF NOT EXISTS Song (songId INTEGER NOT NULL PRIMARY KEY, songName TEXT NOT NULL, artistId INTEGER, songLink TEXT, artId, TEXT, trackListId INTEGER, albumId INTEGER);"),
        /*, FOREIGN KEY (artistId) REFERENCES Artist(artistId), FOREIGN KEY (labelId) REFERENCES Label(labelId), FOREIGN KEY (trackListId) REFERENCES Song(trackListId);"),*/
      },
      onUpgrade: (db, oldVersion, newVersion) async => {
        await db.execute(''
            "CREATE TABLE IF NOT EXISTS Label (labelId INTEGER NOT NULL PRIMARY KEY, labelName TEXT NOT NULL, artistId INTEGER);"),
        await db.execute(''
            "CREATE TABLE IF NOT EXISTS Artist (artistId INTEGER NOT NULL PRIMARY KEY, artistName TEXT NOT NULL, labelId INTEGER);"),
        await db.execute(''
            "CREATE TABLE IF NOT EXISTS Album (albumId INTEGER NOT NULL PRIMARY KEY, albumName TEXT NOT NULL, artistId INTEGER, releaseDate TEXT, labelId INTEGER, classId INTEGER, artId INTEGER, trackListId INTEGER);"),
        await db.execute(''
            "CREATE TABLE IF NOT EXISTS Song (songId INTEGER NOT NULL PRIMARY KEY, songName TEXT NOT NULL, artistId INTEGER, songLink TEXT, artId, TEXT, trackListId INTEGER, albumId INTEGER);"),
        /*, FOREIGN KEY (artistId) REFERENCES Artist(artistId), FOREIGN KEY (labelId) REFERENCES Label(labelId), FOREIGN KEY (trackListId) REFERENCES Song(trackListId);"),*/
      },
      version: _newVersion,
    );
  }

  static Future<List<Map>> searchDb(
      String selectVar,
      String fromTable,
      String extraVar,
      bool advancedSearch,
      String joinTable,
      String joinVar) async {
    final db = await _getDB();
    final List<Map> selectReturn;
    if (advancedSearch) {
      if (extraVar == '') {
        //   selectReturn = await db.query(
        //     fromTable,
        //     columns: [selectVar],
        //     );
        selectReturn = await db.rawQuery(
            'SELECT $selectVar FROM $fromTable LEFT JOIN $joinTable USING ($joinVar);');
      } else {
        selectReturn = await db.rawQuery(
            'SELECT $selectVar FROM $fromTable LEFT JOIN $joinTable USING ($joinVar) WHERE $extraVar;');
      }
    } else {
      if (extraVar == '') {
        selectReturn = await db.rawQuery("SELECT $selectVar FROM $fromTable;");
      } else {
        selectReturn =
            await db.rawQuery("SELECT $selectVar FROM $fromTable WHERE $extraVar;");
      }
    }
    return selectReturn;
  }
  // List<Map> names = await db.rawQuery('select Name.name, count(Date.date) from Name left join Date using(id) group by Name.name');
  //       if (names.isNotEmpty) {
  //         return names;
  //         }

  // static Future<bool> _isExist(Album album) async {
  //   final db = await _getDB();
  //   final idCheck = album.albumId;
  //   final int result =
  //       await db.rawQuery("EXISTS(SELECT * FROM Album WHERE albumId = $idCheck);");
  //   if (result == true) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  static Future<int> addAlbum(Album album) async {
    final db = await _getDB();
    //if (_isExist(album) == false) {
    return await db.insert(
      "Album",
      album.toJson(),
    );
    // } else {
    //   return 0;
    // }
  }

  static Future<int> updateAlbum(Album album) async {
    final db = await _getDB();
    // if (_isExist(album) == false) {
    return await db.update(
      "Album",
      album.toJson(),
      where: 'albumId = ?',
      whereArgs: [album.albumId],
    );
    // } else {
    //   return 0;
    // }
  }

  static Future<int> deleteAlbum(Album album) async {
    final db = await _getDB();
    return await db.delete(
      "Album",
      where: 'albumId = ?',
      whereArgs: [album.albumId],
    );
  }

  static Future<List<Album>?> getAlbums() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("Album");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(maps.length, (index) => Album.fromJson(maps[index]));
  }

  static Future<int> addLabel(Label label) async {
    final db = await _getDB();
    //if (_isExist(label) == false) {
    return await db.insert(
      "Label",
      label.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    // } else {
    //   return 0;
    // }
  }

  static Future<int> updateLabel(Label label) async {
    final db = await _getDB();
    // if (_isExist(label) == false) {
    return await db.update(
      "Label",
      label.toJson(),
      where: 'labelId = ?',
      whereArgs: [label.labelId],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    // } else {
    //   return 0;
    // }
  }

  static Future<int> deleteLabel(Label label) async {
    final db = await _getDB();
    return await db.delete(
      "Label",
      where: 'labelId = ?',
      whereArgs: [label.labelId],
    );
  }

  static Future<List<Label>?> getLabels() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("Label");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(maps.length, (index) => Label.fromJson(maps[index]));
  }

  static Future<int> addArtist(Artist artist) async {
    final db = await _getDB();
    //if (_isExist(artist) == false) {
    return await db.insert(
      "Artist",
      artist.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    // } else {
    //   return 0;
    // }
  }

  static Future<int> updateArtist(Artist artist) async {
    final db = await _getDB();
    // if (_isExist(artist) == false) {
    return await db.update(
      "Artist",
      artist.toJson(),
      where: 'artistId = ?',
      whereArgs: [artist.artistId],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    // } else {
    //   return 0;
    // }
  }

  static Future<int> deleteArtist(Artist artist) async {
    final db = await _getDB();
    return await db.delete(
      "Artist",
      where: 'artistId = ?',
      whereArgs: [artist.artistId],
    );
  }

  static Future<List<Artist>?> getArtists() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("Artist");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(maps.length, (index) => Artist.fromJson(maps[index]));
  }

  static Future<int> addSong(Song song) async {
    final db = await _getDB();
    //if (_isExist(song) == false) {
    return await db.insert(
      "Song",
      song.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    // } else {
    //   return 0;
    // }
  }

  static Future<int> updateSong(Song song) async {
    final db = await _getDB();
    // if (_isExist(song) == false) {
    return await db.update(
      "Song",
      song.toJson(),
      where: 'songId = ?',
      whereArgs: [song.songId],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    // } else {
    //   return 0;
    // }
  }

  static Future<int> deleteSong(Song song) async {
    final db = await _getDB();
    return await db.delete(
      "Song",
      where: 'songId = ?',
      whereArgs: [song.songId],
    );
  }

  static Future<List<Song>?> getSongs() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("Song");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(maps.length, (index) => Song.fromJson(maps[index]));
  }
}
