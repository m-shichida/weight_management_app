import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:weightmanagementapp/widgets/weight_register_pop_up.dart';

part 'my_page_notifier.freezed.dart';

@freezed
abstract class MyPageState with _$MyPageState {
  const factory MyPageState({
    @Default(0) int count,
    String weight,
    String comment,
    // Mapは連想配列 {'name': 'value', 'comment': 'value'}
    @Default([]) List<Map<String, String>> record,
  }) = _MyPageState;
}

class MyPageNotifier extends StateNotifier<MyPageState> with LocatorMixin {
  MyPageNotifier({
    @required this.context,
  }) : super(const MyPageState());

  final BuildContext context;

  @override
  // その画面から戻った時などに自動的に発動するメソッド
  // 別の画面に移動したあとで、状態が前のままになるのを防いだりする
  // 別の画面に移動するときになんらかの処理を走らせたいとき
  void dispose() {
    print('dispose');
    super.dispose();
  }

  // ページが表示されたときに自動的に走る処理を書くことができるメソッド
  @override
  void initState() {}

  // voidは返り値のないメソッド定義するときに使う
  // もし返り値があるのであれば
  // string pushButton() { ... と使う
  void pushButton() {
    print('notifier!');
    // 12行目の@Default(0) int countのcountを使用する
    state = state.copyWith(count: state.count + 1);
    print(state.count);
  }

  // ポップアップを表示する
  void popUpForm() {
    showDialog(
        context: context,
      builder: (context) {
        return WeightRegisterPopUp(_saveWeight, _saveComment, _register);
      },
    );
  }

  // privateメソッドは頭に_をつける
  void _saveWeight(String value) {
    state = state.copyWith(weight: value);
    print(state.weight);
  }

  void _saveComment(String value) {
    state = state.copyWith(comment: value);
    print(state.comment);
  }

  void _register() {
    final dateTime = DateTime.now();
    final day = '${dateTime.year}年${dateTime.month}月${dateTime.day}日';
    final formRecord = {
      'weight': state.weight,
      'comment': state.comment,
      'day': day,
    };

    print(formRecord);
    final newRecord = List<Map<String, String>>.from(state.record);
    newRecord.add(formRecord);
    state = state.copyWith(record: newRecord);
    print(state.record);
    // 一段階戻る
    Navigator.pop(context);
  }
}
