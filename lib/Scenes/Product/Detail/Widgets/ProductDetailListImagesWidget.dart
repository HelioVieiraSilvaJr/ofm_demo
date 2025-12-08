import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ofm_demo/Scenes/Product/Detail/Model/ProductModel.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ProductDetailListImagesWidget extends StatefulWidget {
  final List<SKUImage> images;

  const ProductDetailListImagesWidget({super.key, required this.images});

  @override
  State<ProductDetailListImagesWidget> createState() =>
      _ProductDetailListImagesWidgetState();
}

class _ProductDetailListImagesWidgetState
    extends State<ProductDetailListImagesWidget> {
  final Map<int, VideoPlayerController> _controllers = {};
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _initVideoControllers();
  }

  void _initVideoControllers() async {
    for (int i = 0; i < widget.images.length; i++) {
      final img = widget.images[i];
      if (img.type.toLowerCase() == 'video') {
        print(
            '==> Initializing video controller for video at index $i: ${img.url}');
        // ignore: deprecated_member_use
        final controller = VideoPlayerController.network(img.url);
        _controllers[i] = controller;
        try {
          await controller.initialize();
          controller.setLooping(true);
        } catch (e) {
          // ignore init errors for now
        }
        if (!mounted) return;
        setState(() {});
      }
    }

    // If the initial page is a video, try to play it
    _playIfVideo(_currentPage);
  }

  void _playIfVideo(int index) {
    for (final entry in _controllers.entries) {
      if (entry.key == index) {
        if (entry.value.value.isInitialized) entry.value.play();
      } else {
        if (entry.value.value.isPlaying) entry.value.pause();
      }
    }
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    _controllers.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.width,
          width: double.infinity,
          child: PageView.builder(
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
              _playIfVideo(index);
            },
            itemBuilder: (context, index) {
              final img = widget.images[index];
              if (img.type.toLowerCase() == 'video') {
                final controller = _controllers[index];
                return VisibilityDetector(
                  key: Key('video-$index'),
                  onVisibilityChanged: (info) {
                    final visible = info.visibleFraction > 0.5;
                    if (controller != null && controller.value.isInitialized) {
                      if (visible) {
                        print('==> Playing video at index $index');
                        controller.play();
                      } else {
                        print('==> Pausing video at index $index');
                        controller.pause();
                      }
                    }
                  },
                  child: controller == null || !controller.value.isInitialized
                      ? Container(
                          color: Colors.black,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: FittedBox(
                            fit: BoxFit.cover,
                            clipBehavior: Clip.hardEdge,
                            child: SizedBox(
                              width: controller.value.size.width,
                              height: controller.value.size.height,
                              child: VideoPlayer(controller),
                            ),
                          ),
                        ),
                );
              }

              // default: image
              return CachedNetworkImage(
                imageUrl: img.url,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              );
            },
          ),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.images.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index == _currentPage ? Colors.white : Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
