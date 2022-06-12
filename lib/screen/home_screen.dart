import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_number_generator/comonent/numer_row.dart';
import 'package:random_number_generator/constant/color.dart';
import 'package:random_number_generator/screen/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int maxNumber = 1000;

  List<int> randomNumbers = [];

  // 첫 로딩시 랜덤수를 넣어주기 위한 추가코드
  @override
  void initState() {
    super.initState();
    makeRandomNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          // EdgeInsets.only 는 named parameter 로 값을 줄 수 있다.
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(
                onPressed: onSettingPop,
              ),
              // 나머지 부분을 다 차지하게 하기위해 Expanded 사용
              _Body(randomNumbers: randomNumbers),
              // Container vs SizedBox
              // SizedBox 는 컨테이너보다는 간단한 기능을 제공해준다.
              // 하지만 Container 를 사용하면 의미가 광범위해서 직관적으로 파악하기 힘들다.
              // 그렇기 때문에 목적에 맞게끔 적절한 위젯을 사용해주자
              _Footer(onPressed: makeRandomNumber,),
            ],
          ),
        ),
      ),
    );
  }

  void onSettingPop() async {
    // push() -> list 의 add 와 비슷함
    // [HomeScreen(), SettingsScreen()]
    // Router Stack
    // 페이지 이동해주는 위젯 Navigator
    // 파라미터를 받을때는 async, await 으로 받아준다. 그리고 결과값 타입을 제네릭으로 정해줄 수 있다.
    final result = await Navigator.of(context).push<int>(
        MaterialPageRoute(builder: (BuildContext context){
          return SettingScreen(
            maxNumber: maxNumber,
          );
        })
    );
    if(result != null) {
      setState(() {
        maxNumber = result;
      });
    }
  }

  void makeRandomNumber() {
    final rand = Random();

    final Set<int> newNumbers = {};

    while(newNumbers.length != 3) {
      newNumbers.add(rand.nextInt(maxNumber));
    }

    setState( () {
      randomNumbers = newNumbers.toList();
    });
  }

  // 1.ExtractMethod 를 활용한 코드
  Row numberToImage(int number) {
    return Row(
      children: number
          .toString()
          .split('')
          .map(
            (e) => Image.asset(
              'asset/img/$e.png',
              height: 70.0,
              width: 50.0,
            ),
          )
          .toList(),
    );
  }
}

class _Footer extends StatelessWidget {

  final VoidCallback onPressed;

  const _Footer({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            // primary : 주 색상
            primary: RED_COLOR
        ),
        child: const Text('생성하기!'),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
    required this.randomNumbers,
  }) : super(key: key);

  final List<int> randomNumbers;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
      randomNumbers.asMap() // asMap 을 사용하는 순간 key 값을 사용할 수 있다.
      .entries // key, value 값으로 바꾸어 준다.
          .map(
              (e) => Padding(
            padding: EdgeInsets.only(bottom: e.key == [123, 456, 789].length - 1 ? 0 : 16.0), // 동적으로 적용해주기 위한 코드 추가
            child: NumberRow(number: e.value),
          ))
          .toList(),
      // children: [
      //   numberToImage(123),
      //   numberToImage(456),
      //   numberToImage(789),
      // ],
    ));
  }
}

class _Header extends StatelessWidget {

  final VoidCallback onPressed;

  const _Header({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          '랜덤숫자 생성기',
          style: TextStyle(
            // 앱을 사용하는 색상들을 한 파일에 모아둔다.
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Icons.settings,
            color: RED_COLOR,
          ),
        ),
      ],
    );
  }
}
