import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ofm_demo/Resources/DesignSystem/Widgets/DSText.dart';
import 'package:ofm_demo/Scenes/Checkout/Payment/Models/PaymentModel.dart';
import 'package:ofm_demo/Scenes/Checkout/Delivery/Widgets/RadioButton.dart';

class PaymentOptionContent extends StatelessWidget {
  final PaymentOption option;
  final bool isSelected;

  const PaymentOptionContent({
    super.key,
    required this.option,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RadioButton(isSelected: isSelected),
        const SizedBox(width: 12),
        Expanded(
          child: DSText.medium(
            option.name,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 8),
        _buildBands(),
      ],
    );
  }

  Widget _buildBands() {
    if (option.bands.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: option.bands
          .map((bandUrl) => Padding(
                padding: const EdgeInsets.only(left: 4),
                child: _buildBandImage(bandUrl),
              ))
          .toList(),
    );
  }

  Widget _buildBandImage(String bandUrl) {
    final isSvg = bandUrl.toLowerCase().endsWith('.svg');

    if (isSvg) {
      return ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 24,
          maxWidth: 60,
        ),
        child: SvgPicture.network(
          bandUrl,
          fit: BoxFit.contain,
          colorFilter: null, // Allow SVG to use its own colors
          placeholderBuilder: (context) => Container(
            height: 24,
            width: 40,
            color: Colors.grey.shade200,
            child: Center(
              child: SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 24,
        maxWidth: 60,
      ),
      child: Image.network(
        bandUrl,
        fit: BoxFit.contain,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            height: 24,
            width: 40,
            color: Colors.grey.shade200,
            child: Center(
              child: SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 24,
            width: 40,
            color: Colors.grey.shade200,
            child: Icon(
              Icons.credit_card,
              size: 16,
              color: Colors.grey.shade400,
            ),
          );
        },
      ),
    );
  }
}
