import 'package:bootstrap_plus/resouces/enums.dart';

class GridColSize {
  final ColSize xs;
  final ColSize sm;
  final ColSize md;
  final ColSize lg;
  final ColSize xl;


  const GridColSize({
    ColSize? xs ,
    ColSize? sm ,
    ColSize? md ,
    ColSize? lg ,
    ColSize? xl ,
    ColSize col=ColSize.col12
  }):
    xs = xs ?? col,
    sm = sm ?? col,
    md = md ?? col,
    lg = lg ?? col,
    xl = xl ?? col;

  static const GridColSize defaultSize = GridColSize();

  @override
  String toString() {
    return 'BootstarpColSize(xs: $xs, sm: $sm, md: $md, lg: $lg, xl: $xl)';
  }
}


class GridOffsetSize {
  final ColSize xs;
  final ColSize sm;
  final ColSize md;
  final ColSize lg;
  final ColSize xl;


  const GridOffsetSize({
    this.xs = ColSize.col0,
    this.sm = ColSize.col0,
    this.md = ColSize.col0,
    this.lg = ColSize.col0,
    this.xl = ColSize.col0,
  });

  static const GridOffsetSize defaultSize = GridOffsetSize();

  @override
  String toString() {
    return 'BootstarpColSize(xs: $xs, sm: $sm, md: $md, lg: $lg, xl: $xl)';
  }
}

class GridOrderSize {
  final int xs;
  final int sm;
  final int md;
  final int lg;
  final int xl;

  const GridOrderSize({
    this.xs = 0,
    this.sm = 0,
    this.md = 0,
    this.lg = 0,
    this.xl = 0,
  });

  static const GridOrderSize defaultSize = GridOrderSize();

  @override
  String toString() {
    return 'GridOrderSize(xs: $xs, sm: $sm, md: $md, lg: $lg, xl: $xl)';
  }
}