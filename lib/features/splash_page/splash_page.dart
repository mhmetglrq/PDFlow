import 'package:flutter/material.dart';
import 'package:flutter_img_to_pdf/common/widgets/custom_button.dart';
import 'package:flutter_img_to_pdf/features/home_page/home_page.dart';
import 'package:video_player/video_player.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = '/select-splash-page';

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/landing_new.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    play();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void play() {
    _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: VideoPlayer(_controller),
          ),
          CustomButton(
            text: 'Başlayalım!',
            onPressed: () => Navigator.pushNamed(context, HomePage.routeName),
          ),
        ],
      ),
    );
  }
}
