//
//  HelloWorldLayer.h
//  PhysicsEditorSpriteTest
//
//  Created by Jay Elaraj on 5/15/12.
//  Copyright nerdcave.com 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Box2D.h"
#import "GLES-Render.h"


@class PESprite;

@interface HelloWorldLayer : CCLayer
{
	PESprite		*selectedSprite;
	CCLabelBMFont	*infoLabel;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
