import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{
  @override
  Widget build(BuildContext context) {
    bool _pinned = true;
    bool _snap = false;
    bool _floating = false;
    Color color = Theme.of(context).primaryColor;
    File _image;
    final picker = ImagePicker();
    Future getImage() async {
      showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text("タイトル"),
            content: Text("メッセージ"),
            actions: <Widget>[
              CupertinoDialogAction(
                  child: Text("カメラを起動する"),
                  isDestructiveAction: true,
                  onPressed: () async {
                    final pickedFile = await picker.getImage(source: ImageSource.camera);
                    setState(() {
                      if (pickedFile != null) {
                        _image = File(pickedFile.path);
                      }
                    });
                  }
              ),
              CupertinoDialogAction(
                  child: Text("ライブラリから選ぶ"),
                  onPressed: () async {
                    final pickedFile = await picker.getImage(source: ImageSource.gallery);
                    setState(() {
                      if (pickedFile != null) {
                        _image = File(pickedFile.path);
                      }
                    });
                  }
              ),
            ],
          );
        },
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: _pinned,
            snap: _snap,
            floating: _floating,
            expandedHeight: 160.0,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('SliverAppBar'),
              background: FlutterLogo(),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
              child: Center(
                child: Text('Scroll to see the SliverAppBar in effect.'),
              ),
            ),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 150.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 0.7,
            ),
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Container(
                    alignment: Alignment.center,
                    color: Colors.teal[100 * (index % 9)],
                    child: _buildButtonColumn(color, Icons.call, 'CALL')
                );
              },
              childCount: 20,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8),
          child:
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.thumb_up),
            ),

          // child: Text(
          //   label,
          //   style: TextStyle(
          //     fontSize: 12,
          //     fontWeight: FontWeight.w400,
          //     color: color,
          //   ),
          // ),
        ),
      ],
    );
  }

}

// 詳細ページ
class DetailPage extends StatelessWidget {
  final ItemModel item;
  DetailPage({this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: 'title' + item.id,
          child: Material(
            color: Colors.transparent,
            child: Text(
              item.title,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        backgroundColor: item.backgroundColor,
      ),
      body: Stack(
        children: <Widget>[
          Hero(
            tag: 'background' + item.id,
            child: Container(
              color: item.backgroundColor,
            ),
          ),
          Center(
            child: Column(
              children: <Widget>[
                Hero(
                  tag: 'image' + item.id,
                  child: Image.network(item.imagePath,fit: BoxFit.fitWidth,height: 300,),
                ),
                Hero(
                  tag: 'subtitle' + item.id,
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      item.subtitle,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// リストに表示するデータ
final list = [
  ItemModel(
    id: '1',
    title: 'タイトル1',
    subtitle: 'サブタイトル1',
    imagePath: 'https://cdn.pixabay.com/photo/2017/05/16/21/24/gorilla-2318998_1280.jpg',
    backgroundColor: Colors.amber,
  ),
  ItemModel(
    id: '2',
    title: 'タイトル2',
    subtitle: 'サブタイトル2',
    imagePath: 'https://cdn.pixabay.com/photo/2014/04/13/20/49/cat-323262_1280.jpg',
    backgroundColor: Colors.cyan,
  ),
  ItemModel(
    id: '3',
    title: 'タイトル3',
    subtitle: 'サブタイトル3',
    imagePath: 'https://cdn.pixabay.com/photo/2015/03/26/09/54/pug-690566_1280.jpg',
    backgroundColor: Colors.redAccent,
  ),
];

// リストに表示するデータモデル
class ItemModel {
  String id;
  String title;
  String subtitle;
  String imagePath;
  Color backgroundColor;

  ItemModel({
    this.id,
    this.title,
    this.subtitle,
    this.imagePath,
    this.backgroundColor,
  });
}