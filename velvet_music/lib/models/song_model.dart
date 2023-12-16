class Song {
  final int songId;
  final String songName;
  final int? artistId;
  final String? songLink;
  final int? artId;
  final int? trackListId;
  final int? albumId;

  const Song({
    required this.songId,
    required this.songName,
    this.artistId,
    this.songLink,
    this.artId,
    this.trackListId,
    this.albumId,
  });

  factory Song.fromJson(Map<String, dynamic> json) => Song(
        songId: json['songId'],
        songName: json['songName'],
        artistId: json['artistId'],
        songLink: json['songLink'],
        artId: json['artId'],
        trackListId: json['trackListId'],
        albumId: json['albumId'],
      );

  Map<String, dynamic> toJson() => {
        'songId': songId,
        'songName': songName,
        'artistId': artistId,
        'songLink': songLink,
        'artId': artId,
        'trackListId': trackListId,
        'albumId': albumId,
      };
}
