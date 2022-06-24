import 'package:flutter/material.dart';

class ApiDetails extends StatelessWidget{
  final String responseCode;

  const ApiDetails({Key? key, required this.responseCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Column(
        children: [
          ListTile(
            title: Text('Response Code = $responseCode'),
            leading: const Icon(Icons.insert_comment_outlined),
          )
        ],
      ),
    );
  }

}

