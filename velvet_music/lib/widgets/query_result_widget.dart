import 'package:flutter/material.dart';

class QueryResultWidget extends StatelessWidget {
  final String result;
  // final VoidCallback onTap;
  // final VoidCallback onLongPress;
  const QueryResultWidget({
    super.key,
    required this.result,
    // required this.onTap,
    // required this.onLongPress
  });

  @override
  Widget build(BuildContext context) {
    final splitInput = result.split('":"').toString();
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
    for (var i = 1; i < splitInput7.length - 1; i++) {
      if (i % 2 != 0) {
        columns.add(splitInput7.elementAt(i));
      } else {
        rows.add(splitInput7.elementAt(i));
      }
    }
    print(columns);
    print(rows);
    return InkWell(
      // onLongPress: onLongPress,
      // onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6),
        child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: SizedBox(
                height: 100,
                width: 1440,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 50,
                        width: 1440,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.all(2.0),
                          itemCount: columns.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 20,
                              width: 125,
                              child: SelectableText(
                                columns.elementAt(index).toString(),
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 50,
                        width: 1440,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.all(2.0),
                          itemCount: columns.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 20,
                              width: 125,
                              child: SelectableText(
                                rows.elementAt(index).toString(),
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )

            //Parse artistId into an artist name

            // const Padding(
            //   padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            //   child: Divider(
            //     thickness: 1,
            //   ),
            // ),
            // Text(album.,
            //     style: const TextStyle(
            //         fontSize: 16, fontWeight: FontWeight.w400))
            ),
      ),
    );
  }
}
