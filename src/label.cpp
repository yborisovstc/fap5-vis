
#include <FTGL/ftgl.h>
#include "label.h"


const string KStateContVal = "";
const string AVLabel::KUri_TrRqsW = "TrRqsW";
const string AVLabel::KUri_TrRqsH = "TrRqsH";



AVLabel::TrRqs::TrRqs(const string& aType, const string& aName, MEnv* aEnv, AVWidget* aHost, bool aRqsH):
    TrBase(aType, aName, aEnv), mHost(aHost), mRqsH(aRqsH)
{}

void AVLabel::TrRqs::Construct()
{
    mInpFont = addInput(KUri_InpFont);
    mInpFont->bind(&mInpsBp);
    mInpFontSize = addInput(KUri_InpFontSize);
    mInpFontSize->bind(&mInpsBp);
    mInpText = addInput(KUri_InpText);
    mInpText->bind(&mInpsBp);
}

CpStateInp* AVLabel::TrRqs::addInput(const string& aName)
{
    auto* inp = new CpStateInp(string(CpStateInp::idStr()), aName, mEnv);
    assert(inp);
    bool res = attachOwned(inp);
    assert(res);
    return inp;
}

string AVLabel::TrRqs::VarGetIfid() const
{
    return Sdata<int>::TypeSig();
}

const DtBase* AVLabel::TrRqs::doVDtGet(const string& aType)
{
    const DtBase* res = nullptr;
    auto* fontPathD = AVWidget::getInpSdata<string>(mInpFont);
    auto* fontSizeD = getInpSdata<int>(mInpFontSize);
    mHost->updateFont(fontPathD, fontSizeD);
    if (mHost->mFont) {
        mHost->updateRqs();
        res = mRqsH ? &mHost->mRqsH : &mHost->mRqsW;
    }
    return res;
}





AVLabel::AVLabel(const string& aType, const string& aName, MEnv* aEnv): AVWidget(aType, aName, aEnv)
{ }


void AVLabel::Construct()
{
    AVWidget::Construct();
    mTrRqsH = new TrRqs(string(TrRqs::idStr()), KUri_TrRqsH, mEnv, this, true);
    assert(mTrRqsH);
    mTrRqsH->Construct();
    bool res = attachOwned(mTrRqsH);
    assert(res);
    mTrRqsW = new TrRqs(string(TrRqs::idStr()), KUri_TrRqsW, mEnv, this, false);
    assert(mTrRqsW);
    mTrRqsW->Construct();
    res = attachOwned(mTrRqsW);
    assert(res);
    res = MVert::connect(mTrRqsW->mInpFont, mInpFontPath->mInt);
    res = res && MVert::connect(mTrRqsW->mInpFontSize, mInpFontSize->mInt);
    res = res && MVert::connect(mTrRqsW->mInpText, mInpText->mInt);
    res = res && MVert::connect(mOutpRqsW->mInt, mTrRqsW);
    res = res && MVert::connect(mTrRqsH->mInpFont, mInpFontPath->mInt);
    res = res && MVert::connect(mTrRqsH->mInpFontSize, mInpFontSize->mInt);
    res = res && MVert::connect(mTrRqsH->mInpText, mInpText->mInt);
    res = res && MVert::connect(mOutpRqsH->mInt, mTrRqsH);
    assert(res);
}


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
    const string& text = getText()->mData;
    int adv = (int) mFont->Advance(text.c_str());
    int tfh = (int) mFont->LineHeight();
    float llx, lly, llz, urx, ury, urz;
    mFont->BBox(text.c_str(), llx, lly, llz, urx, ury, urz);
    int minRw = (int) urx + 2 * K_Padding;
    mRqsW = minRw;
    int minRh = (int) ury + 2 * K_Padding;
    mRqsH = minRh;
}


