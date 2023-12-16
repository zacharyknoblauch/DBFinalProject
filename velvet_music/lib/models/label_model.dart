class Label {
  final int labelId;
  final String labelName;
  final int? artistId;

  const Label({
    required this.labelId,
    required this.labelName,
    this.artistId,
  });

  factory Label.fromJson(Map<String, dynamic> json) => Label(
        labelId: json['labelId'],
        labelName: json['labelName'],
        artistId: json['artistId'],
      );

  Map<String, dynamic> toJson() => {
        'labelId': labelId,
        'labelName': labelName,
        'artistId': artistId,
      };
}
