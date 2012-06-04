//
//  PESprite.h
//  Extension for CCSprite when you need polygonal collision detection.
//
//  Copyright 2012, Jay Elaraj
//		http://nerdcave.com
//
//  All rights reserved.
//
//	Released under the MIT license.
//
//	Uses PhysicsEditor by Andreas Loew
//		http://www.codeandweb.com/physicseditor
//

#import "cocos2d.h"
#import "Box2D.h"
#import "GB2ShapeCache.h"


#define PTM_RATIO					32
#define IS_IPAD()					(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IPAD_SCALE()				(IS_IPAD() ? 2: 1)
#define PTM_RATIO_SCALED			(PTM_RATIO * CC_CONTENT_SCALE_FACTOR() * IPAD_SCALE())

// expose a few of GB2ShapeCache's inner classes; not ideal, but works for now
class FixtureDef {
public:
    FixtureDef *next;
    b2FixtureDef fixture;
};

@interface BodyDef : NSObject {
@public
    FixtureDef *fixtures;
    CGPoint anchorPoint;
}
@end


@interface PESprite : CCSprite {
	b2Transform		*box2dTransform;
	FixtureDef		*fixtureDef;
	NSString*		physicsEditorName;
	CGFloat			scaleFactor;
}

@property (nonatomic, readonly) FixtureDef		*fixtureDef;
@property (nonatomic, readonly) b2Transform		*box2dTransform;
@property (nonatomic, copy) NSString			*physicsEditorName;

// set scaleInWorld if self or parent scale != 1
// future rev might calculate this on the fly, but more efficient to set explicitly for now
@property (nonatomic, assign) CGFloat			scaleInWorld;

-(BOOL) isActive;
-(BOOL) intersectsTarget:(PESprite*)target testRectIntersection:(BOOL)testRectIntersection;
-(BOOL) intersectsTarget:(PESprite*)target;
-(BOOL) intersectsRectTarget:(PESprite*)target;

@end


@interface GB2ShapeCache (GB2ShapeCache_Helpers)

-(FixtureDef*) fixturesForShape:(NSString*)shape;
-(BOOL) shapeExists:(NSString*)shape;

@end


@interface CCNode (PESprite_Helpers)

-(CGPoint) positionInWorld;
-(CGPoint) positionInWorldInPixels;
-(CGRect) boundingBoxInWorld;

@end
