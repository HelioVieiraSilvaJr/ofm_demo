import 'package:flutter/material.dart';
import 'package:ofm_demo/Commons/Enums/SectionType.dart';
import 'package:ofm_demo/Resources/DSColors.dart';
import 'package:ofm_demo/Scenes/Showcase/ShowcasePresenter.dart';
import 'package:ofm_demo/Scenes/Showcase/Widgets/ShowcaseBubbleWidget.dart';
import 'package:ofm_demo/Scenes/Showcase/Widgets/ShowcaseCategoriesWidget.dart';
import 'package:ofm_demo/Scenes/Showcase/Widgets/ShowcaseContentMarkdown.dart';
import 'package:ofm_demo/Scenes/Showcase/Widgets/ShowcaseDoubleWideImages.dart';
import 'package:ofm_demo/Scenes/Showcase/Widgets/ShowcasePageBigImageWidget.dart';
import 'package:ofm_demo/Scenes/Showcase/Widgets/ShowcaseProductGridWidget.dart';
import 'package:ofm_demo/Scenes/Showcase/Widgets/ShowcaseProductListHorizontalWidget.dart';
import 'package:ofm_demo/Scenes/Showcase/Widgets/ShowcaseWideImage.dart';
import 'package:ofm_demo/Sources/Base/BaseView.dart';
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
          return RefreshIndicator(
            color: Colors.white,
            backgroundColor: DSColors().primaryColor,
            onRefresh: () async {
              presenter.loadData();
              await Future.delayed(const Duration(milliseconds: 500));
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      (widget.presenter.appBar?.preferredSize.height ?? 0) -
                      MediaQuery.of(context).padding.top,
                ),
                child: Column(
                    children: presenter.sections.value.map((section) {
                  switch (section.type) {
                    case SectionType.bigImage:
                      return ShowcasePageBigImageWidget(
                          section: section, onTap: presenter.handlerClickItem);
                    case SectionType.doubleWideImages:
                      return ShowcaseDoubleWideImages(
                          section: section, onTap: presenter.handlerClickItem);
                    case SectionType.wideImage:
                      return ShowcaseWideImage(
                          section: section, onTap: presenter.handlerClickItem);
                    case SectionType.categories:
                      return ShowcaseCategoriesWidget(
                          section: section, onTap: presenter.handlerClickItem);
                    case SectionType.bubbles:
                      return ShowcaseBubbleWidget(
                          section: section, onTap: presenter.handlerClickItem);
                    case SectionType.productList:
                      return ShowcaseProductGridWidget(
                          section: section, onTap: presenter.handlerClickItem);
                    case SectionType.productListHorizontal:
                      return ShowcaseProductListHorizontalWidget(
                          section: section, onTap: presenter.handlerClickItem);
                    case SectionType.contentMarkdown:
                      return ShowcaseContentMarkdown(
                          section: section,
                          openLink: presenter.handlerOpenLink);
                    default:
                      return SizedBox.shrink();
                  }
                }).toList()),
              ),
            ),
          );
        }),
        presenter: widget.presenter);
  }
}
