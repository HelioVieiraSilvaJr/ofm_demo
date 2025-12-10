import 'package:flutter/material.dart';
import 'package:ofm_demo/Commons/Enums/ActionType.dart';
import 'package:ofm_demo/Commons/Models/ItemModel.dart';
import 'package:ofm_demo/Commons/Models/SectionModel.dart';
import 'package:ofm_demo/Sources/Base/BasePresenter.dart';
import 'package:ofm_demo/Scenes/Showcase/ShowcaseViewModel.dart';
import 'package:ofm_demo/Sources/Coordinator/AppCoordinator.dart';
import 'package:rx_notifier/rx_notifier.dart';

class ShowcasePresenter extends BasePresenter {
  // MARK: Properties
  final AppBar? appBar;
  late final ShowcaseViewModel viewModel;
  AppCoordinator? coordinator;
  RxNotifier<List<SectionModel>> sections = RxNotifier<List<SectionModel>>([]);

  ShowcasePresenter({required String path, this.appBar}) {
    viewModel = ShowcaseViewModel(path);
    setLoading(true);
    _bindEvents();
  }

  // MARK: BindEvents
  _bindEvents() {
    viewModel.shouldUpdateUI = () {
      this.sections.value = viewModel.sections;
      setLoading(false);
    };
  }

  // MARK: Actions
  handlerClickItem(ItemModel item) {
    switch (item.action) {
      case ActionType.showcase:
        if (item.link != null) {
          coordinator?.goToShowcase(item.link!, item.title);
        }
        break;
      case ActionType.productDetail:
        if (item.link != null) {
          coordinator?.goToProductDetail(item.link!, item.title);
        }
        break;
      case ActionType.openExternalLink:
        coordinator?.openLink(item.link);
        break;
      case ActionType.cart:
        coordinator?.goToCart();
        break;
      default:
        print('==> No action defined for this item');
    }
  }

  handlerOpenLink(String? url) {
    coordinator?.openLink(url);
  }

  // MARK: Methods
  loadData() {
    viewModel.fetch();
  }
}
