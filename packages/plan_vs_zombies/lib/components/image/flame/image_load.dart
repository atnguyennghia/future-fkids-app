import 'package:flame/components.dart';

class ImageLoad extends SpriteComponent with HasGameRef {
  var image;
  var positionX = 0.0, positionY = 0.0;
  @override
  var width = 0.0, height = 0.0;
  var level = 1;
  ImageLoad(this.positionX, this.positionY, this.width, this.height, this.image,
      this.level)
      : super(size: Vector2(width, height));

  @override
  Future<void> onLoad() async {
    super.onLoad();
    // TODO 1
    sprite = await gameRef.loadSprite(image);
    anchor = Anchor.center;
    position = Vector2(positionX, positionY);
    priority = level;
  }
}
