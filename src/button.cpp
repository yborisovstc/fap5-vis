
#include <iostream> 
#include <FTGL/ftgl.h>

#include "button.h"
#include "mwindow.h"

const string KStateContVal = "";
const string AButton::KUri_TrRqsW = "TrRqsW";
const string AButton::KUri_TrRqsH = "TrRqsH";


AButton::TrRqs::TrRqs(const string& aType, const string& aName, MEnv* aEnv, AVWidget* aHost, bool aRqsH):
    TrBase(aType, aName, aEnv), mHost(aHost), mRqsH(aRqsH)
{}

void AButton::TrRqs::Construct()
{
    mInpFont = addInput(KUri_InpFont);
    mInpFont->bind(&mInpsBp);
    mInpFontSize = addInput(KUri_InpFontSize);
    mInpFontSize->bind(&mInpsBp);
    mInpText = addInput(KUri_InpText);
    mInpText->bind(&mInpsBp);
}

CpStateInp* AButton::TrRqs::addInput(const string& aName)
{
    auto* inp = new CpStateInp(string(CpStateInp::idStr()), aName, mEnv);
    assert(inp);
    bool res = attachOwned(inp);
    assert(res);
    return inp;
}

string AButton::TrRqs::VarGetIfid() const
{
    return Sdata<int>::TypeSig();
}

const DtBase* AButton::TrRqs::doVDtGet(const string& aType)
{
    const DtBase* res = nullptr;
    /*
    auto* fontPath = AVWidget::getInpSdata<string>(mInpFont);
    if (fontPath && fontPath->IsValid() && fontPath->mData != mHost->mFontPath) {
        if (mHost->mFont) {
            delete mHost->mFont; mHost->mFont = nullptr;
        }
        mHost->mFont = new FTPixmapFont(fontPath->mData.c_str());
        mHost->mFontPath = fontPath->mData;
    }
    auto* fontSizeD = getInpSdata<int>(mInpFontSize);
    if (fontSizeD && fontSizeD->IsValid() && fontSizeD->mData != mHost->mFontSize) {
        mHost->mFont->FaceSize(fontSizeD->mData);
        mHost->mFontSize = fontSizeD->mData;
    }
    */
    auto* fontPathD = AVWidget::getInpSdata<string>(mInpFont);
    auto* fontSizeD = getInpSdata<int>(mInpFontSize);
    mHost->updateFont(fontPathD, fontSizeD);
    if (mHost->mFont) {
        mHost->updateRqs();
        res = mRqsH ? &mHost->mRqsH : &mHost->mRqsW;
    }
    return res;
}



AButton::AButton(const string& aType, const string& aName, MEnv* aEnv): AVWidget(aType, aName, aEnv)
{ }

void AButton::Construct()
{
    /*
    mInpFontPath = addInput(KUri_InpFont);
    mInpFontSize = addInput(KUri_InpFontSize);
    mInpText = addInput(KUri_InpText);
    mOutpRqsW = addOutput(KUri_OstRqsW);
    mOutpRqsH = addOutput(KUri_OstRqsH);
    mOstLbpUri = addState(KUri_OstLbpUri);
    */
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

MNode* AButton::GetStatePressed()
{
    return ahostNode()->getNode("Pressed");
}

bool AButton::onMouseButton(TFvButton aButton, TFvButtonAction aAction, int aMods)
{
    bool res = false;
    if (aButton == GLFW_MOUSE_BUTTON_LEFT && aAction == GLFW_PRESS) {
	double x = 0, y = 0;
	GetCursorPosition(x, y);
	if (IsInnerWidgetPos(x, y)) {
	    //cout << "UnitCrp [" << iMan->Name() << "], button" << endl;
	    MNode* spressed = GetStatePressed();
            auto* spressedco = spressed->lIft<MContentOwner>();
	    spressedco->setContent(KStateContVal, "SB true");
	    // Activate "pressed" state to reset it
	    MDesInpObserver* spIo = spressed->lIf(spIo);
	    if (spIo) {
		spIo->onInpUpdated();
	    }
	}
    }
    return res;
}

void AButton::Render()
{
    //assert(mIsInitialised);
    if (!mIsInitialised) return;

    AVWidget::Render();

    int wlx, wty, wrx, wby;
    getAlcWndCoord(wlx, wty, wrx, wby);

    // Draw the name
    auto fgColor = getFgColor();
    glColor3f(fgColor.r, fgColor.g, fgColor.b);
    glRasterPos2f(wlx + 5, wby + 5);
    if (mFont) {
	mFont->Render(getText()->mData.c_str());
    }

    CheckGlErrors();
}

void AButton::updateRqs()
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

