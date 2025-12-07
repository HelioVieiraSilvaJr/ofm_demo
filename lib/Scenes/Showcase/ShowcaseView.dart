import 'package:flutter/material.dart';
import 'package:ofm_demo/Commons/Enums/SectionType.dart';
import 'package:ofm_demo/Scenes/Showcase/ShowcasePresenter.dart';
import 'package:ofm_demo/Scenes/Showcase/Widgets/ShowcaseBubbleWidget.dart';
import 'package:ofm_demo/Scenes/Showcase/Widgets/ShowcaseCategoriesWidget.dart';
import 'package:ofm_demo/Scenes/Showcase/Widgets/ShowcaseContentMarkdown.dart';
import 'package:ofm_demo/Scenes/Showcase/Widgets/ShowcaseDoubleWideImages.dart';
import 'package:ofm_demo/Scenes/Showcase/Widgets/ShowcasePageBigImageWidget.dart';
import 'package:ofm_demo/Scenes/Showcase/Widgets/ShowcaseWideImage.dart';
import 'package:ofm_demo/Sources/Base/BaseScreen.dart';
import 'package:rx_notifier/rx_notifier.dart';

class ShowcaseView extends StatefulWidget {
  final ShowcasePresenter presenter;

  const ShowcaseView({super.key, required this.presenter});

  @override
  State<ShowcaseView> createState() => _ShowcaseViewState();
}

class _ShowcaseViewState extends State<ShowcaseView> {
  late final presenter = widget.presenter;

  @override
  void initState() {
    super.initState();
    presenter.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        appBar: widget.presenter.appBar,
        body: RxBuilder(builder: (context) {
          return SingleChildScrollView(
            child: Column(
                children: presenter.sections.value.map((section) {
              switch (section.type) {
                case SectionType.bigImage:
                  return ShowcasePageBigImageWidget(
                      section: section, onTap: presenter.onItemClicked);
                case SectionType.doubleWideImages:
                  return ShowcaseDoubleWideImages(
                      section: section, onTap: presenter.onItemClicked);
                case SectionType.wideImage:
                  return ShowcaseWideImage(
                      section: section, onTap: presenter.onItemClicked);
                case SectionType.categories:
                  return ShowcaseCategoriesWidget(
                      section: section, onTap: presenter.onItemClicked);
                case SectionType.bubbles:
                  return ShowcaseBubbleWidget(
                      section: section, onTap: presenter.onItemClicked);
                case SectionType.contentMarkdown:
                  return ShowcaseContentMarkdown(
                      section: section, openLink: presenter.openLink);
                default:
                  return SizedBox.shrink();
              }
            }).toList()),
          );
        }),
        presenter: widget.presenter);
  }
}
