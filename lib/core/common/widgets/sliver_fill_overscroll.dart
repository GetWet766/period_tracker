import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SliverFillOverscroll extends SingleChildRenderObjectWidget {
  const SliverFillOverscroll({
    required Widget child,
    super.key,
  }) : super(child: child);

  @override
  RenderSliverFillOverscroll createRenderObject(BuildContext context) {
    return RenderSliverFillOverscroll();
  }
}

class RenderSliverFillOverscroll extends RenderSliverSingleBoxAdapter {
  @override
  void performLayout() {
    if (child == null) {
      geometry = SliverGeometry.zero;
      return;
    }

    // 1. First, layout the child loosely to get its natural (intrinsic) size.
    //    We need to know how big the content *wants* to be.
    child!.layout(constraints.asBoxConstraints(), parentUsesSize: true);
    final childExtent = constraints.axis == Axis.vertical
        ? child!.size.height
        : child!.size.width;

    final viewportExtent = constraints.viewportMainAxisExtent;

    // 2. Calculate the "target" extent.
    //    Start with the child's natural size.
    var targetExtent = childExtent;

    // 3. Logic: If the visible scroll window extends BEYOND the child's natural bottom,
    //    we are in an "overscroll" or "fill remaining" state.
    //    We calculate the required size to reach the bottom of the viewport.

    //    'constraints.scrollOffset' is the position of the viewport top relative to this sliver.
    //    'constraints.scrollOffset + viewportExtent' is the position of the viewport bottom.
    final visibleBottom = constraints.scrollOffset + viewportExtent;

    if (visibleBottom > childExtent) {
      // We have extra space (either because content < viewport OR we are overscrolling).
      // Force the child to stretch to this new size.
      targetExtent = visibleBottom;
    }

    // 4. Re-layout the child with the forced strict size.
    child!.layout(
      constraints.asBoxConstraints(
        minExtent: targetExtent,
        maxExtent: targetExtent,
      ),
      parentUsesSize: true,
    );

    // 5. Calculate Paint Extent
    //    How much screen space does this sliver actually occupy right now?
    //    It is the overlapping part of the targetExtent and the viewport.
    final paintExtent = calculatePaintOffset(
      constraints,
      from: 0,
      to: targetExtent,
    );

    // 6. Define Geometry
    //    CRITICAL: We report 'scrollExtent' as the ORIGINAL 'childExtent'.
    //    If we reported 'targetExtent', the ScrollController would think the list
    //    actually grew, preventing the "spring back" effect.
    //    We want the physics to think the list ends at 'childExtent', but visually paint 'targetExtent'.
    geometry = SliverGeometry(
      scrollExtent: childExtent,
      paintExtent: paintExtent,
      maxPaintExtent: targetExtent,
      hasVisualOverflow: targetExtent > childExtent,
    );
  }
}
