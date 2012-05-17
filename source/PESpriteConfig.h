//
//  PESpriteConfig.h
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

#define PTM_RATIO					32

// size factor of images in PhysicsEditor
#define PE_SHAPES_PIXELS_PER_POINT	2.0

#define IS_IPAD()					(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IPAD_SCALE()				(IS_IPAD() ? 2: 1)
#define PTM_RATIO_SCALED			((PTM_RATIO / PE_SHAPES_PIXELS_PER_POINT) * CC_CONTENT_SCALE_FACTOR() * IPAD_SCALE())
#define UNIV(__f__)					(IS_IPAD() ? [__f__ stringByReplacingCharactersInRange:[__f__ rangeOfString:@"."] withString:@"-hd."]: __f__)


// expose a few of GB2ShapeCache's inner classes
// not ideal, but works for now
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