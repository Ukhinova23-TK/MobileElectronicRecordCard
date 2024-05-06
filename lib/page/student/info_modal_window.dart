import 'package:flutter/material.dart';

//  TODO подвязать данные
class InfoModalWindow extends StatefulWidget {
  const InfoModalWindow({super.key});

  @override
  State<InfoModalWindow> createState() => _InfoModalWindowState();
}

class _InfoModalWindowState extends State<InfoModalWindow> {
  _InfoModalWindowState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _height(),
        Row(
          children: [
            _width(),
            const Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Процент пятерок, %'),
                  ],
                )),
            const Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text('100')],
            )),
            _width()
          ],
        ),
        Row(
          children: [
            _width(),
            const Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Средний балл'),
                  ],
                )),
            const Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text('5.0')],
            )),
            _width()
          ],
        ),
        Row(
          children: [
            _width(),
            const Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Красный диплом'),
                  ],
                )),
            const Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text('Возможен')],
            )),
            _width()
          ],
        ),
        _height(),
      ],
    );
  }

  Widget _height() => const SizedBox(height: 26);
  Widget _width() => const SizedBox(width: 26);
}
