import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';
import 'package:weightmanagementapp/widgets/weight_card.dart';

import 'my_page_notifier.dart';

class MyPage extends StatelessWidget {
  const MyPage._({Key key}) : super(key: key);

  static Widget wrapped() {
    return MultiProvider(
      providers: [
        StateNotifierProvider<MyPageNotifier, MyPageState>(
          create: (context) => MyPageNotifier(
            context: context,
          ),
        )
      ],
      child: const MyPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // context.watch で stateを定義しているクラスのメソッドを呼び出したりできる
    // context.select で stateを監視して変更があった際に画面を再描画(でもここで定義するとページ全部再描画してしまう)
    final notifier = context.watch<MyPageNotifier>();
    print('描画');
    return Scaffold(
      appBar: AppBar(
        title: Text('日々の体重を追加していくアプリ'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height - 200,
                child: Builder(
                  builder: (BuildContext context) {
                    final records = context.select((MyPageState state) => state.record);
                    return ListView.builder(
                      itemCount: records.length,
                      itemBuilder: (BuildContext context, int index) {
                        return WeightCard(records, index);
                      },
                    );
                  },
                ),
              ),
              Text('今日の体重を追加しよう'),
              SizedBox(height: 5,),
              IconButton(
                icon: Icon(
                  Icons.add_circle,
                  color: Colors.blue,
                ),
                onPressed: () {
                  notifier.popUpForm();
                },
              )
            ],
          ),
        ),
      )
    );
  }
}
