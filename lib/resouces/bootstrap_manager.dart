import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:bootstrap_plus/resouces/models/bootstrap_col_size.dart';

import 'enums.dart';

double _oneColumnRatio = 0.083333;

///
/// Returns the definition prefix, based on the available width
///
ColSize bootstrapPrefixBasedOnWidth(double width) {
  if (width > 1200) {
    return ColSize.col12; // xl
  }
  if (width > 992) {
    return ColSize.col10; // lg
  }
  if (width > 767) {
    return ColSize.col8; // md
  }
  if (width > 575) {
    return ColSize.col6; // sm
  }
  return ColSize.col6; // xs
}

///
/// Returns the max width for non-fluid containers
/// based on a certain provided width
///
double bootstrapMaxWidthNonFluid(double width) {
  ///
  /// Otherwise, it depends on the available width
  ///
  if (width >= 1200) {
    return 1140;
  }
  if (width >= 992) {
    return 960;
  }
  if (width >= 768) {
    return 720;
  }
  if (width >= 576) {
    return 540;
  }
  return width;
}

///
/// Implementation of the Bootstrap .container and .container-fluid
///
class BootstrapContainer extends StatelessWidget {
  const BootstrapContainer({
    super.key,
    required this.children,
    this.fluid = false,
    this.decoration,
    this.padding,
  });

  ///
  /// Is the container fluid => if yes, takes the whole width
  /// Default value: false
  ///
  final bool fluid;

  ///
  /// Any potential BoxDecoration
  ///
  final BoxDecoration? decoration;

  ///
  /// Children
  ///
  final List<Widget> children;

  ///
  /// Padding
  ///
  final EdgeInsets? padding;

  //
  // Computes the max-width of a container, based on the available space
  //
  double _getMaxWidth(double width) {
    //
    // If the container is fluid, no constraints in terms of width
    //
    if (this.fluid) {
      return width;
    }

    //
    // Otherwise, it depends on the available width
    //
    return bootstrapMaxWidthNonFluid(width);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        //
        // Get the max width of the container
        //
        double width = _getMaxWidth(constraints.maxWidth);

        Widget widget = Container(
          width: width,
          decoration: decoration,
          child: Wrap(
            alignment: WrapAlignment.start,
            direction: Axis.horizontal,
            children: children,
          ),
        );

        if (padding != null) {
          widget = Padding(padding: padding!, child: widget);
        }

        return Align(alignment: Alignment.topCenter, child: widget);
      },
    );
  }
}

///
/// Implementation of the Bootstrap .row
///
/// A [BootstrapRow] may only contain [BootstrapCol] children.
///
class BootstrapRow extends StatelessWidget {
  const BootstrapRow({
    super.key,
    required this.children,
    this.decoration,
    this.height,
    this.padding,
    this.margin,
  });

  ///
  /// Min container height
  ///
  final double? height;

  ///
  /// Any potential BoxDecoration
  ///
  final BoxDecoration? decoration;

  ///
  /// List of the children of type [BootstrapCol]
  ///
  final List<BootstrapCol> children;

  final EdgeInsetsGeometry? padding;

  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        //
        // Get the prefix for the definition, based on the available width
        //
        ColSize pfx = bootstrapPrefixBasedOnWidth(constraints.maxWidth);

        //
        // We need to iterate through all the children and consider any potential order
        //
        List<BootstrapCol> _children = List.from(children);
        _children.sort(
          (a, b) => (a.orderPerSize[pfx] ?? 0) - (b.orderPerSize[pfx] ?? 0),
        );

        return Container(
          margin: margin,
          padding: padding,
          constraints: BoxConstraints(
            minHeight: height ?? 0.0,
            minWidth: constraints.maxWidth,
            maxWidth: constraints.maxWidth,
          ),
          decoration: decoration,
          child: Wrap(
            alignment: WrapAlignment.start,
            direction: Axis.horizontal,
            children: _children,
          ),
        );
      },
    );
  }
}

///
/// Implementation of the Bootstrap .col-*
///
class BootstrapCol extends StatelessWidget {
  BootstrapCol({
    super.key,
    required this.child,
    this.fit = FlexFit.loose,
    this.absoluteSizes = true,
    this.sizes = GridColSize.defaultSize,
    this.offsets = GridOffsetSize.defaultSize, // Changed from String to GridColSize
    String orders = "",
  }) : this.orders = orders.trim() {
    _initialize();
  }

  ///
  /// The child
  ///
  final Widget child;

  /// How a flexible child is inscribed into the available space.
  ///
  /// If [flex] is non-zero, the [fit] determines whether the child fills the
  /// space the parent makes available during layout. If the fit is
  /// [FlexFit.tight], the child is required to fill the available space. If the
  /// fit is [FlexFit.loose], the child can be at most as large as the available
  /// space (but is allowed to be smaller).
  final FlexFit fit;

  ///
  /// Sizes
  ///
  /// Corresponds to the Bootstrap classes: .col-*
  ///
  /// Defines the dimensions (in terms of number of columns),
  /// depending on the screen width.
  ///
  /// Example:
  ///   sizes: BootstarpColSize(xs: ColSize.col12, md: ColSize.col6)
  ///
  final GridColSize sizes;

