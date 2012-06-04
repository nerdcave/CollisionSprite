//
//  PESprite.mm
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


#import "PESprite.h"

@interface PESprite (PrivateMethods)

-(void) updateB2Transform;

@end


@implementation PESprite

@synthesize fixtureDef;
@synthesize box2dTransform;
@synthesize physicsEditorName;
@synthesize scaleInWorld;


+(b2Vec2) ptmScaledWithPosition:(CGPoint)position scale:(CGFloat)scale {
	return b2Vec2(position.x / (PTM_RATIO_SCALED * scale), position.y / (PTM_RATIO_SCALED * scale));
}

// correct initializer when subclassing CCSprite (http://www.cocos2d-iphone.org/wiki/doku.php/prog_guide:sprites#how_to_subclass_sprites)
-(id) initWithTexture:(CCTexture2D*)texture rect:(CGRect)rect {
	if ( (self = [super initWithTexture:texture rect:rect]) ) {
		box2dTransform = new b2Transform;
		self.scaleInWorld = 1;
	}
	return self;
}

// when the physicsEditorName property is set, set the anchor point and read the fixtures
-(void) setPhysicsEditorName:(NSString *)_physicsEditorName {
	[physicsEditorName release];
	physicsEditorName = [_physicsEditorName copy];
	GB2ShapeCache* shapeCache = [GB2ShapeCache sharedShapeCache];
	if ([shapeCache shapeExists:physicsEditorName]) {
		self.anchorPoint = [shapeCache anchorPointForShape:physicsEditorName];
		fixtureDef = [shapeCache fixturesForShape:physicsEditorName];
	}
}

// updates the transform to the sprite's current position
-(void) updateB2Transform {
	box2dTransform->Set([PESprite ptmScaledWithPosition:self.positionInWorldInPixels scale:self.scaleInWorld], 0.0f);
}

// useful to override in subclasses
-(BOOL) isActive {
	return self.visible;
}

// hit test bounding rects only
-(BOOL) intersectsRectTarget:(PESprite*)target {
	return CGRectIntersectsRect([self boundingBoxInWorld], [target boundingBoxInWorld]);
}

// hit test self and target polygons
-(BOOL) intersectsTarget:(PESprite*)target testRectIntersection:(BOOL)testRectIntersection {
	if (!fixtureDef || self == target || ![self isActive] || ![target isActive]) {
		return NO;
	}

	// if rects miss, no need to check polys
	if (testRectIntersection && ![self intersectsRectTarget:target]) {
		return NO;
	}

	[self updateB2Transform];
	[target updateB2Transform];

	for (FixtureDef *fixtureDefs = fixtureDef; fixtureDefs; fixtureDefs = fixtureDefs->next) {
		for (FixtureDef *targetFixtureDefs = target.fixtureDef; targetFixtureDefs; targetFixtureDefs = targetFixtureDefs->next) {
			b2Manifold manifold;

			b2Shape::Type sourceType = fixtureDefs->fixture.shape->m_type;
			b2Shape::Type targetType = targetFixtureDefs->fixture.shape->m_type;
			switch (sourceType) {
				case b2Shape::e_polygon:
					if (targetType == b2Shape::e_polygon) {
						// poly poly
						b2CollidePolygons(&manifold, (b2PolygonShape*)targetFixtureDefs->fixture.shape, *target.box2dTransform, (b2PolygonShape*)fixtureDefs->fixture.shape, *self.box2dTransform);
					} else if (targetType == b2Shape::e_circle) {
						// poly circle
						b2CollidePolygonAndCircle(&manifold, (b2PolygonShape*)fixtureDefs->fixture.shape, *self.box2dTransform, (b2CircleShape*)targetFixtureDefs->fixture.shape, *target.box2dTransform);
					}
					break;

				case b2Shape::e_circle:
					if (targetType == b2Shape::e_polygon) {
						// circle poly
						b2CollidePolygonAndCircle(&manifold, (b2PolygonShape*)targetFixtureDefs->fixture.shape, *target.box2dTransform, (b2CircleShape*)fixtureDefs->fixture.shape, *self.box2dTransform);
					} else if (targetType == b2Shape::e_circle) {
						// circle circle
						b2CollideCircles(&manifold, (b2CircleShape*)targetFixtureDefs->fixture.shape, *target.box2dTransform, (b2CircleShape*)fixtureDefs->fixture.shape, *self.box2dTransform);
					}
					break;

				default:
					break;
			}

			if (manifold.pointCount > 0) {
				return YES;
			}
		}
	}

	return NO;
}

// hit test self and target polygons; check the bounding rects by default
-(BOOL) intersectsTarget:(PESprite*)target {
	return [self intersectsTarget:target testRectIntersection:YES];
}


-(void) dealloc {
	[physicsEditorName release];
	delete box2dTransform;
	[super dealloc];
}

@end


@implementation GB2ShapeCache (GB2ShapeCache_Helpers)

-(FixtureDef*) fixturesForShape:(NSString*)shape {
	BodyDef *bd = [shapeObjects_ objectForKey:shape];
	assert(bd);
	return bd->fixtures;
}

-(BOOL) shapeExists:(NSString*)shape {
	return !![shapeObjects_ objectForKey:shape];
}

@end


// these are generic enough to just extend CCNode
@implementation CCNode (PESprite_Helpers)

-(CGRect) boundingBoxInWorld {
	CGPoint worldPosition = self.positionInWorld;
	CGRect box = [self boundingBox];
	box.origin = ccp(worldPosition.x - box.size.width * self.anchorPoint.x, worldPosition.y - box.size.height * self.anchorPoint.y);
	return box;
}

-(CGPoint) positionInWorld {
	return [self.parent convertToWorldSpace:self.position];
}

-(CGPoint) positionInWorldInPixels {
	return ccpMult([self.parent convertToWorldSpace:self.position], CC_CONTENT_SCALE_FACTOR());
}

@end