/**
 *
 * BMFieldAutoScrollingScrollView
 *
 * Portriat Only (Keyboard size is hard coded)
 *
 * Set contentSize on ScrollView (this will appripriately size
 *      the scrollView's contentSize and the bm_contentView size)
 * Add text fields to bm_contentView
 * Add text fields array to textFields property
 *
 * Note: ScrollView registers as textFieldDelegate for 
 *       all text fields.  If you need the text field
 *       callbacks, register as a BMFieldAutoScrollingScrollViewDelegate
 *       and they will be forwarded to you
 *
 */

#import <UIKit/UIKit.h>

@protocol BMFieldAutoScrollingScrollViewDelegate <NSObject>
@optional
- (void)textFieldDidReturn:(UITextField *)textField;
- (void)finalTextFieldDidReturn;
@end


@interface BMFieldAutoScrollingScrollView : UIScrollView
@property (weak) id<BMFieldAutoScrollingScrollViewDelegate> autoScrollingDelegate;
@property UIView *bm_contentView;
@property (nonatomic) NSArray *textFields;
@end
