enum ActionType {
  showcase,
  openExternalLink,
  goToCart,
  none;
}

extension ActionTypeExtension on ActionType {
  String get rawValue {
    switch (this) {
      case ActionType.showcase:
        return 'showcase';
      case ActionType.openExternalLink:
        return 'openExternalLink';
      case ActionType.goToCart:
        return 'goToCart';
      case ActionType.none:
        return 'none';
    }
  }

  static ActionType unwrapped(String? key) {
    var status = ActionType.none;
    if (key != null) {
      try {
        status = ActionType.values.firstWhere(
          (value) => value.toString() == 'ActionType.$key',
          orElse: () => ActionType.none,
        );
      } catch (_) {}
    }
    return status;
  }
}
