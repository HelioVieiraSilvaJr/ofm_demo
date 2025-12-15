import 'package:flutter/material.dart';
import 'package:ofm_demo/Resources/DesignSystem/Colors/DSColors.dart';

class DSButtonWidget extends StatelessWidget {
  final String title;
  final DSButtonType type;
  final DSButtonState state;
  final DSButtonIconPosition iconPosition;
  final DSButtonShape shape;
  final DSButtonIconType iconType;
  final String? buttonId;
  final Function(String?)? onPressed;

  const DSButtonWidget(
      {super.key,
      required this.title,
      required this.type,
      this.state = DSButtonState.enabled,
      this.iconPosition = DSButtonIconPosition.left,
      this.shape = DSButtonShape.rounded,
      this.iconType = DSButtonIconType.none,
      this.buttonId,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = state == DSButtonState.enabled;
    final bool isLoading = state == DSButtonState.loading;

    // Define colors based on type
    final Color backgroundColor =
        isEnabled ? type.backgroundColor : Colors.grey;

    final Color textColor = isEnabled ? type.textColor : Colors.grey;

    final Color borderColor = type == DSButtonType.secondary
        ? (isEnabled ? DSColors().primaryColor : Colors.grey)
        : Colors.transparent;

    // Icon widget based on iconType
    Widget? iconWidget;
    if (iconType != DSButtonIconType.none && !isLoading) {
      IconData iconData;
      switch (iconType) {
        case DSButtonIconType.cart:
          iconData = Icons.shopping_bag;
          break;
        case DSButtonIconType.ai:
          iconData = Icons.auto_awesome;
          break;
        default:
          iconData = Icons.error;
      }
      iconWidget = Icon(iconData, color: textColor, size: 20);
    }

    // Build button content
    List<Widget> buttonChildren = [];

    if (isLoading) {
      buttonChildren.add(
        SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(textColor),
          ),
        ),
      );
    } else {
      if (iconWidget != null && iconPosition == DSButtonIconPosition.left) {
        buttonChildren.add(iconWidget);
        buttonChildren.add(const SizedBox(width: 8));
      }

      buttonChildren.add(
        Text(
          title,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      );

      if (iconWidget != null && iconPosition == DSButtonIconPosition.right) {
        buttonChildren.add(const SizedBox(width: 8));
        buttonChildren.add(iconWidget);
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed:
            isEnabled && !isLoading ? () => onPressed?.call(buttonId) : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          disabledBackgroundColor: backgroundColor,
          disabledForegroundColor: textColor,
          elevation: type == DSButtonType.primary ? 2 : 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          shape: shape == DSButtonShape.rounded
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                      color: borderColor,
                      width: type == DSButtonType.secondary ? 2 : 0),
                )
              : RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                  side: BorderSide(
                      color: borderColor,
                      width: type == DSButtonType.secondary ? 2 : 0),
                ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: buttonChildren,
        ),
      ),
    );
  }
}

enum DSButtonType { primary, secondary }

enum DSButtonState { enabled, disabled, loading }

enum DSButtonIconPosition { left, right }

enum DSButtonShape { rounded, square }

enum DSButtonIconType { none, cart, ai }

extension DSButtonIconTypeExtension on DSButtonIconType {
  String get getIcon {
    switch (this) {
      case DSButtonIconType.none:
        return 'none';
      case DSButtonIconType.cart:
        return 'cart';
      case DSButtonIconType.ai:
        return 'ai';
    }
  }
}

extension DSButtonTypeExtension on DSButtonType {
  Color get backgroundColor {
    switch (this) {
      case DSButtonType.primary:
        return DSColors().primaryColor;
      case DSButtonType.secondary:
        return Colors.white;
    }
  }

  Color get textColor {
    switch (this) {
      case DSButtonType.primary:
        return Colors.white;
      case DSButtonType.secondary:
        return DSColors().primaryColor;
    }
  }
}