  ///
  /// Offsets (= number of columns) to push this Widget to the right
  ///
  /// Corresponds to the Bootstrap classes: .offset-*
  ///
  /// Example:
  ///   offsets: GridColSize(xs: ColSize.col0, sm: ColSize.col1, md: ColSize.col2)
  ///
  final GridOffsetSize offsets; // Updated type

  ///
  /// Sequence orders
  ///
  /// Corresponds to the Bootstrap classes: .order-*
  ///
  /// Example:
  ///   orders: 'order-2 order-sm-2 order-md-1 order-lg-1 order-xl-1'
  ///
  final String orders;

  ///
  /// Do we consider relative dimensions (based on the parent container)
  /// or absolute (based on the browser window)
  /// Default: relative = false
  ///
  final bool absoluteSizes;

  //
  // Flex ratios per size, based on the column's definition
  //
  final Map<ColSize, int> _ratiosPerSize = {
    ColSize.col12: 100,
    ColSize.col10: 100,
    ColSize.col8: 100,
    ColSize.col6: 100,
    ColSize.col0: 100,
  };

  //
  // Offsets per size, based on the column's definition
  //
  final Map<ColSize, int> _offsetsPerSize = {
    ColSize.col12: -100,
    ColSize.col10: -100,
    ColSize.col8: -100,
    ColSize.col6: -100,
    ColSize.col0: -100,
  };

  //
  // Sequence order per size, based on the column's definition
  //
  final Map<ColSize, int> orderPerSize = {
    ColSize.col12: 0,
    ColSize.col10: 0,
    ColSize.col8: 0,
    ColSize.col6: 0,
    ColSize.col0: 0,
  };

  //
  // Defines the Flex ratios, based on the column's
  // definition, as well as the offsets
  //
  void _initialize() {
    final int nbPrefixes = ColSize.values.length;

    // Updated to use BootstarpColSize instead of parsing strings
    _ratiosPerSize[ColSize.col12] = sizes.xl.value;
    _ratiosPerSize[ColSize.col10] = sizes.lg.value;
    _ratiosPerSize[ColSize.col8] = sizes.md.value;
    _ratiosPerSize[ColSize.col6] = sizes.sm.value;
    _ratiosPerSize[ColSize.col0] = sizes.xs.value;

    _offsetsPerSize[ColSize.col12] = offsets.xl.value; // Updated to use GridColSize
    _offsetsPerSize[ColSize.col10] = offsets.lg.value; // Updated to use GridColSize
    _offsetsPerSize[ColSize.col8] = offsets.md.value; // Updated to use GridColSize
    _offsetsPerSize[ColSize.col6] = offsets.sm.value; // Updated to use GridColSize
    _offsetsPerSize[ColSize.col0] = offsets.xs.value; // Updated to use GridColSize

    //
    // ... the sequence orders (=> order-*)
    //
    void _initArray({
      required String referenceArgument,
      required Map<ColSize, int> map,
      required String argPrefix,
      required Function minMaxFct,
      int lowerBoundValue = 0,
      required int noValue,
      required int minMaxNoValueReference,
    }) {
      //
      // Identification of the defined "dimensions"
      //
      List<String> parts =
          referenceArgument.isEmpty
              ? []
              : referenceArgument
                  .toLowerCase()
                  .split(' ')
                  .where((t) => t.trim().isNotEmpty)
                  .toList();
      parts.forEach((String part) {
        ColSize.values.forEach((pfx) {
          final String prefix = '$argPrefix-${pfx.name}${pfx == ColSize.col0 ? "" : "-"}';
          if (part.startsWith(prefix)) {
            String valString = part.split(prefix).last;
            if (valString != prefix) {
              int? value = int.tryParse(valString);
              if (value != null && value < 13 && value > lowerBoundValue) {
                map[pfx] = minMaxFct(map[pfx], value);
              }
            }
          }
        });
      });

      //
      // As there might be holes, we need to re-adapt
      //
      for (int idx = 0; idx < nbPrefixes; idx++) {
        ColSize pfx = ColSize.values[idx];
        int? value = map[pfx];

        if (value == noValue) {
          //
          // No definition was found for this prefix
          //
          int i;

          //
          // Look for the nearest value in higher resolutions
          //
          for (i = idx + 1; i < nbPrefixes; i++) {
            ColSize pfx2 = ColSize.values[i];
            if (map[pfx2] != noValue) {
              value = map[pfx2]!;
              break;
            }
          }

          if (value == noValue) {
            //
            // Look for the nearest value in lower resolutions
            //
            for (int j = i - 1; j > -1; j--) {
              ColSize pfx3 = ColSize.values[j];
              if (map[pfx3] != noValue) {
                value = map[pfx3]!;
                break;
              }
            }
          }

          map[pfx] = minMaxFct(minMaxNoValueReference, value);
        }
      }
    }

    _initArray(
      referenceArgument: orders,
      map: orderPerSize,
      argPrefix: 'order',
      minMaxFct: math.max,
      noValue: -100,
      minMaxNoValueReference: 0,
    );
  }

