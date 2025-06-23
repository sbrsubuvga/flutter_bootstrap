import 'package:bootstrap_plus/resouces/enums.dart';

class GridCol {
  final BCol xs;
  final BCol sm;
  final BCol md;
  final BCol lg;
  final BCol xl;

  const GridCol({
    BCol? xs,
    BCol? sm,
    BCol? md,
    BCol? lg,
    BCol? xl,
    BCol col = BCol.col12,
  }) : xs = xs ?? col,
       sm = sm ?? col,
       md = md ?? col,
       lg = lg ?? col,
       xl = xl ?? col;

  static const GridCol defaultSize = GridCol();

  @override
  String toString() {
    return 'BootstarpColSize(xs: $xs, sm: $sm, md: $md, lg: $lg, xl: $xl)';
  }
}

class GridOffset {
  final BCol xs;
  final BCol sm;
  final BCol md;
  final BCol lg;
  final BCol xl;

  const GridOffset({
    BCol? xs,
    BCol? sm,
    BCol? md,
    BCol? lg,
    BCol? xl,
    BCol col = BCol.col0,
  }) : xs = xs ?? col,
       sm = sm ?? col,
       md = md ?? col,
       lg = lg ?? col,
       xl = xl ?? col;

  static const GridOffset defaultSize = GridOffset();

  @override
  String toString() {
    return 'BootstarpColSize(xs: $xs, sm: $sm, md: $md, lg: $lg, xl: $xl)';
  }
}

class GridOrder {
  final BCol xs;
  final BCol sm;
  final BCol md;
  final BCol lg;
  final BCol xl;

  const GridOrder({
    BCol? xs,
    BCol? sm,
    BCol? md,
    BCol? lg,
    BCol? xl,
    BCol col = BCol.col12,
  }) : xs = xs ?? col,
       sm = sm ?? col,
       md = md ?? col,
       lg = lg ?? col,
       xl = xl ?? col;

  static const GridOrder defaultSize = GridOrder();

  @override
  String toString() {
    return 'GridOrderSize(xs: $xs, sm: $sm, md: $md, lg: $lg, xl: $xl)';
  }
}
