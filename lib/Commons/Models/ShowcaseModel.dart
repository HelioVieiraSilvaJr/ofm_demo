import 'SectionModel.dart';

class ShowcaseModel {
  final int? resultsCount;
  final String? description;
  final List<SectionModel> sections;

  ShowcaseModel({
    this.resultsCount,
    this.description,
    required this.sections,
  });

  factory ShowcaseModel.initFromMap({required Map<String, dynamic> data}) {
    List<dynamic> itemsList = data['sections'] ?? [];
    List<SectionModel> sections =
        itemsList.map((e) => SectionModel.fromJson(e)).toList();

    final model = ShowcaseModel(
      resultsCount: data['resultsCount'],
      description: data['description'],
      sections: sections,
    );
    return model;
  }

  toJSON() {
    return {
      'resultsCount': resultsCount,
      'description': description,
      'sections': sections.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'ShowcaseModel(resultsCount: $resultsCount, description: $description, sections: $sections)';
  }
}
