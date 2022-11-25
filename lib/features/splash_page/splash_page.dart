import 'package:flutter/material.dart';
import 'package:flutter_img_to_pdf/common/utils/colors.dart';
import 'package:flutter_img_to_pdf/common/utils/icons.dart';
import 'package:flutter_img_to_pdf/common/utils/utils.dart';
import 'package:flutter_img_to_pdf/common/widgets/custom_button.dart';
import 'package:video_player/video_player.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = '/select-splash-page';

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late VideoPlayerController _controller;
  late VideoPlayerController _doneController;
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
          const Spacer(
            flex: 20,
          ),
          Expanded(
            flex: 50,
            child: Container(
              alignment: Alignment.center,
              child: VideoPlayer(_controller),
            ),
          ),
          const Spacer(
            flex: 10,
          ),
          Expanded(
            flex: 10,
            child: Center(
              child: CustomButton(
                  // onTap: () => Navigator.pushNamed(context, HomePage.routeName),
                  onTap: () => showDoneDialog(context: context),
                  backgroundColor: homeBackgroundColor,
                  iconColor: homeIconColor,
                  title: 'Başlayalım!',
                  icon: homeIcon),
            ),
          ),
          const Spacer(
            flex: 5,
          ),
        ],
      ),
    );
  }
}
