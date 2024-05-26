import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_electronic_record_card/data/secure_storage/secure_storage_helper.dart';
import 'package:mobile_electronic_record_card/service/locator/locator.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeModalWindow extends StatefulWidget {
  const QrCodeModalWindow({super.key});

  @override
  State<QrCodeModalWindow> createState() => _QrCodeModalWindowState();
}

class _QrCodeModalWindowState extends State<QrCodeModalWindow> {
  String? qrData;
  final secureLocator = getIt.get<SecureStorageHelper>();

  _QrCodeModalWindowState();

  @override
  void initState() {
    super.initState();
    Future.microtask(() async => await getToken());
  }

  Future<void> getToken() async {
    String? s = await secureLocator.readToken();
    setState(() {
      qrData = s;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            qrData != null
                ? QrImageView(
                    data: qrData!,
                    version: QrVersions.auto,
                    size: 320.0,
                    errorStateBuilder: (cxt, err) {
                      return const Center(
                        child: Text(
                          'Произошла ошибка генерации QR-кода',
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  )
                : const Text('Произошла ошибка генерации QR-кода'),
          ]),
        )
      ],
    );
  }
}
