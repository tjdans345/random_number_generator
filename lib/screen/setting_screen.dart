import 'package:flutter/material.dart';
import 'package:random_number_generator/comonent/numer_row.dart';
import 'package:random_number_generator/constant/color.dart';

class SettingScreen extends StatefulWidget {
  final int maxNumber;

  const SettingScreen({required this.maxNumber, Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  double maxNumber = 1000;
  double originalNumber = 1000;

  // SettingScreen 이 생성될 때 initState 가 불린다.
  // State 가 생성될 때 가장 먼저 실행이 된다.
  @override
  void initState() {
    super.initState();
    maxNumber = widget.maxNumber.toDouble();
    originalNumber = maxNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Body(maxNumber: maxNumber),
              _Fotter(
                maxNumber: maxNumber,
                onSliderChanged: onSliderChanged,
                onButtonPressed: onButtonPressed,
                onButtonCancel: onButtonCancel,)
              
            ],
          ),
        ),
      ),
    );
  }

  void onButtonPressed() {
      // 이전 페이지로 돌아가면서 파라미터로 데이터 넘겨주기
      // pop() 에 파라미터로 넘겨주면 전 페이지에서 현재 페이지의 데이터를 사용가능하다.
      Navigator.of(context).pop(maxNumber.toInt());
  }
  void onButtonCancel() {
    // 이전 페이지로 돌아가면서 파라미터로 데이터 넘겨주기
    // pop() 에 파라미터로 넘겨주면 전 페이지에서 현재 페이지의 데이터를 사용가능하다.
    Navigator.of(context).pop(originalNumber.toInt());
  }


  void onSliderChanged(double val) {
    setState((){
      maxNumber = val;
    });
  }
}



class _Body extends StatelessWidget {
  final double maxNumber;
  const _Body({required this.maxNumber, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:  NumberRow(number: maxNumber.toInt(),),
    );
  }
}

class _Fotter extends StatelessWidget {
  final double maxNumber;
  final ValueChanged<double>? onSliderChanged;
  final VoidCallback onButtonPressed;
  final VoidCallback onButtonCancel;



  const _Fotter({
    Key? key,
    required this.maxNumber,
    required this.onSliderChanged,
    required this.onButtonPressed,
    required this.onButtonCancel
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Slider(
            value: maxNumber,
            min: 1000,
            max: 100000,
            onChanged: onSliderChanged
        ),
        ElevatedButton(
            onPressed: onButtonCancel,
            style: ElevatedButton.styleFrom(
                primary: Colors.amber
            ),
            child: const Text(
              '돌아가기 !!!',
              style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold
              ),
            )
        ),
        ElevatedButton(
            onPressed: onButtonPressed,
            style: ElevatedButton.styleFrom(
                primary: RED_COLOR
            ),
            child: const Text(
              '저장 !!!',
              style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold
            ),
            )
        ),

      ],
    );
  }
}

