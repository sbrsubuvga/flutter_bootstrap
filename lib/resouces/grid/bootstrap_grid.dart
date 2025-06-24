
import 'package:flutter/material.dart';
import 'package:bootstrap_plus/resouces/models/bootstrap_col_size.dart';

import '../enums.dart';

double _oneColumnRatio = 0.083333;

///
/// Returns the definition prefix, based on the available width
///
BCol bootstrapPrefixBasedOnWidth(double width) {
  if (width > 1200) {
    return BCol.col12; // xl
  }
  if (width > 992) {
    return BCol.col10; // lg
  }
  if (width > 767) {
    return BCol.col8; // md
  }
  if (width > 575) {
    return BCol.col6; // sm
  }
  return BCol.col6; // xs
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
    if (fluid) {
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
        BCol pfx = bootstrapPrefixBasedOnWidth(constraints.maxWidth);

        //
        // We need to iterate through all the children and consider any potential order
        //
        List<BootstrapCol> myChildren = List.from(children);
        myChildren.sort(
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
            children: myChildren,
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
    this.sizes = GridCol.defaultSize,
    this.offsets = GridOffset.defaultSize,
    this.orders = GridOrder.defaultSize, // Changed from String to GridOrderSize
  }) {
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
  final GridCol sizes;

  ///
  /// Offsets (= number of columns) to push this Widget to the right
  ///
  /// Corresponds to the Bootstrap classes: .offset-*
  ///
  /// Example:
  ///   offsets: GridColSize(xs: ColSize.col0, sm: ColSize.col1, md: ColSize.col2)
  ///
  final GridOffset offsets;

  ///
  /// Sequence orders
  ///
  /// Corresponds to the Bootstrap classes: .order-*
  ///
  /// Example:
  ///   orders: GridOrderSize(xs: ColSize.col2, sm: ColSize.col2, md: ColSize.col1)
  ///
  final GridOrder orders; // Updated type

  ///
  /// Do we consider relative dimensions (based on the parent container)
  /// or absolute (based on the browser window)
  /// Default: relative = false
  ///
  final bool absoluteSizes;

  //
  // Flex ratios per size, based on the column's definition
  //
  final Map<BCol, int> _ratiosPerSize = {
    BCol.col12: 100,
    BCol.col10: 100,
    BCol.col8: 100,
    BCol.col6: 100,
    BCol.col0: 100,
  };

  //
  // Offsets per size, based on the column's definition
  //
  final Map<BCol, int> _offsetsPerSize = {
    BCol.col12: -100,
    BCol.col10: -100,
    BCol.col8: -100,
    BCol.col6: -100,
    BCol.col0: -100,
  };

  //
  // Sequence order per size, based on the column's definition
  //
  final Map<BCol, int> orderPerSize = {
    BCol.col12: 0,
    BCol.col10: 0,
    BCol.col8: 0,
    BCol.col6: 0,
    BCol.col0: 0,
  };

  //
  // Defines the Flex ratios, based on the column's
  // definition, as well as the offsets
  //
  void _initialize() {
    // Updated to use BootstarpColSize instead of parsing strings
    _ratiosPerSize[BCol.col12] = sizes.xl.value;
    _ratiosPerSize[BCol.col10] = sizes.lg.value;
    _ratiosPerSize[BCol.col8] = sizes.md.value;
    _ratiosPerSize[BCol.col6] = sizes.sm.value;
    _ratiosPerSize[BCol.col0] = sizes.xs.value;

    _offsetsPerSize[BCol.col12] = offsets.xl.value;
    _offsetsPerSize[BCol.col10] = offsets.lg.value;
    _offsetsPerSize[BCol.col8] = offsets.md.value;
    _offsetsPerSize[BCol.col6] = offsets.sm.value;
    _offsetsPerSize[BCol.col0] = offsets.xs.value;

    //
    // Initialize orderPerSize using GridOrderSize
    //
    orderPerSize[BCol.col12] = orders.xl.value;
    orderPerSize[BCol.col10] = orders.lg.value;
    orderPerSize[BCol.col8] = orders.md.value;
    orderPerSize[BCol.col6] = orders.sm.value;
    orderPerSize[BCol.col0] = orders.xs.value;
  }

  //
  // Returns the flex ratio % column's definition and available width of
  // the container
  //
  int _getFlexRatio(BCol prefix) {
    return _ratiosPerSize[prefix]!;
  }

  //
  // Returns the leftMargin % column's definition and available width of
  // the container.  This corresponds to the offset-*
  //
  int _getLeftMarginRatio(BCol prefix) {
    return _offsetsPerSize[prefix] ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        //
        // Get the prefix for the definition, based on the available width
        //
        BCol pfx = bootstrapPrefixBasedOnWidth(
          absoluteSizes
              ? MediaQuery.of(context).size.width
              : constraints.maxWidth,
        );

        //
        // Check if invisible using ColSize.col0
        //
        if (pfx == BCol.col0) {
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
  BootstrapVisibility({super.key, required this.child, String sizes = ""})
    : sizes = sizes.trim() {
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
  final Map<BCol, bool> _visibilityPerSize = {
    BCol.col12: false,
    BCol.col10: false,
    BCol.col8: false,
    BCol.col6: false,
    BCol.col0: false,
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
    for (var part in parts) {
      for (var pfx in BCol.values) {
        final String prefix = 'col-${pfx.name}';
        if (part.startsWith(prefix) && pfx != BCol.col0) {
          _visibilityPerSize[pfx] = true;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //
    // Get the prefix for the definition, based on the available width
    //
    BCol pfx = bootstrapPrefixBasedOnWidth(MediaQuery.of(context).size.width);

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
  required Map<BCol, dynamic> sizes,
  required BuildContext context,
}) {
  //
  // Get the prefix for the definition, based on the available width
  //
  BCol pfx = bootstrapPrefixBasedOnWidth(MediaQuery.of(context).size.width);

  final int nbPrefixes = BCol.values.length;
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
    int idx = BCol.values.indexOf(pfx);

    //
    // Look for the nearest value in higher resolutions
    //
    for (i = idx + 1; i < nbPrefixes; i++) {
      BCol pfx2 = BCol.values[i];
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
        BCol pfx3 = BCol.values[j];
        if (sizes[pfx3] != null) {
          value = sizes[pfx3];
          break;
        }
      }
    }
  }

  return value;
}
