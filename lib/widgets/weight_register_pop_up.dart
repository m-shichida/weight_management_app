import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeightRegisterPopUp extends StatelessWidget {
  const WeightRegisterPopUp(this.saveWeight, this.saveComment, this.registerOnTap);

  final saveWeight;
  final saveComment;
  final registerOnTap;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('今日の体重を入力してみよう'),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 24,
      ),
      children: <Widget>[
        Row(
          children: [
            Container(
              width: 200,
              padding: EdgeInsets.only(left: 4),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '嘘つくなよ',
                    labelText: '今日の体重'),
                onChanged: (value) {
                  saveWeight(value);
                },
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text('Kg'),
          ],
        ),
        SizedBox(height: 10),
        TextFormField(
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: '懺悔の一言'
          ),
          onChanged: (value) {
            saveComment(value);
          },
        ),
        SizedBox(height: 10),
        InkWell(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.blue,
              border: Border.all(color: Colors.blueAccent),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '登録',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
          onTap: () {
            registerOnTap();
          },
        )
      ],
    );
  }
}
