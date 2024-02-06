import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
   // 定义接收路由参数
    const DetailPage({
    Key? key, 
    this.id}
    ) : super(key: key);

  final String? id;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
    var myField = TextEditingController();

  @override
  void initState() {
    super.initState();
  // widget接收路由参数
     myField.text = widget.id!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          }, 
          icon:const Icon(Icons.backpack_rounded)
        ),
        title:const Text("详情"),
      ),
      body: Text(myField.text)
    );
  }
}

