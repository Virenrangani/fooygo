import 'package:flutter/material.dart';

class FoodDetailsImage extends StatefulWidget {
  final String imageUrl;
  final double width;
  final double height;

  const FoodDetailsImage({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
  });

  @override
  State<FoodDetailsImage> createState() =>
      _FoodDetailsImageState();
}

class _FoodDetailsImageState
    extends State<FoodDetailsImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  bool isPressed = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
      lowerBound: 0,
      upperBound: 0.06,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    setState(() => isPressed = true);
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => isPressed = false);
    _controller.reverse();
  }

  void _onTapCancel() {
    setState(() => isPressed = false);
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final tilt = _controller.value;

          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.002)
              ..rotateX(tilt)
              ..rotateY(-tilt),
            child: AnimatedScale(
              scale: isPressed ? 0.95 : 1,
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(
                        isPressed ? 0.12 : 0.25,
                      ),
                      blurRadius: isPressed ? 10 : 25,
                      offset: Offset(
                        0,
                        isPressed ? 6 : 14,
                      ),
                    ),
                  ],
                ),
                child: Hero(
                  tag: widget.imageUrl,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: _buildImage(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildImage() {
    if (widget.imageUrl.isEmpty) {
      return Image.asset(
        'assets/image/food.png',
        width: widget.width,
        height: widget.height,
        fit: BoxFit.cover,
      );
    }

    return Image.network(
      widget.imageUrl,
      width: widget.width,
      height: widget.height,
      fit: BoxFit.cover,
      loadingBuilder: (
          context,
          child,
          loadingProgress,
          ) {
        if (loadingProgress == null) return child;

        return Container(
          width: widget.width,
          height: widget.height,
          color: Colors.grey.shade100,
          child: const Center(
            child: CircularProgressIndicator(
              color: Colors.deepOrange,
            ),
          ),
        );
      },
      errorBuilder: (_, __, ___) {
        return Image.asset(
          'assets/image/food.png',
          width: widget.width,
          height: widget.height,
          fit: BoxFit.cover,
        );
      },
    );
  }
}