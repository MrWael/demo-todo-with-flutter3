import 'dart:math';
import 'dart:typed_data';
import 'package:appwrite/appwrite.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:demotodoflutter_sdk3/data/model/addData_model.dart';
import 'package:demotodoflutter_sdk3/data/model/user_model.dart';
import 'package:demotodoflutter_sdk3/data/services/api_service.dart';
import 'package:demotodoflutter_sdk3/widget/makeText.dart';
import 'package:demotodoflutter_sdk3/widget/textFormField_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:demotodoflutter_sdk3/res/routes.gr.dart' as route;

class HomePage extends StatefulWidget {
  User user;
  HomePage({Key? key, required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _title;
  late TextEditingController _description;

  List<AddData> gettingData = <AddData>[];

  void _getDataInsert() async {
    gettingData = await ApiService.instance.insertData();
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getDataInsert();
    _title = TextEditingController();
    _description = TextEditingController();
    _getUser();
  }

  _getUser() async {
    try {
      widget.user = await ApiService.instance.getUser();
      setState(() {});
    } on AppwriteException catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final router = AutoRouter.of(context);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigo,
          onPressed: () {
            _bottomSheet(size, context);
          },
          child: Icon(Icons.add),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.all(0),
            children: [
              if (widget.user != null) ...[
                Stack(
                  children: [
                    UserAccountsDrawerHeader(
                      accountName: Text(widget.user.name),
                      accountEmail: Text(widget.user.email),
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade500,
                      ),
                      currentAccountPicture: widget.user.prefs['data']
                                  ['photo'] !=
                              null
                          ? FutureBuilder(
                              future: ApiService.instance.getProfile(
                                widget.user.prefs['data']['photo'],
                              ),
                              builder: (_, AsyncSnapshot<Uint8List> snapshot) {
                                return CircleAvatar(
                                  backgroundImage: snapshot.data != null
                                      ? Image.memory(
                                          snapshot.data!,
                                        ).image
                                      : const NetworkImage(
                                          "https://images.unsplash.com/photo-1622902321346-a647b68e95f4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=386&q=80",
                                        ),
                                );
                              },
                            )
                          : const CircleAvatar(
                              backgroundImage: NetworkImage(
                                "https://images.unsplash.com/photo-1622902321346-a647b68e95f4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=386&q=80",
                              ),
                            ),
                    ),
                    Positioned(
                        left: size.width * 0.2,
                        top: size.height * 0.05,
                        child: IconButton(
                          tooltip: "Change Image",
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 20,
                          ),
                          onPressed: _upload,
                        )),
                  ],
                ),
              ],
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () async {
                  try {
                    await ApiService.instance.logout();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Logout'),
                    ));

                    router.replaceAll([const route.LoginRoute()]);
                  } on AppwriteException catch (e) {
                    print(e.message);
                  }
                },
              ),
            ],
          ),
        ),
        appBar: appbar(),
        body: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          physics: BouncingScrollPhysics(),
          itemCount: gettingData.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () async {
                await router.push(route.ShowDetailRoute(
                    addData: gettingData[index], user: widget.user));
                _getDataInsert();
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 8,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: size.width * 0.03,
                    top: size.height * 0.02,
                    right: size.width * 0.01,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      makeText(
                        gettingData[index].title,
                        fontWeight: FontWeight.bold,
                      ),
                      makeText(gettingData[index].description,
                          color: Colors.grey),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }

  PreferredSize appbar() {
    return PreferredSize(
        preferredSize: Size.fromHeight(100.0), // here the desired height
        child: AppBar(
            centerTitle: true,
            title: Text("demotodoflutter_sdk3"),
            backgroundColor: Colors.indigo.shade500));
  }

  void _bottomSheet(size, BuildContext context) {
    final router = AutoRouter.of(context);
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.02,
              vertical: size.height * 0.03,
            ),
            child: Container(
              height: size.height * 0.32,
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Center(
                    child: makeText(
                      "Add Data",
                      fontWeight: FontWeight.bold,
                      size: 19,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  textFormField(
                    hintText: 'title',
                    controller: _title,
                    textColor: Colors.black,
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  textFormField(
                    hintText: 'description',
                    controller: _description,
                    textColor: Colors.black,
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(size.width * 0.4, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          primary: Colors.red,
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                      onPressed: () async {
                        final checkData = AddData(
                          title: _title.text,
                          description: _description.text,
                          id: ID.unique(),
                          date: DateTime.now()
                              .add(
                                Duration(
                                  days: Random().nextInt(5),
                                ),
                              )
                              .toString(),
                        );
                        _title.clear();
                        _description.clear();
                        try {
                          var added = await ApiService.instance
                              .getAddData(addData: checkData, permissions: [
                            Permission.read(Role.user(widget.user.id)),
                            Permission.write(Role.user(widget.user.id))
                          ]);
                          print(added);
                          _getDataInsert();
                          router.pop();
                        } on AppwriteException catch (e) {
                          print(e.message);
                        }
                      },
                      child: Text('Add')),
                ],
              ),
            ),
          );
        });
  }

  _upload() async {
    FilePickerResult? image;
    var prevImageId = widget.user.prefs['data']['photo'];
    image = await FilePicker.platform.pickFiles(type: FileType.image);

// upload new profile picture, then delete an existing picture if any.
    if (image != null) {
      try {
        final res = await ApiService.instance.uploadPicture(
          image,
          [
            Permission.read(Role.user(widget.user.id)),
            Permission.write(Role.user(widget.user.id))
          ],
        );
        final id = res['\$id'];
        if (id != null) {
          await ApiService.instance.updatePrefs(
            {'photo': id},
          ).then((value) async => {
                if (prevImageId != null)
                  {
                    await ApiService.instance.deleteProfilePicture(
                      prevImageId,
                      ['user:${widget.user.id}'],
                    )
                  }
              });
          _getUser();
        } else {
          print('something null');
        }
      } on AppwriteException catch (e) {
        print(e.message);
      }
    }
  }
}