  //
  // Returns the flex ratio % column's definition and available width of
  // the container
  //
  int _getFlexRatio(ColSize prefix) {
    return _ratiosPerSize[prefix]!;
  }

  //
  // Returns the leftMargin % column's definition and available width of
  // the container.  This corresponds to the offset-*
  //
  int _getLeftMarginRatio(ColSize prefix) {
    return _offsetsPerSize[prefix] ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        //
        // Get the prefix for the definition, based on the available width
        //
        ColSize pfx = bootstrapPrefixBasedOnWidth(
          absoluteSizes
              ? MediaQuery.of(context).size.width
              : constraints.maxWidth,
        );

        //
        // Check if invisible using ColSize.col0
        //
        if (pfx == ColSize.col0) {
          return Container();
        }

        //
        //
        // Get the flexible ratio
        //
        int flexRatio = _getFlexRatio(pfx);

        //
        // Get the margin-left (offset)
        //
        int leftMarginRatio = _getLeftMarginRatio(pfx);

        Widget widget = SizedBox(
          width: flexRatio * constraints.maxWidth * _oneColumnRatio,
          child: child,
        );

        if (leftMarginRatio > 0) {
          final double leftMargin =
              constraints.maxWidth * leftMarginRatio * _oneColumnRatio;
          widget = Padding(
            padding: EdgeInsets.only(left: leftMargin),
            child: widget,
          );
        }

        return widget;
      },
    );
  }
}

///
/// Helper Widget which defines whether its child is visible
/// depending on the parent container width and the rules
/// defined in [sizes]
///
class BootstrapVisibility extends StatelessWidget {
  BootstrapVisibility({required this.child, String sizes = ""})
    : this.sizes = sizes.trim() {
    _initialize();
  }

  ///
  /// The child to display (or not)
  ///
  final Widget child;

  ///
  /// Sizes
  ///
  /// corresponds to .col*
  /// If the 'col-*' that corresponds to the screen dimensions is present,
  /// the child is displayed.  Otherwise, the child is not displayed.
  ///
  final String sizes;

  //
  // Visibility per size, based on the column's definition
  //
  final Map<ColSize, bool> _visibilityPerSize = {
    ColSize.col12: false,
    ColSize.col10: false,
    ColSize.col8: false,
    ColSize.col6: false,
    ColSize.col0: false,
  };

  //
  // Defines the Flex ratios, based on the column's
  // definition, as well as the offsets
  //
  void _initialize() {
    //
    // Parsing of the rules
    //
    List<String> parts =
        sizes.isEmpty
            ? []
            : sizes
                .toLowerCase()
                .split(' ')
                .where((t) => t.trim().isNotEmpty)
                .toList();
    parts.forEach((String part) {
      ColSize.values.forEach((pfx) {
        final String prefix = 'col-${pfx.name}';
        if (part.startsWith(prefix) && pfx != ColSize.col0) {
          _visibilityPerSize[pfx] = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //
    // Get the prefix for the definition, based on the available width
    //
    ColSize pfx = bootstrapPrefixBasedOnWidth(MediaQuery.of(context).size.width);

    //
    // Check if it is visible
    //
    bool visible = _visibilityPerSize[pfx]!;

    if (visible == false) {
      return Container();
    }

    return child;
  }
}

///
/// Returns "something" based on the current dimensions
/// everything is related to browser window
///
/// Example:
/// something = bootStrapValueBasedOnSize(
///   {
///    "xl": "value for xl",
///    "lg": "value for lg",
///    "md": "value for md",
///    "sm": "value for sm",
///    "": "value for xs",
///   },
///   context: context,
/// )
///
/// If the sizes does not contain the corresponding browser prefix,
/// returns the nearest (upper first)
///
dynamic bootStrapValueBasedOnSize({
  required Map<ColSize, dynamic> sizes,
  required BuildContext context,
}) {
  //
  // Get the prefix for the definition, based on the available width
  //
  ColSize pfx = bootstrapPrefixBasedOnWidth(MediaQuery.of(context).size.width);

  final int nbPrefixes = ColSize.values.length;
  dynamic value;

  //
  // As there might be holes, we need to re-adapt
  //
  value = sizes[pfx];

  if (value == null) {
    //
    // No definition was found for this prefix
    //
    int i;
    int idx = ColSize.values.indexOf(pfx);

    //
    // Look for the nearest value in higher resolutions
    //
    for (i = idx + 1; i < nbPrefixes; i++) {
      ColSize pfx2 = ColSize.values[i];
      if (sizes[pfx2] != null) {
        value = sizes[pfx2];
        break;
      }
    }

    if (value == null) {
      //
      // Look for the nearest value in lower resolutions
      //
      for (int j = i - 1; j > -1; j--) {
        ColSize pfx3 = ColSize.values[j];
        if (sizes[pfx3] != null) {
          value = sizes[pfx3];
          break;
        }
      }
    }
  }

  return value;
}
