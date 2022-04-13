import 'package:flutter/material.dart';
import 'package:flutter_sqlite/sqldb.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final SqlDb _sqldb = SqlDb();

  readData() async {
    var response = await _sqldb.readData('SELECT * FROM notes');
    print('read data ${response}');
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('add_note');
        },
        child: const Icon(Icons.add),
      ),
      body: ListView(
        children: [
          MaterialButton(
            onPressed: () async {
              await SqlDb.deleteDb();
            },
            child: Text('delete Database'),
          ),
          FutureBuilder(
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          title: Text(snapshot.data![index]['notes']),
                          subtitle: Text(snapshot.data![index]['title']),
                          style: ListTileStyle.list,
                          trailing: GestureDetector(
                            onTap: () async {
                              await _sqldb.deleteData(
                                  'DELETE FROM notes WHERE id = ${snapshot.data![index]['id']}');
                              setState(() {
                                readData();
                              });
                            },
                            child: const Icon(Icons.delete_rounded,
                                color: Colors.red),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
              future: readData()),
        ],
      ),
    );
  }
}
