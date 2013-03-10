//
//  HelloWorldLayer.mm
//  CollisionSpriteTest
//
//  Created by Jay Elaraj on 5/15/12.
//  Copyright nerdcave.com 2012. All rights reserved.
//


#import "HelloWorldLayer.h"
#import "CollisionSprite.h"

@implementation HelloWorldLayer

+(CCScene *) scene {
	CCScene *scene = [CCScene node];
	HelloWorldLayer *layer = [HelloWorldLayer node];
	[scene addChild: layer];
	return scene;
}


// puts -hd suffix on filename if iPad; only used for cocos2d 1.x since it's handled in 2.x
#define UNIV(__f__)		(IS_IPAD() ? [__f__ stringByReplacingCharactersInRange:[__f__ rangeOfString:@"." options:NSBackwardsSearch] withString:@"-hd."]: __f__)

// multiplies by 2 if iPad
#define ccp_IPAD(__x__, __y__)	(ccpMult(ccp(__x__, __y__), IPAD_SCALE()))

-(id) init {
	if( (self = [super init]) ) {

		// enable touch
		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];

		// load the shape data created by PhysicsEditor
		[[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"data/physicsEditorObjects.plist"];

		// create a CollisionSprite just as you would a CCSprite
		// UNIV() macro will force the -hd version of the image if this is being run on the iPad
		CollisionSprite *ship = [CollisionSprite spriteWithFile:UNIV(@"images/spaceship.png")];
		// important!!! set the physicsEditorName property to its shape name specified in PhysicsEditor
		[ship setPhysicsEditorName:@"spaceship"];

		[self addChild:ship];
		ship.position = ccp_IPAD(400, 100);

		CollisionSprite *satellite = [CollisionSprite spriteWithFile:UNIV(@"images/satellite.png")];
		[satellite setPhysicsEditorName:@"satellite"];
		[self addChild:satellite];
		satellite.position = ccp_IPAD(100, 100);

		CollisionSprite *chair = [CollisionSprite spriteWithFile:UNIV(@"images/chair.png")];
		[chair setPhysicsEditorName:@"chair"];
		[self addChild:chair];
		chair.position = ccp_IPAD(100, 260);

		CollisionSprite *earth = [CollisionSprite spriteWithFile:UNIV(@"images/earth.png")];
		[earth setPhysicsEditorName:@"earth"];
		[self addChild:earth];
		earth.position = ccp_IPAD(450, 260);

		CGSize winSize = [[CCDirector sharedDirector] winSize];
		infoLabel = [CCLabelTTF labelWithString:@"Drag images to test collisions" fontName:@"Arial" fontSize:30];
		infoLabel.anchorPoint = ccp(.5, 0);
		infoLabel.position = ccp(winSize.width / 2, 0);
		[infoLabel setColor:ccWHITE];
		[self addChild:infoLabel];
	}
	return self;
}


-(void) checkSelectedSpriteCollision {
	CCNode *node = nil;
	BOOL hit = NO;
	CCARRAY_FOREACH([self children], node) {
		if (selectedSprite != node && [node isKindOfClass:[CollisionSprite class]]) {
			CollisionSprite *sprite = (CollisionSprite*)node;
			// test for intersection
			if ([selectedSprite intersectsTarget:sprite]) {
				[infoLabel setString:[NSString stringWithFormat:@"%@ and %@ HIT!", selectedSprite.physicsEditorName, sprite.physicsEditorName]];
				hit = YES;
			}
		}
	}
	if (!hit) {
		[infoLabel setString:@""];
	}
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {    
	CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
	CCNode *node = nil;
	CCARRAY_FOREACH([self children], node) {
		if (CGRectContainsPoint(node.boundingBox, touchLocation)) {
			if ([node isKindOfClass:[CollisionSprite class]]) {
				selectedSprite = (CollisionSprite*)node;
				break;
			}
		}
	}    
	return YES;    
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {       
	CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
	CGPoint prevTouchLocation = [touch previousLocationInView:touch.view];
	prevTouchLocation = [[CCDirector sharedDirector] convertToGL:prevTouchLocation];
	prevTouchLocation = [self convertToNodeSpace:prevTouchLocation];

	CGPoint touchDiff = ccpSub(touchLocation, prevTouchLocation);
	selectedSprite.position = ccpAdd(selectedSprite.position, touchDiff);
	[self checkSelectedSpriteCollision];
}



-(void) dealloc {
	[super dealloc];
}

@end
