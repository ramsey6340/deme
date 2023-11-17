import 'package:deme/constants.dart';
import 'package:deme/size_config.dart';
import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:flutter/material.dart';

class LoadingButton extends StatefulWidget {
  const LoadingButton({
    super.key,
    this.text='Continuer',
    this.onPressed,
    this.buttonColor=kPrimaryColor,
    this.contentGap=6.0,
    this.elevation=0.0,
    this.borderRadius=5,
    this.height=40,
    this.width=150,
    this.useEqualLoadingStateWidgetDimension=true,
    this.useWidthAnimation=true,
    this.type=EasyButtonType.elevated
  });

  final String text;
  final Function? onPressed;
  final Color buttonColor;
  final double contentGap;
  final double elevation;
  final double borderRadius;
  final double height;
  final double width;
  final bool useEqualLoadingStateWidgetDimension;
  final bool useWidthAnimation;
  final EasyButtonType type;

  @override
  State<LoadingButton> createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  @override
  Widget build(BuildContext context) {
    return EasyButton(
      type: widget.type,

      // Content inside the button when the button state is idle.
      idleStateWidget: Text(
        widget.text,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),

      // Content inside of the button when the button state is loading.
      loadingStateWidget: const CircularProgressIndicator(
        strokeWidth: 3.0,
        valueColor: AlwaysStoppedAnimation<Color>(
          Colors.white,
        ),
      ),

      // Whether or not to animate the width of the button. Default is `true`.
      // If this is set to `false`, you might want to set the `useEqualLoadingStateWidgetDimension` parameter to `true`.
      useWidthAnimation: widget.useWidthAnimation,

      // Whether or not to force the `loadingStateWidget` to have equal dimension. Default is `true`.
      // This is useful when you are using `CircularProgressIndicator` as the `loadingStateWidget`.
      // This parameter might also be useful when you set the `useWidthAnimation` parameter to `true` combined with `CircularProgressIndicator` as the value for `loadingStateWidget`.
      useEqualLoadingStateWidgetDimension: widget.useEqualLoadingStateWidgetDimension,

      // If you want a fullwidth size, set this to double.infinity
      width: getProportionateScreenWidth(widget.width),

      height: getProportionateScreenHeight(widget.height),
      borderRadius: widget.borderRadius,

      // The elevation of the button.
      // This will only be applied when the type parameter value is EasyButtonType.elevated
      elevation: widget.elevation,

      // The gap between button and it's content.
      // This will be ignored when the `type` parameter value is set to `EasyButtonType.text`
      contentGap: widget.contentGap,

      // Color for the button.
      // For [EasyButtonType.elevated]: This will be the background color.
      // For [EasyButtonType.outlined]: This will be the border color.
      // For [EasyButtonType.text]: This will be the text color.
      buttonColor: widget.buttonColor,

      onPressed: widget.onPressed,
    );
  }
}
