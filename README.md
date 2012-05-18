# PESprite - cocos2d collision detection made easy
PESprite is a CCSprite replacement for cocos2d that supports collision detection.  It's ideal when you need accurate collision detection between sprites but don't want a full, physics-driven, Box2D app.  It uses Box2D's collision methods directly so there's no need to create a world, bodies, or contact listener.

Simply trace out your (low-res) sprites using [PhysicsEditor](<http://www.physicseditor.de>), create your sprites as PESprite objects, and call **intersectsTarget:** to check for collision.

## Installing
Just drag the files from this repo's **source** folder into your project and put
```objective-c
#import "PESprite.h"
```
at the top of whatever source file you want to use PESprite.  Your project must have Box2D included.

## How to use
* Use [PhysicsEditor](<http://www.physicseditor.de>) to trace out the **lowest resolution** sprites used in your project.  It's important to use your low-res sprites to ensure PESprite works properly.
* Set each sprite's **anchor point** in PhysicsEditor, which will be used automatically by PESprite.  Ignore the other properties.
* Set PhysicsEditor's Exporter to "Box2D generic (PLIST)" and export the plist file to your Resources folder
* Then just write the code…

### Simplified example:
```objective-c
// load the shape data created by PhysicsEditor
[[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"data/physicsEditorObjects.plist"];

// create your sprite
PESprite *ship = [PESprite spriteWithFile:@"images/spaceship.png"];
// set this property to its shape name in PhysicsEditor
ship.physicsEditorName = @"spaceship";
...

PESprite *satellite = [PESprite spriteWithFile:@"images/satellite.png"];
satellite.physicsEditorName = @"satellite";
...

if ([ship intersectsTarget:satellite]) {
	NSLog(@"hit!");
}
```
## Example project
**PhysicsEditorSpriteTest** is located in this repo's example folder and demonstrates the following:

* Drag around PESprite objects to test for collisions.
* Universal application, so it displays full screen on both the iPhone and iPad.
* Retina-enabled for the iPhone, so HD images are included and displayed when appropriate.  PESprite will handle each case automatically.
* When run on the iPad, it will display the project's HD images by using the **UNIV()** macro, included in PESpriteConfig.h.

Note: iPad Retina isn't supported yet.

## Details
PESprite's features and limitations are outlined below.
### Requires:
* cocos2d project with Box2D included (<http://www.cocos2d-iphone.org/>)
* PhysicsEditor (<http://www.physicseditor.de>)

### Features:
* Lightweight, easy to use
* Supports PhysicsEditor polygons and circles
* Handles iPhone retina and iPad sprite sizing
* Supports sprite scaling
* No need to create any Box2D objects (world, bodies, etc)

### To-do:
* iPad retina support (example project would require ugprading its cocos2d source)
* Collision detection of rotated sprite
* Drawing the polygons to the screen for debugging

## Contact me
Have questions or needs some help?  Feel free to email me <jay@nerdcave.com> or hit me up on the twitters: [@nerdcave](http://twitter.com/nerdcave).