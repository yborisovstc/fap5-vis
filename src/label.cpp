
#include <FTGL/ftgl.h>
#include "label.h"


AVLabel::AVLabel(const string& aType, const string& aName, MEnv* aEnv): AVWidget(aType, aName, aEnv)
{ }

void AVLabel::Render()
{
    if (!mIsInitialised) return;

    AVWidget::Render();

    int wlx, wty, wrx, wby;
    getAlcWndCoord(wlx, wty, wrx, wby);

    // Draw the name
    auto fgColor = getFgColor();
    glColor3f(fgColor.r, fgColor.g, fgColor.b);
    glRasterPos2f(wlx + 5, wby + 5);
    if (mFont) {
        // TODO mIbText as DesEIbs updates data on confirm phase, same phase where rendering happens
        // So using DesEIbs is not acceptable here. Consider redesign (look at ASdc::SdcIap<T>::updateData()) 
	mFont->Render(getText()->mData.c_str());
    }

    CheckGlErrors();
}

void AVLabel::updateRqs()
{
    /*
    const string& text = getText()->mData;
    int adv = (int) mFont->Advance(text.c_str());
    int tfh = (int) mFont->LineHeight();
    float llx, lly, llz, urx, ury, urz;
    mFont->BBox(text.c_str(), llx, lly, llz, urx, ury, urz);
    int minRw = (int) urx + 2 * K_Padding;
    mOstRqsW->VDtSet(Sdata<int>(minRw));
    int minRh = (int) ury + 2 * K_Padding;
    mOstRqsH->VDtSet(Sdata<int>(minRh));
    */
}


