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
  void onSectionClicked(SectionModel section) {
    print('Image clicked for section: ${section.toJSON()}');
  }

  // MARK: Methods
  loadData() {
    viewModel.fetch();
  }
}
