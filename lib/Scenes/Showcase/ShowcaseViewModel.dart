import 'package:ofm_demo/Commons/Models/SectionModel.dart';
import 'package:ofm_demo/Commons/Models/ShowcaseModel.dart';
import 'package:ofm_demo/Sources/CacheManager.dart';
import 'package:ofm_demo/Sources/Network/Network.dart';

class ShowcaseViewModel {
  // MARK: Properties
  final String _path;
  ShowcaseModel? _showcase;
  Function? shouldUpdateUI;

  ShowcaseViewModel(this._path);

  // MARK: Methods
  ShowcaseModel? get showcase => _showcase;

  List<SectionModel> get sections {
    return _showcase?.sections ?? [];
  }

  // MARK: Services
  fetch() async {
    final network = Network();
    print('==> ShowcaseViewModel.fetch: Fetching data for path $_path');

    final result = await network
        .get('$_path', headers: {'Content-Type': 'application/json'});

    final cacheKey = 'showcase_$_path';
    final showcase = ShowcaseModel.initFromMap(data: result.bodyResponse);
    // CacheManager.instance.set(cacheKey, showcase);
    _showcase = showcase;
    print('==> ShowcaseViewModel.fetch: $_showcase');
    shouldUpdateUI!();
  }
}
