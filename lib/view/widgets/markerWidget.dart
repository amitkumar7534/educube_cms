import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:educube1/const/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../const/app_colors.dart';


extension ToBitDescription on Widget {
  Future<BitmapDescriptor> toBitmapDescriptor({Size? logicalSize, Size? imageSize, Duration waitToRender = const Duration(milliseconds: 300), TextDirection textDirection = TextDirection.ltr}) async {
    final widget = RepaintBoundary(
      child: MediaQuery(data: const MediaQueryData(), child: Directionality(textDirection: TextDirection.ltr, child: this)),
    );
    final pngBytes = await createImageFromWidget(widget, waitToRender: waitToRender, logicalSize: logicalSize, imageSize: imageSize);
    return BitmapDescriptor.fromBytes(pngBytes);
  }
}

/// Creates an image from the given widget by first spinning up a element and render tree,
/// wait [waitToRender] to render the widget that take time like network and asset images

/// The final image will be of size [imageSize] and the the widget will be layout, ... with the given [logicalSize].
/// By default Value of  [imageSize] and [logicalSize] will be calculate from the app main window

Future<Uint8List> createImageFromWidget(Widget widget, {Size? logicalSize, required Duration waitToRender, Size? imageSize}) async {
  final RenderRepaintBoundary repaintBoundary = RenderRepaintBoundary();
  final view = ui.PlatformDispatcher.instance.views.first;
  logicalSize ??= view.physicalSize / view.devicePixelRatio;
  imageSize ??= view.physicalSize;

  // assert(logicalSize.aspectRatio == imageSize.aspectRatio);

  final RenderView renderView = RenderView(
    view: view,
    child: RenderPositionedBox(alignment: Alignment.center, child: repaintBoundary),
    configuration: ViewConfiguration(
      // size: logicalSize,
        devicePixelRatio: 1.0,
        logicalConstraints: BoxConstraints(
            minWidth: logicalSize.width,
            minHeight: logicalSize.height,
            maxHeight: logicalSize.height,
            maxWidth: logicalSize.width
        )
    ),
  );

  final PipelineOwner pipelineOwner = PipelineOwner();
  final BuildOwner buildOwner = BuildOwner(focusManager: FocusManager());

  pipelineOwner.rootNode = renderView;
  renderView.prepareInitialFrame();

  final RenderObjectToWidgetElement<RenderBox> rootElement = RenderObjectToWidgetAdapter<RenderBox>(
    container: repaintBoundary,
    child: widget,
  ).attachToRenderTree(buildOwner);

  buildOwner.buildScope(rootElement);

  await Future.delayed(waitToRender);

  buildOwner.buildScope(rootElement);
  buildOwner.finalizeTree();

  pipelineOwner.flushLayout();
  pipelineOwner.flushCompositingBits();
  pipelineOwner.flushPaint();

  final ui.Image image = await repaintBoundary.toImage(pixelRatio: imageSize.width / logicalSize.width);
  final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  return byteData!.buffer.asUint8List();
}


Future<BitmapDescriptor> getCustomMarkerIcon(String url) async {
  const double size = 55;
  const double imageSize = size -25;

  return SizedBox(
    // height: 100,
    // width: 100,
    height: size,
    width: size,
    child: Stack(
      alignment: Alignment.topCenter,
      children: [


        Image.asset(AppIcons.customPin, width: size, height: size,color: AppColors.colorBlue,),
        // const ImageView(url: AppIcons.markerPinOrange,size: 24,),
        // Container(
        //   width: 37,
        //   height: 25,
        //   padding: const EdgeInsets.all(5),
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(10),
        //     color: AppColors.orange,
        //   ),
        //   alignment: Alignment.center,
        //   child: Text(value,style: 12.txtMediumWhite,),
        // )

        Positioned(
          top: 5,
            child: SizedBox(child: Container(
              height: imageSize,
              width:  imageSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(imageSize/2)
              ),
              clipBehavior: Clip.hardEdge,
               child:  Image.network(url, width: 45, height: 45)
            )


            // Image.asset(AppIcons.customPin, width: 45, height: 45,color: AppColors.white,)

            )),

      ],
    ),
  ).toBitmapDescriptor();



  // Container(
  //   color: Colors.red,
  //   height: 50,
  //   width: 50,
  //   child: Text(value),
  // ).toBitmapDescriptor();
}