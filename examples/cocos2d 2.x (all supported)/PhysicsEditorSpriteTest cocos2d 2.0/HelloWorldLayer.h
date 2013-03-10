//
//  HelloWorldLayer.h
//  PhysicsEditorSpriteTest
//
//  Created by Jay Elaraj on 5/15/12.
//  Copyright nerdcave.com 2012. All rights reserved.
//


#import "cocos2d.h"

@class CollisionSprite;

@interface HelloWorldLayer : CCLayer
{
	CollisionSprite	*selectedSprite;
	CCLabelBMFont	*infoLabel;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
