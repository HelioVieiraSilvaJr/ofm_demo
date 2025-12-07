import 'package:flutter/material.dart';
import 'package:ofm_demo/Scenes/Home/HomePresenter.dart';
import 'package:ofm_demo/Sorces/Base/BaseScreen.dart';

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
    return BaseView(
      body: Center(
        child: Text('Home View'),
      ),
      presenter: presenter,
    );
  }
}
