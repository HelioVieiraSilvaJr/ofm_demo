import 'package:flutter/material.dart';
import 'package:ofm_demo/Resources/DesignSystem/Colors/DSColors.dart';
import 'package:ofm_demo/Resources/DesignSystem/Widgets/DSButtonWidget.dart';
import 'package:ofm_demo/Resources/DesignSystem/Widgets/DSText.dart';
import 'package:ofm_demo/Scenes/Checkout/Success/CheckoutSuccessPresenter.dart';
import 'package:ofm_demo/Sources/Base/BaseView.dart';

class CheckoutSuccessView extends StatefulWidget {
  final CheckoutSuccessPresenter presenter;

  const CheckoutSuccessView({super.key, required this.presenter});

  @override
  State<CheckoutSuccessView> createState() => _CheckoutSuccessViewState();
}

class _CheckoutSuccessViewState extends State<CheckoutSuccessView>
    with SingleTickerProviderStateMixin {
  late final presenter = widget.presenter;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        appBar: presenter.appBar, body: _body, presenter: presenter);
  }

  Widget get _body {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),

          // Success Icon with Animation
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_circle,
                    size: 80,
                    color: Colors.green.shade600,
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 32),

          // Success Title
          FadeTransition(
            opacity: _fadeAnimation,
            child: DSText.large(
              'Bestelling geplaatst!',
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 16),

          // Success Message
          FadeTransition(
            opacity: _fadeAnimation,
            child: DSText.medium(
              'Je bestelling is succesvol geplaatst.\nJe ontvangt binnenkort een bevestigingsmail.',
              textAlign: TextAlign.center,
              color: Colors.grey.shade700,
            ),
          ),

          const SizedBox(height: 48),

          // Order Number
          FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  DSText.compact(
                    'Bestelnummer',
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(height: 8),
                  DSText.large(
                    '#${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
                    fontWeight: FontWeight.bold,
                    color: DSColors().primaryColor,
                  ),
                ],
              ),
            ),
          ),

          const Spacer(flex: 3),

          // Action Buttons
          FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: DSButtonWidget(
                    title: 'Bekijk mijn bestellingen',
                    type: DSButtonType.primary,
                    state: DSButtonState.enabled,
                    onTap: (_) {
                      debugPrint('Navigate to orders');
                      // TODO: Navigate to orders screen
                    },
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: DSButtonWidget(
                    title: 'Terug naar home',
                    type: DSButtonType.secondary,
                    state: DSButtonState.enabled,
                    onTap: (_) {
                      debugPrint('Navigate to home');
                      presenter.handlerGoToHome();
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
