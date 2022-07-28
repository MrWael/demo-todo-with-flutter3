import 'dart:math';
import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:demotodoflutter_sdk3/data/model/addData_model.dart';
import 'package:demotodoflutter_sdk3/data/model/user_model.dart';
import 'package:demotodoflutter_sdk3/data/services/api_service.dart';
import 'package:demotodoflutter_sdk3/widget/makeText.dart';
import 'package:demotodoflutter_sdk3/widget/textFormField_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:demotodoflutter_sdk3/res/routes.gr.dart' as route;

class ShowDetailPage extends StatefulWidget {
  final AddData addData;
  final User user;
  ShowDetailPage({required this.addData, required this.user});

  @override
  _ShowDetailPageState createState() => _ShowDetailPageState();
}

class _ShowDetailPageState extends State<ShowDetailPage> {
  late TextEditingController _edittitle;
  late TextEditingController _editdescription;

  List<AddData> gettingData = [];
  bool loading = true;
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    _getDataInsert();
    isEdit = widget.addData != null;

    _edittitle =
        TextEditingController(text: isEdit ? widget.addData.title : '');
    _editdescription =
        TextEditingController(text: isEdit ? widget.addData.description : '');
  }

  Future _getDataInsert() async {
    gettingData = await ApiService.instance.insertData();
    loading = false;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final router = AutoRouter.of(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.black,
          ),
          onPressed: () {
            router.pop(context);
          },
        ),
        title: makeText(
          widget.user.name,
          color: Colors.black,
        ),
      ),
      body: loading == null
          ? Spacer()
          : Stack(
              children: [
                Container(
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectableText(
                        widget.addData.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:
                              Theme.of(context).textTheme.headline6!.fontSize,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SelectableText(
                        widget.addData.description,
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // makeText(
                      //     DateFormat.yMMMEd().format(
                      //       DateTime.parse(widget.addData.date),
                      //     ),
                      //     color: Colors.grey),
                    ],
                  ),
                ),
                Positioned(
                  right: 4,
                  bottom: 10,
                  child: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () async {
                      try {
                        await ApiService.instance
                            .deleteData(documentId: widget.addData.id);
                        _getDataInsert();

                        router.pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Delete Successfully'),
                          ),
                        );
                      } on AppwriteException catch (e) {
                        print(e);
                      }
                    },
                  ),
                ),
                Positioned(
                  right: 4,
                  bottom: 70,
                  child: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.indigo,
                      ),
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return SimpleDialog(
                                contentPadding: EdgeInsets.all(10),
                                children: [
                                  textFormField(
                                    hintText: "title",
                                    controller: _edittitle,
                                    textColor: Colors.black,
                                  ),
                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),
                                  textFormField(
                                    hintText: "description",
                                    controller: _editdescription,
                                    textColor: Colors.black,
                                  ),
                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          minimumSize: size / 9,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          primary: Colors.red,
                                          textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          )),
                                      onPressed: () async {
                                        final checkData = AddData(
                                          title: _edittitle.text,
                                          description: _editdescription.text,
                                          id: widget.addData.id,
                                          date: DateTime.now()
                                              .add(
                                                Duration(
                                                  days: Random().nextInt(5),
                                                ),
                                              )
                                              .toString(),
                                        );
                                        try {
                                          var added = await ApiService.instance
                                              .editData(
                                            addData: checkData,
                                            documentId: widget.addData.id,
                                            write: ['user:${widget.user.id}'],
                                            read: ['user:${widget.user.id}'],
                                          );
                                          print(added);
                                          _getDataInsert().then((value) {
                                            _editdescription.clear();
                                            _edittitle.clear();
                                          });
                                          router.push(route.HomeRoute(
                                              user: widget.user));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content:
                                                  Text('Edit Successfully'),
                                            ),
                                          );
                                        } on AppwriteException catch (e) {
                                          print(e.message);
                                        }
                                      },
                                      child: Text('Update')),
                                ],
                              );
                            });
                      }),
                ),
              ],
            ),
    ));
  }
}
