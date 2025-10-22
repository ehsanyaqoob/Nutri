import 'dart:io';
import 'package:nutri/constants/export.dart';
class CommonImageView extends StatefulWidget {
  final String? url;
  final String? imagePath;
  final String? svgPath;
  final File? file;
  final double? height;
  final double? width;
  final double radius;
  final BoxFit fit;
  final Color? color;

  const CommonImageView({
    super.key,
    this.url,
    this.imagePath,
    this.svgPath,
    this.file,
    this.height,
    this.width,
    this.radius = 0.0,
    this.fit = BoxFit.cover,
    this.color,
  });

  @override
  State<CommonImageView> createState() => _CommonImageViewState();
}

class _CommonImageViewState extends State<CommonImageView> {
  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [FadeEffect(duration: const Duration(milliseconds: 500))],
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.radius),
          child: _buildImage(),
        ),
      ),
    );
  }

  Widget _buildImage() {
    // Priority 1: SVG Path
    if (widget.svgPath != null && widget.svgPath!.isNotEmpty) {
      return SvgPicture.asset(
        widget.svgPath!,
        height: widget.height,
        width: widget.width,
        fit: widget.fit,
        color: widget.color,
      );
    }

    // Priority 2: File
    if (widget.file != null && widget.file!.path.isNotEmpty) {
      return Image.file(
        widget.file!,
        height: widget.height,
        width: widget.width,
        fit: widget.fit,
        color: widget.color,
      );
    }

    // Priority 3: URL (Network Image)
    if (widget.url != null && widget.url!.isNotEmpty) {
      if (_isNetworkImage(widget.url!)) {
        return CachedNetworkImage(
          height: widget.height,
          width: widget.width,
          fit: widget.fit,
          imageUrl: widget.url!,
          color: widget.color,
          placeholder: (context, url) => _buildPlaceholder(),
          errorWidget: (context, url, error) => _buildErrorWidget(),
        );
      } else {
        // It's a local asset path
        return Image.asset(
          widget.url!,
          height: widget.height,
          width: widget.width,
          fit: widget.fit,
          color: widget.color,
          errorBuilder: (context, error, stackTrace) => _buildErrorWidget(),
        );
      }
    }

    // Priority 4: Image Path
    if (widget.imagePath != null && widget.imagePath!.isNotEmpty) {
      if (_isNetworkImage(widget.imagePath!)) {
        return CachedNetworkImage(
          height: widget.height,
          width: widget.width,
          fit: widget.fit,
          imageUrl: widget.imagePath!,
          color: widget.color,
          placeholder: (context, url) => _buildPlaceholder(),
          errorWidget: (context, url, error) => _buildErrorWidget(),
        );
      } else {
        return Image.asset(
          widget.imagePath!,
          height: widget.height,
          width: widget.width,
          fit: widget.fit,
          color: widget.color,
          errorBuilder: (context, error, stackTrace) => _buildErrorWidget(),
        );
      }
    }

    // Fallback: Placeholder
    return _buildErrorWidget();
  }

  Widget _buildPlaceholder() {
    return Container(
      height: widget.height,
      width: widget.width,
      color: kDynamicCard(context),
      child: Center(
        child: SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: kGreyColor,
            backgroundColor: Colors.grey.shade100,
          ),
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      height: widget.height,
      width: widget.width,
      color: kDynamicCard(context),
      child: Icon(
        Icons.image_not_supported_outlined,
        color: kDynamicIcon(context),
        size: 32,
      ),
    );
  }

  bool _isNetworkImage(String path) {
    return path.startsWith('http://') ||
        path.startsWith('https://') ||
        path.startsWith('www.') ||
        path.contains('.com') ||
        path.contains('.net') ||
        path.contains('.org');
  }
}

class CommonImageViewWithBorder extends StatelessWidget {
  String? url;
  String? imagePath;
  String? svgPath;
  File? file;
  double? height;
  double? width;
  double? radius;
  final BoxFit fit;
  final String placeHolder;

  CommonImageViewWithBorder({
    super.key,
    this.url,
    this.imagePath,
    this.svgPath,
    this.file,
    this.height,
    this.width,
    this.radius = 0.0,
    this.fit = BoxFit.cover,
    this.placeHolder = 'assets/images/no_image_found.png',
  });

  @override
  Widget build(BuildContext context) {
    return _buildImageView();
  }

  Widget _buildImageView() {
    if (svgPath != null && svgPath!.isNotEmpty) {
      return SizedBox(
        height: height,
        width: width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius!),
          child: SvgPicture.asset(
            svgPath!,
            height: height,
            width: width,
            fit: fit,
          ),
        ),
      );
    } else if (file != null && file!.path.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius!),
        child: Image.file(file!, height: height, width: width, fit: fit),
      );
    } else if (url != null && url!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius!),
        child: CachedNetworkImage(
          height: height,
          width: width,
          fit: fit,
          imageUrl: url!,
          placeholder: (context, url) => SizedBox(
            height: 23,
            width: 23,
            child: Center(
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: kGreyColor,
                  backgroundColor: Colors.grey.shade100,
                ),
              ),
            ),
          ),
          errorWidget: (context, url, error) =>
              Image.asset(placeHolder, height: height, width: width, fit: fit),
        ),
      );
    } else if (imagePath != null && imagePath!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius!),
        child: Image.asset(imagePath!, height: height, width: width, fit: fit),
      );
    }
    return SizedBox();
  }
}
