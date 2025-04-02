import 'package:flutter/material.dart';

class BeautifulButton extends StatefulWidget {
  final VoidCallback onTap;
  final IconData icon;
  final String text;
  final Color colorm;
  final Color colors;

  const BeautifulButton({
    required this.onTap,
    required this.icon,
    required this.text,
    required this.colorm,
    required this.colors,
  });

  @override
  _BeautifulButtonState createState() => _BeautifulButtonState();
}

class _BeautifulButtonState extends State<BeautifulButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          onTapDown: _onTapDown,
          onTapUp: _onTapUp,
          onTapCancel: () => _controller.reverse(),
          splashColor: Colors.white.withOpacity(0.3),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            transform: Matrix4.identity()..scale(_animation.value),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [widget.colorm, widget.colors],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: Offset(0, 2),
                  blurRadius: 4,
                  spreadRadius: 0,
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(widget.icon, color: Colors.white),
                SizedBox(width: 10),
                Text(
                  widget.text,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
