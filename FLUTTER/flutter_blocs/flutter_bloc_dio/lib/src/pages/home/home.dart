import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_dio/src/routers/application.dart';

List posts = [
  {"author": "黄帝","imageUrl": "icons/file_pdf_preview.png", "id": 0,},
  {"author": "神农", "imageUrl": "icons/file_pdf_preview.png", "id": 1},
  {"author": "雷公", "imageUrl": "icons/file_pdf_preview.png", "id": 2},
  {"author": "歧伯", "imageUrl": "icons/file_pdf_preview.png", "id": 3},
  {"author": "扁鹊", "imageUrl": "icons/file_pdf_preview.png", "id": 4},
  {"author": "华佗", "imageUrl": "icons/file_pdf_preview.png", "id": 5},
  {"author": "张仲景", "imageUrl": "icons/file_pdf_preview.png", "id": 6},
  {"author": "孙思邈", "imageUrl": "icons/file_pdf_preview.png", "id": 7},
  {"author": "皇浦谧", "imageUrl": "icons/file_pdf_preview.png", "id": 8},
  {"author": "公孙和", "imageUrl": "icons/file_pdf_preview.png", "id": 9},
  {"author": "菜单一", "imageUrl": "icons/file_pdf_preview.png", "id": 10},
  {"author": "菜单四", "imageUrl": "icons/file_pdf_preview.png", "id": 11},
  {"author": "菜单五", "imageUrl": "icons/file_pdf_preview.png", "id": 12},
  {"author": "菜单六", "imageUrl": "icons/file_pdf_preview.png", "id": 13},
  {"author": "菜单七", "imageUrl": "icons/file_pdf_preview.png", "id": 14},
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("首页")),
      body: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (BuildContext context, int index) {
            var post = posts[index];
            return Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image(
                          width: double.infinity,
                          fit: BoxFit.cover,
                          image: AssetImage(post.imageUrl),
                        ),
                      )),
                ),
                Positioned(
                    left: 20,
                    top: 20,
                    child: Text(
                      post.title,
                      style: const TextStyle(
                          fontSize: 30, color: Color(0xffffffff)),
                    )),
                Positioned(
                  left: 20,
                  top: 60,
                  child: Text(post.author,
                      style: const TextStyle(
                          fontSize: 20, color: Color(0xffffffff))),
                ),

                //增加一个占满父组件的组件，然后增加一个Material， 然后增加一个有点击事件的InkWell
                Positioned.fill(
                    child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      //发起路由跳转，跳转到新的页面
                      Application.router.navigateTo(context, "/detail?id=123",
                          transition: TransitionType.inFromRight);

                      print("点击了路由跳转按钮");
                    },
                    splashColor: Colors.white.withOpacity(0.3),
                    highlightColor: Colors.white.withOpacity(0.1),
                  ),
                ))
              ],
            );
          }),
    );
  }
}
