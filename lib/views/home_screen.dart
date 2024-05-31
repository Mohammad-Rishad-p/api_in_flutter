import 'package:api/services/remote_service.dart';
import 'package:flutter/material.dart';
import '../models/post.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Post>? posts;
  var isLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    posts = await RemoteService().getPosts();
    if (posts != null){
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('posts'), centerTitle: true,),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Visibility(
          visible: isLoaded,
          child: ListView.builder(
            itemCount: posts?.length,
            itemBuilder: (context, index) {
              return Container(
                child: Text('${posts![index].userId.toString()}  ${posts![index].body.toString()} ', style: TextStyle(fontSize: 24),),
              );
            }),
            replacement: const Center(child: CircularProgressIndicator(),),
        ),
      ),
    );
  }
}