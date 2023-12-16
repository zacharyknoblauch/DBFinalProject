// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../models/label_model.dart';
import '../services/database_helper.dart';

class LabelScreen extends StatelessWidget {
  final Label? label;
  const LabelScreen({super.key, this.label});

  @override
  Widget build(BuildContext context) {
    final labelIdController = TextEditingController();
    final labelNameController = TextEditingController();
    final artistIdController = TextEditingController();

    if (label != null) {
      labelNameController.text = label!.labelName;
      labelIdController.text = label!.labelId.toString();
      artistIdController.text = label!.artistId.toString();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(label == null ? 'Add a label' : 'Edit label'),
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
                      controller: labelNameController,
                      maxLines: 1,
                      decoration: const InputDecoration(
                          labelText: 'Label name',
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
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SizedBox(
                      height: 55.0,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          onPressed: () async {
                            final labelId = int.parse(labelIdController.text);
                            final labelName = labelNameController.value.text;
                            final artistId = int.parse(artistIdController.text);

                            if (labelName.isEmpty) {
                              return;
                            }

                            final Label model = Label(
                              labelName: labelName,
                              artistId: artistId,
                              labelId: labelId,
                            );
                            if (label == null) {
                              await DatabaseHelper.addLabel(model);
                            } else {
                              await DatabaseHelper.updateLabel(model);
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
                            label == null ? 'Save' : 'Edit',
                            style: const TextStyle(fontSize: 20),
                          )),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text("WARNING: Do not save without entering an label name AND an label id",),
                  ),
                ]),
          )
        ]));
  }
}
