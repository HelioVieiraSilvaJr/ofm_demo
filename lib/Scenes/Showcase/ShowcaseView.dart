import 'package:flutter/material.dart';
import 'package:ofm_demo/Scenes/Showcase/ShowcasePresenter.dart';
import 'package:ofm_demo/Sorces/Base/BaseScreen.dart';

class Showcaseview extends StatefulWidget {
  const Showcaseview({super.key});

  @override
  State<Showcaseview> createState() => _ShowcaseviewState();
}

class _ShowcaseviewState extends State<Showcaseview> {
  final ShowcasePresenter presenter = ShowcasePresenter();

  @override
  Widget build(BuildContext context) {
    return BaseView(body: Container(), presenter: presenter);
  }
}
