//
//  PESprite.h
//  Replacement for CCSprite when you need polygonal collision detection.
//
//  Copyright 2012, Jay Elaraj
//		http://nerdcave.com
//
//	Uses PhysicsEditor by Andreas Loew
//		http://www.PhysicsEditor.de
//
//  All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//  
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "cocos2d.h"
#import "Box2D.h"

#import "GB2ShapeCache.h"
#import "PESpriteConfig.h"


@interface PESprite : CCSprite {
    b2Transform		*box2dTransform;
    FixtureDef		*fixtureDef;
	NSString*		physicsEditorName;
	CGFloat			scaleFactor;
}

@property (nonatomic, readonly) FixtureDef*		fixtureDef;
@property (nonatomic, readonly) b2Transform*	box2dTransform;
@property (nonatomic, copy) NSString*			physicsEditorName;

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
