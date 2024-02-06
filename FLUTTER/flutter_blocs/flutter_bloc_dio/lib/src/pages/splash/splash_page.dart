import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc_dio/src/components/imageLoad/image_utils.dart';
import 'package:flutter_bloc_dio/src/components/imageLoad/load_image.dart';
import 'package:flutter_bloc_dio/src/components/sizedBox/fractionally_aligned_sized_box.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  int _status = 0;
  final List<String> _guideList = ['app_start_1', 'app_start_2', 'app_start_3'];
  StreamSubscription<dynamic>? _subscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      void precacheImages(String image) {
        precacheImage(
            ImageUtils.getAssetImage(image, format: ImageFormat.webp), context);
      }

      _guideList.forEach(precacheImages);

      _initSplash();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _initGuide() {
    setState(() {
      _status = 1;
    });
  }

  void _initSplash() {
    _initGuide();
  }

  void _goLogin() {
    //
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: _status == 0
            ? const FractionallyAlignedSizedBox(
                heightFactor: 0.3,
                widthFactor: 0.33,
                leftFactor: 0.33,
                bottomFactor: 0,
                child: LoadAssetImage('logo'))
            : Swiper(
                key: const Key('swiper'),
                itemCount: _guideList.length,
                loop: false,
                itemBuilder: (_, index) {
                  return LoadAssetImage(
                    _guideList[index],
                    key: Key(_guideList[index]),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    format: ImageFormat.webp,
                  );
                },
                onTap: (index) {
                  if (index == _guideList.length - 1) {
                    _goLogin();
                  }
                },
              ));
  }
}
