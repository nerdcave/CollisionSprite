# PESprite - cocos2d collision detection made easy
----------------------------------------------
PESprite is ideal when you need accurate collision detection between sprites but don't want a full, physics-driven, Box2d app.  It uses Box2d just for collision detection by using its collision methods directly; there's no need to setup a world, bodies, or contact listener.

Simply trace out your sprites using [**PhysicsEditor**](<http://
www.physicseditor.de>) and set their anchor points, create the sprites with PESprite, and just call **intersectsTarget:** with another PESprite to check for collision.

## Installation
----------------------------------------------
Nothing tricky, just drag the files in the **source** folder into your project and put
```objective-c
#import "PESprite.h"
```
at the top of whatever source file you want to use PESprite.

Since Box2d is required, your project must have been created as a cocos2d Box2d type. If it wasn't, you can just drag the **external/Box2d/Box2d** folder from the cocos2d source into your project's **libs** group.  Note, you want the **Box2d** **subfolder** in **external/Box2d**.  You may also need to rename your **.m** files to **.mm** if you get weird compilation errors.


## How to use
----------------------------------------------
Use PhysicsEditor to trace out your sprites and export the plist file.  **Important:** You must set each sprite's anchor point in PhysicsEditor itself because it will be used automatically by PESprite.  None of the other properties for your sprite in PhysicsEditor are relevant.

### Simplified code
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

## Details
----------------------------------------------
PESprite should be super easy to use but does have a few limitations.

### Features:
* Lightweight, no need to create any Box2d objects such as a world or bodies
* Supports PhysicsEditor polygons and circles
* Handles iPhone retina and iPad sprite sizing
* Supports sprite scaling

### To-do:
* iPad retina support
* Collision detection of rotated sprite
* Drawing the sprite's polygons to the screen for debugging purposes

## Example project
----------------------------------------------
The **PhysicsEditorSpriteTest** example project is both a **universal** application and supports the iPhone retina display.  When run on the iPad, it also loads the iPhone retina HD sprites by using the **UNIV()** macro, included in **PESpriteConfig.h**.  iPad Retina isn't supported yet.

It's important to note that the HD images are used in PhysicsEditor. Open the physicsEditorObjects.pes file in PhysicsEditor to check it out.


## Contact me
----------------------------------------------
Have questions or needs some help?  Feel free to email me <jay@nerdcave.com> or hit me up on the twitters: [@nerdcave](http://twitter.com/nerdcave).