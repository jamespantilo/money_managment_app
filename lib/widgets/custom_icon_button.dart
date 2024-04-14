import 'package:flutter/material.dart';
import '../core/app_export.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    Key? key,
    this.alignment,
    this.height,
    this.width,
    this.padding,
    this.decoration,
    this.child,
    this.onTap,
  }) : super(
          key: key,
        );

  final Alignment? alignment;

  final double? height;

  final double? width;

  final EdgeInsetsGeometry? padding;

  final BoxDecoration? decoration;

  final Widget? child;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: iconButtonWidget,
          )
        : iconButtonWidget;
  }

  Widget get iconButtonWidget => SizedBox(
        height: height ?? 0,
        width: width ?? 0,
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Container(
            height: height ?? 0,
            width: width ?? 0,
            padding: padding ?? EdgeInsets.zero,
            decoration: decoration ??
                BoxDecoration(
                  color: appTheme.deepPurple50,
                  borderRadius: BorderRadius.circular(16.h),
                ),
            child: child,
          ),
          onPressed: onTap,
        ),
      );
}

/// Extension on [CustomIconButton] to facilitate inclusion of all types of border style etc
extension IconButtonStyleHelper on CustomIconButton {
  static BoxDecoration get outlineGray => BoxDecoration(
        borderRadius: BorderRadius.circular(8.h),
        border: Border.all(
          color: appTheme.gray10002,
          width: 1.h,
        ),
      );
  static BoxDecoration get fillYellow => BoxDecoration(
        color: appTheme.yellow100,
        borderRadius: BorderRadius.circular(16.h),
      );
  static BoxDecoration get fillRed => BoxDecoration(
        color: appTheme.red100,
        borderRadius: BorderRadius.circular(16.h),
      );
  static BoxDecoration get outlinePrimary => BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(
            8.h,
          ),
        ),
        border: Border.all(
          color: theme.colorScheme.primary,
          width: 1.h,
        ),
      );
  static BoxDecoration get outlineGrayLR8 => BoxDecoration(
        color: theme.colorScheme.onErrorContainer,
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(
            8.h,
          ),
        ),
        border: Border.all(
          color: appTheme.gray10002,
          width: 1.h,
        ),
      );
  static BoxDecoration get fillDeepOrange => BoxDecoration(
        color: appTheme.deepOrange50,
        borderRadius: BorderRadius.circular(16.h),
      );
  static BoxDecoration get fillDeepPurpleA => BoxDecoration(
        color: appTheme.deepPurpleA700,
        borderRadius: BorderRadius.circular(11.h),
      );
  static BoxDecoration get fillTeal => BoxDecoration(
        color: appTheme.teal500,
        borderRadius: BorderRadius.circular(28.h),
      );
  static BoxDecoration get fillOnError => BoxDecoration(
        color: theme.colorScheme.onError,
        borderRadius: BorderRadius.circular(28.h),
      );
}
