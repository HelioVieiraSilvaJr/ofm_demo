import 'package:flutter/material.dart';
import 'package:ofm_demo/Resources/DesignSystem/Widgets/DSText.dart';
import 'package:ofm_demo/Scenes/Product/Detail/ProductDetailPresenter.dart';

class ProductDetailSelectedSizeWidget extends StatelessWidget {
  final ProductDetailPresenter presenter;

  const ProductDetailSelectedSizeWidget({super.key, required this.presenter});

  @override
  Widget build(BuildContext context) {
    final sizes = presenter.viewModel.selectedSKU.value?.sizes ?? [];
    final selectedSize = sizes.where((s) => s.selected).firstOrNull;
    const height = 48.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: height,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: sizes.length,
              itemBuilder: (context, index) {
                final size = sizes[index];
                final isSelected = size.selected;

                final child = Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  alignment: Alignment.center,
                  child: DSText.compact(
                    size.size,
                    color: size.available ? Colors.black : Colors.grey,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                );

                Widget borderChild;
                if (size.available) {
                  borderChild = Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected ? Colors.black : Colors.grey,
                        width: 1.5,
                        style: BorderStyle.solid,
                      ),
                      color: isSelected ? Colors.black12 : Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: child,
                  );
                } else {
                  borderChild = Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: CustomPaint(
                      painter:
                          _DottedBorderPainter(radius: 6, color: Colors.grey),
                      child: child,
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: GestureDetector(
                    onTap: size.available
                        ? () {
                            presenter.handlerSetSize(size);
                          }
                        : null,
                    child: borderChild,
                  ),
                );
              },
            ),
          ),
          if (selectedSize?.senseOfUrgency != null &&
              selectedSize!.senseOfUrgency!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 12.0, left: 6.0),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.local_fire_department,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    DSText.compact(
                      selectedSize.senseOfUrgency!,
                        color: Colors.white,
                      fontWeight: FontWeight.w600
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _DottedBorderPainter extends CustomPainter {
  final double radius;
  final Color color;

  _DottedBorderPainter({this.radius = 4, this.color = Colors.grey});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    const dashWidth = 4.0;
    const dashSpace = 4.0;

    void drawDashedLine(Offset p1, Offset p2) {
      final total = (p2 - p1).distance;
      final direction = (p2 - p1) / total;
      double start = 0.0;
      while (start < total) {
        final end = (start + dashWidth).clamp(0.0, total);
        final a = p1 + direction * start;
        final b = p1 + direction * end;
        canvas.drawLine(a, b, paint);
        start += dashWidth + dashSpace;
      }
    }

    drawDashedLine(Offset(rrect.left + radius, rrect.top),
        Offset(rrect.right - radius, rrect.top));
    drawDashedLine(Offset(rrect.right, rrect.top + radius),
        Offset(rrect.right, rrect.bottom - radius));
    drawDashedLine(Offset(rrect.right - radius, rrect.bottom),
        Offset(rrect.left + radius, rrect.bottom));
    drawDashedLine(Offset(rrect.left, rrect.bottom - radius),
        Offset(rrect.left, rrect.top + radius));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
