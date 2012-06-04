# PESprite - cocos2d collision detection made easy
PESprite is a CCSprite extension for cocos2d that supports collision detection.  It's ideal when you need accurate collision detection between sprites but don't want a full, physics-driven, Box2D app.  It uses Box2D's collision methods directly so there's no need to create a world, bodies, or contact listener.

Simply trace out your (low-res) sprites using [PhysicsEditor](<http://www.codeandweb.com/physicseditor>), create your sprites as PESprite objects, and call **intersectsTarget:** to check for collision.

## Installing
First, your project must have Box2D included.  If it doesn't, you may have to create a new cocos2d Box2D project type and copy your existing source into it.

Clone the repo:

	git clone git://github.com/nerdcave/PESprite.git
	cd PESprite
	open .

Then just drag the files from this repo's **source** folder into your project and put this at the top of whatever source file you want to use PESprite:
```objective-c
#import "PESprite.h"
```

If you try to compile and get an **Apple Mach-O Linker (Id) Error**, follow these steps:
* Go to your project configuration and click on your project under TARGETS
* Click Build Phases
* Expand the Compile Sources option and scroll to the bottom
* Click the + button and add PESprite.mm and GB2ShapeCache.mm
* Recompile

## How to use
* Use [PhysicsEditor](<http://www.codeandweb.com/physicseditor>) to trace out the **lowest resolution** sprites used in your project.  It's important to use your low-res sprites to ensure PESprite works properly.
* Set each sprite's **anchor point** in PhysicsEditor, which will be used automatically by PESprite.  Ignore the other properties.
* Set PhysicsEditor's Exporter to "Box2D generic (PLIST)" and export the plist file to your Resources folder.
* Then just write some code…

### Simplified example:
```objective-c
// load the shape data created by PhysicsEditor
[[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"data/physicsEditorObjects.plist"];

// create your sprite
PESprite *ship = [PESprite spriteWithFile:@"images/spaceship.png"];
// set they physicsEditorName property to its shape name specified in PhysicsEditor
ship.physicsEditorName = @"spaceship";
...

PESprite *satellite = [PESprite spriteWithFile:@"images/satellite.png"];
satellite.physicsEditorName = @"satellite";
...

if ([ship intersectsTarget:satellite]) {
	NSLog(@"hit!");
}
```
## Example projects
This repo's **examples** folder contains two example projects that allow you to drag around sprites to test for collisions. Both are universal apps, so they will display full screen on the iPhone and iPad.

### examples/cocos2d 1.x (no iPad retina)
* Uses cocos2d 1.x, so this project works for the iPhone, retina-enabled iPhone, and non-retina iPad; the new iPad retina display is not supported.
* HD images are included and displayed for the retina iPhone and non-retina iPad.
* PESprite will handle all cases automatically.

### examples/cocos2d 2.x (all supported)
* Uses cocos2d 2.x, so this project works for everything (non-retina and retina iPhone and iPad).
* The non-retina iPad will use the -hd images while the iPad retina will use the -ipadhd images.
* PESprite will handle all cases automatically.

## Details
PESprite's features and to-dos are outlined below.
### Requires:
* cocos2d project with Box2D included (<http://www.cocos2d-iphone.org/>)
* PhysicsEditor (<http://www.codeandweb.com/physicseditor>)

### Features:
* Lightweight, easy to use
* Supports PhysicsEditor polygons and circles
* Handles iPhone retina and iPad sprite sizing
* Supports sprite scaling (set the **scaleInWorld** property)
* No need to create any Box2D objects such as world, bodies, etc

### To-do:
* Handle sprite rotation
* Draw the polygons to the screen for debugging

## Contact me
Have questions or needs some help?  Feel free to email me: <jay@nerdcave.com> or hit me up on the twitters: [@nerdcave](http://twitter.com/nerdcave).