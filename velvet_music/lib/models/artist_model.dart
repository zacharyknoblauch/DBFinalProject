class Artist {
  final int artistId;
  final String artistName;
  final int? labelId;

  const Artist({
    required this.artistId,
    required this.artistName,
    this.labelId,
  });

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
        artistId: json['artistId'],
        artistName: json['artistName'],
        labelId: json['labelId'],
      );

  Map<String, dynamic> toJson() => {
        'artistId': artistId,
        'artistName': artistName,
        'labelId': labelId,
      };
}
