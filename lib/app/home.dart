import 'package:flutter/material.dart';
import 'package:noteapp/components/cardnotes.dart';
import 'package:noteapp/components/crud.dart';
import 'package:noteapp/constant/linkapi.dart';
import 'package:noteapp/main.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Crud crud = Crud();

  getNotes() async {
    var response = await crud.postRequest(linkViewNotes, {
      "id": sharedPref.getString("id"),
    });
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            onPressed: () {
              sharedPref.clear();
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil("login", (ruote) => false);
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil("addnotes", (route) => false);
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            FutureBuilder(
              future: getNotes(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data['status'] == 'fail')
                    return Center(
                      child: Text(
                        "There are no comments",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  return ListView.builder(
                    itemCount: snapshot.data['data'].length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, i) {
                      return CardNotes(
                        ontap: () {},
                        title: "${snapshot.data['data'][i]['notes_title']}",
                        content: "${snapshot.data['data'][i]['notes_content']}",
                      );
                    },
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }
}
