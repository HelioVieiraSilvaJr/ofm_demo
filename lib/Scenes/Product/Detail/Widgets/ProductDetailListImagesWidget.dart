import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ofm_demo/Commons/Widgets/CustomCircularProgressIndicator.dart';
import 'package:ofm_demo/Scenes/Product/Detail/Model/ProductModel.dart';
import 'package:ofm_demo/Sources/CacheConfig.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:http/http.dart' as http;

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
  final Set<int> _failedControllers = {};
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    // Inicialização de vídeos será feita de forma preguiçosa quando ficarem visíveis
  }

  @override
  void didUpdateWidget(ProductDetailListImagesWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Se a lista de imagens mudou (novo SKU selecionado), limpar controladores antigos
    // Comparar pelo tamanho e pela URL do primeiro item para detectar mudança de SKU
    if (oldWidget.images.length != widget.images.length ||
        (oldWidget.images.isNotEmpty &&
            widget.images.isNotEmpty &&
            oldWidget.images[0].url != widget.images[0].url)) {
      _resetControllers();
      _currentPage = 0;
      // Forçar rebuild após resetar controladores
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          // Reset PageView para primeira posição
          _pageController.jumpToPage(0);
          setState(() {});
        }
      });
    }
  }

  void _resetControllers() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    _controllers.clear();
    _failedControllers.clear();
  }

  Future<void> _ensureControllerInitialized(int index) async {
    if (_controllers.containsKey(index) || _failedControllers.contains(index))
      return;
    final img = widget.images[index];
    if (img.type.toLowerCase() != 'video') return;

    // create controller for original url
    // ignore: deprecated_member_use
    VideoPlayerController controller = VideoPlayerController.network(img.url);
    _controllers[index] = controller;
    try {
      debugPrint(
          'Initializing video controller for index=$index url=${img.url}');
      await controller.initialize();
      controller.setLooping(true);
      if (!mounted) return;
      setState(() {});
      return;
    } catch (e, st) {
      debugPrint('Initial initialize failed for index=$index: $e\n$st');
      // try to resolve redirect and retry
      try {
        debugPrint('Attempting to resolve redirect for index=$index');
        final resp = await http.get(Uri.parse(img.url));
        final finalUri = resp.request?.url;
        if (finalUri != null && finalUri.toString() != img.url) {
          debugPrint('Resolved final url for index=$index -> $finalUri');
          try {
            await controller.dispose();
          } catch (_) {}
          // ignore: deprecated_member_use
          controller = VideoPlayerController.network(finalUri.toString());
          _controllers[index] = controller;
          await controller.initialize();
          controller.setLooping(true);
          if (!mounted) return;
          setState(() {});
          return;
        }
      } catch (e2, st2) {
        debugPrint('Redirect resolution failed for index=$index: $e2\n$st2');
      }

      debugPrint('Failed to initialize video controller index=$index: $e\n$st');
      _failedControllers.add(index);
      _controllers.remove(index);
      if (!mounted) return;
      setState(() {});
    }
  }

  void _playIfVideo(int index) {
    for (final entry in _controllers.entries) {
      if (entry.key == index) {
        if (entry.value.value.isInitialized) {
          entry.value.play();
        }
      } else {
        if (entry.value.value.isPlaying) {
          entry.value.pause();
        }
      }
    }
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    _controllers.clear();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.width * 1.2,
          width: double.infinity,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
              _playIfVideo(index);
            },
            itemBuilder: (context, index) {
              final img = widget.images[index];
              if (img.type.toLowerCase() == 'video') {
                return VisibilityDetector(
                  key: Key('video-$index-${img.url}'),
                  onVisibilityChanged: (info) {
                    final visible = info.visibleFraction > 0.5;
                    final c = _controllers[index];
                    if (c == null && visible) {
                      // initialize lazily when becomes visible
                      _ensureControllerInitialized(index).then((_) {
                        final c2 = _controllers[index];
                        if (c2 != null && c2.value.isInitialized) {
                          debugPrint(
                              '==> Playing video at index $index after init');
                          c2.play();
                        }
                      });
                      return;
                    }

                    if (c != null && c.value.isInitialized) {
                      if (visible) {
                        debugPrint('==> Playing video at index $index');
                        c.play();
                      } else {
                        debugPrint('==> Pausing video at index $index');
                        c.pause();
                      }
                    }
                  },
                  child: (() {
                    final c = _controllers[index];
                    if (c == null) {
                      if (_failedControllers.contains(index)) {
                        return Container(
                          color: Colors.black,
                          child: const Center(
                            child: Icon(
                              Icons.error,
                              color: Colors.white,
                            ),
                          ),
                        );
                      }
                      return Container(
                        color: Colors.black,
                        child: Center(
                          child: CustomCircularProgressIndicator(),
                        ),
                      );
                    }

                    if (!c.value.isInitialized) {
                      return Container(
                        color: Colors.black,
                        child: Center(
                          child: CustomCircularProgressIndicator(),
                        ),
                      );
                    }

                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        clipBehavior: Clip.hardEdge,
                        child: SizedBox(
                          width: c.value.size.width,
                          height: c.value.size.height,
                          child: VideoPlayer(c),
                        ),
                      ),
                    );
                  })(),
                );
              }

              // default: image
              return CachedNetworkImage(
                imageUrl: img.url,
                fit: BoxFit.cover,
                cacheManager: CacheConfig.cacheManager,
                placeholder: (context, url) => Center(
                  child: CustomCircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
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
