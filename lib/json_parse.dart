import 'package:billionaire_list_app_backslash/json_data.dart';
import 'package:billionaire_list_app_backslash/services.dart';
import 'package:flutter/material.dart';

class JsonParseData extends StatefulWidget {
  const JsonParseData({super.key});

  @override
  State<JsonParseData> createState() => _JsonParseDataState();
}

class _JsonParseDataState extends State<JsonParseData> {
  // List of billionaires
  List<Billionaire>? _finalList; // Nullable to handle loading state
  bool _loading = true;

  @override
  void initState() {
    super.initState();

    // Fetch data when app starts
    Services.getBillionaire().then((finalList) {
      setState(() {
        _finalList = finalList;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 45, 26, 88),
        elevation: 0,
        centerTitle: true,
        title: Text(
          _loading ? "Loading..." : "Billionaire List",
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white70,
          ),
        ),
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(), // Show a loader while loading
            )
          : Container(
              color: Colors.grey[200],
              child: ListView.builder(
                itemCount: _finalList?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  final parser = _finalList![index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        parser.personName[0],
                      ),
                    ),
                    title: Text(parser.personName),
                    subtitle: Text(parser.source),
                    trailing: Text("Rank #${parser.rank}"),
                  );
                },
              ),
            ),
    );
  }
}
