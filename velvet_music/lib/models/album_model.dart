class Album {
  final int albumId;
  final String albumName;
  final int? artistId;
  final String? releaseDate;
  final int? labelId;
  final int? classId;
  final int? artId;
  final int? trackListId;

  const Album({
    required this.albumId,
    required this.albumName,
    this.artistId,
    this.releaseDate,
    this.labelId,
    this.classId,
    this.artId,
    this.trackListId,
  });

  factory Album.fromJson(Map<String, dynamic> json) => Album(
        albumId: json['albumId'],
        albumName: json['albumName'],
        artistId: json['artistId'],
        releaseDate: json['releaseDate'],
        labelId: json['labelId'],
        classId: json['classId'],
        artId: json['artId'],
        trackListId: json['trackListId'],
      );

  Map<String, dynamic> toJson() => {
        'albumId': albumId,
        'albumName': albumName,
        'artistId': artistId,
        'releaseDate': releaseDate,
        'labelId': labelId,
        'classId': classId,
        'artId': artId,
        'trackListId': trackListId,
      };
}
