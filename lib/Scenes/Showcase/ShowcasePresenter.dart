import 'package:ofm_demo/Commons/Models/ItemModel.dart';
import 'package:ofm_demo/Commons/Models/SectionModel.dart';
import 'package:ofm_demo/Sources/Base/BasePresenter.dart';
import 'package:ofm_demo/Scenes/Showcase/ShowcaseViewModel.dart';
import 'package:rx_notifier/rx_notifier.dart';

class ShowcasePresenter extends BasePresenter {
  // MARK: Properties
  late final ShowcaseViewModel viewModel;
  RxNotifier<List<SectionModel>> sections = RxNotifier<List<SectionModel>>([]);

  ShowcasePresenter(String path) {
    viewModel = ShowcaseViewModel(path);
    _bindEvents();
  }

  // MARK: BindEvents
  _bindEvents() {
    viewModel.shouldUpdateUI = () {
      this.sections.value = viewModel.sections;
    };
  }

  // MARK: Actions
  onItemClicked(ItemModel item) {
    print('Item clicked: ${item.toJSON()}');
  }

  openLink(String? url) {
    if (url != null) {
      print('Open link: $url');
    }
  }

  // MARK: Methods
  loadData() {
    viewModel.fetch();
  }
}
