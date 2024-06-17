import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class PainCButton extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  final Color borderColor;
  final Color spashColor;
  final Color titleColor;
  final Color tappedTitleColor;
  final FontWeight fontWeight;
  final BorderRadiusGeometry borderRadius;
  final Duration duration;
  PainCButton({
    Key key,
    @required this.title,
    @required this.onTap,
    this.borderColor,
    this.spashColor,
    this.titleColor,
    this.tappedTitleColor,
    this.borderRadius,
    this.fontWeight,
    this.duration,
  }) : super(key: key);

  @override
  _PainCButtonState createState() => _PainCButtonState();
}

class _PainCButtonState extends State<PainCButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Color> _colorAnimation;
  Animation<Color> _textColorAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: (widget.duration != null)
          ? widget.duration
          : Duration(milliseconds: 10),
    );
    _colorAnimation = ColorTween(
      begin: Colors.white,
      end: (widget.spashColor != null) ? widget.spashColor : Colors.black,
    ).animate(_animationController);

    _textColorAnimation = ColorTween(
      begin: (widget.titleColor != null) ? widget.titleColor : Colors.black,
      end: (widget.tappedTitleColor != null)
          ? widget.tappedTitleColor
          : Colors.white,
    ).animate(_animationController);

    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        _animationController.forward();
      },
      onTapCancel: () {
        _animationController.reverse();
      },
      onTapUp: (details) {
        _animationController.reverse();
        widget.onTap();
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            decoration: buildBoxDecorationOfAnimeHoverButton(),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Center(
                child: Text(
                  (widget.title != null) ? widget.title : "Animated Hover Button",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 18.0,
                      color: _textColorAnimation.value,
                      fontWeight: widget.fontWeight,
                      fontFamily: 'Nunito'
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  BoxDecoration buildBoxDecorationOfAnimeHoverButton() {
    return BoxDecoration(
      borderRadius: (widget.borderRadius == null)
          ? BorderRadius.circular(10)
          : widget.borderRadius,
      border: Border.all(
        width: 1.0,
        color: (widget.borderColor != null) ? widget.borderColor : Colors.black,
      ),
      color: _colorAnimation.value,
    );
  }
}