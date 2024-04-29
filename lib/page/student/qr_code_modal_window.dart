import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

//  TODO подвязать данные
class QrCodeModalWindow extends StatefulWidget {

  const QrCodeModalWindow({super.key});

  @override
  State<QrCodeModalWindow> createState() => _QrCodeModalWindowState();
}

class _QrCodeModalWindowState extends State<QrCodeModalWindow> {
  String qrData = "https://github.com/ChinmayMunje";

  _QrCodeModalWindowState();

  @override
  void initState() {
    super.initState();
    qrData = "https://github.com/ChinmayMunje";
  }

  @override
  Widget build(BuildContext context) {
    /*return Column(
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
                )
            ),

            const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('100')
                  ],
                )
            ),
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
                )
            ),
            const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('5.0')
                  ],
                )
            ),
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
                )
            ),
            const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Возможен')
                  ],
                )
            ),
            _width()
          ],
        ),
        _height(),
      ],
    );*/


    return Column(

      );
  }

  Widget _height() => const SizedBox(height: 26);
  Widget _width() => const SizedBox(width: 26);
}
