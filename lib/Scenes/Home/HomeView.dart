import 'package:flutter/material.dart';
import 'package:ofm_demo/Scenes/Home/HomePresenter.dart';
import 'package:ofm_demo/Scenes/Showcase/ShowcasePresenter.dart';
import 'package:ofm_demo/Scenes/Showcase/ShowcaseView.dart';
import 'package:ofm_demo/Sources/Base/BaseScreen.dart';

class Homeview extends StatefulWidget {
  const Homeview({super.key});

  @override
  State<Homeview> createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {
  // MARK: Properties
  final HomePresenter presenter = HomePresenter();

  // MARK: View
  @override
  Widget build(BuildContext context) {
    final presenter = ShowcasePresenter('/showcase/mensTrousers');

    return BaseView(
      body: ShowcaseView(presenter: presenter),
      presenter: presenter,
    );
  }
}
