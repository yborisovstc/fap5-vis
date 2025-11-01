

#include <iostream> 
#include <rdata.h>
#include <FTGL/ftgl.h>

#include "widget.h"
#include "mwindow.h"
#include "visprof_id.h"

#include "deps/linmath.h" // Ref https://github.com/glfw/glfw/tree/master/deps


const int AVWidget::K_Padding = 5; /**< Base metric: Base padding */

const string AVWidget::KUri_AlcX = "AlcX";
const string AVWidget::KUri_AlcY = "AlcY";
const string AVWidget::KUri_AlcW = "AlcW";
const string AVWidget::KUri_AlcH = "AlcH";
const string AVWidget::KUri_BgColor = "BgColor";
const string AVWidget::KUri_FgColor = "FgColor";
const string AVWidget::KUri_Border = "Border";
const string AVWidget::KUri_TrFont = "TrFont";
const string AVWidget::KUri_Text = "SText";
const string AVWidget::KUri_InpFont = "InpFont";
const string AVWidget::KUri_InpFontSize = "InpFontSize";
const string AVWidget::KUri_InpText = "InpText";
const string AVWidget::KUri_OstRqsW = "OutpRqsW";
const string AVWidget::KUri_OstRqsH = "OutpRqsH";
const string AVWidget::KUri_OstLbpUri = "OutpLbpUri";

#if 0

void AVWidget::WInp::Construct()
{
    mInp = mHost->addInput(mInpName);
    bool res = mInp->bind(this);
    assert(res);
}

MIface* AVWidget::WInp::MDesInpObserver_getLif(TIdHash aId)
{
    MIface* res = nullptr;
    if (aId == id()) res = this;
    return res;

}

AVWidget::AVWidget(const string& aType, const string& aName, MEnv* aEnv): Node(aType, aName, aEnv),
    mDesSyncableCp(this),
    mAgentCp(this), mScelCp(this), mIsInitialised(true), mFont(nullptr),
    mWinpFontPath(this, KUri_InpFont),
    mWinpFontSize(this, KUri_InpFontSize),
    mWinpText(this, KUri_InpText)
{
}

void AVWidget::Construct()
{
    mWinpFontPath.Construct();
    mWinpFontSize.Construct();
    mWinpText.Construct();
    mOstRqsW = addState(KUri_OstRqsW);
    mOstRqsW->setContent("", "SI 0");
    mOstRqsH = addState(KUri_OstRqsH);
    mOstRqsH->setContent("", "SI 0");
    mOstLbpUri = addState(KUri_OstLbpUri);
}

AVWidget::~AVWidget()
{
    delete mFont;
}

MIface* AVWidget::MOwned_getLif(TIdHash aId)
{
    MIface* res = nullptr;
    if (res = checkLif2(aId, mMSceneElem));
    else if (res = checkLif2(aId, mMDesSyncable));
    else if (res = checkLif2(aId, mMAgent));
    else if (res = Node::MOwned_getLif(aId));
    return res;
}

MIface* AVWidget::MAgent_getLif(TIdHash aId)
{
    MIface* res = nullptr;
    if (res = checkLif2(aId, mMSceneElem));
    return res;
}

void AVWidget::CheckGlErrors()
{
    // check for errors
    const GLenum errCode = glGetError();
    if (errCode != GL_NO_ERROR){
	const GLubyte *errString;
	errString=gluErrorString(errCode);
	printf("error: %s\n", errString);
    }
}

bool AVWidget::getAlcWndCoord(int& aLx, int& aTy, int& aRx, int& aBy)
{
    bool res = false;
    auto dwc = GetParInt(KUri_AlcW);
    auto dhc = GetParInt(KUri_AlcH);
    if (dwc && dwc->IsValid() && dhc && dhc->IsValid()) {
        float wc = (float) dwc->mData;
        float hc = (float) dhc->mData;
        getWndCoord(0, 0, aLx, aTy);
        getWndCoord(wc, hc, aRx, aBy);
        int wndWidth = 0, wndHeight = 0;
        GetScelOwner()->GetFbSize(&wndWidth, &wndHeight);
        aTy = wndHeight - aTy;
        aBy = aTy - hc;
    }
    return res;
}


void AVWidget::Render()
{
    if (!mIsInitialised) return;
    if (mDrawOnComplete && isActive()) return;

    // Debugging
    /*
    float xc, yc, wc, hc;
    GetAlc(xc, yc, wc, hc);
    LOGN(EDbg, "Render: " + to_string(xc) + ", "  + to_string(yc) + ", " + to_string(wc) + ", " + to_string(hc));
    */

    //LOGN(EDbg, "Render");
    // Get viewport parameters
    GLint viewport[4];
    glGetIntegerv( GL_VIEWPORT, viewport );
    int vp_width = viewport[2], vp_height = viewport[3];
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    glOrtho(0, (GLdouble)vp_width, 0, (GLdouble)vp_height, -1.0, 1.0);

    // Window coordinates
    int wlx, wwty, wrx, wwby;
    getAlcWndCoord(wlx, wwty, wrx, wwby);
    LOGN(EDbg, "Render, wnd coords: " + to_string(wlx) + ", "  + to_string(wwty) + ", " + to_string(wrx) + ", " + to_string(wwby));

    // Background
    auto bgColor = GetColor(KUri_BgColor);
    glColor4f(bgColor.r, bgColor.g, bgColor.b, bgColor.a);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glBegin(GL_POLYGON);
    glVertex2f(wlx, wwty);
    glVertex2f(wrx, wwty);
    glVertex2f(wrx, wwby);
    glVertex2f(wlx, wwby);
    glEnd();
    
    // Border
    //
    auto vpBorder = GetParInt(KUri_Border);
    auto fgColor = GetColor(KUri_FgColor);
    if (vpBorder && vpBorder->IsValid() && vpBorder->mData) {
	glColor3f(fgColor.r, fgColor.g, fgColor.b);
	DrawLine(wlx, wwty, wlx, wwby);
	DrawLine(wlx, wwby, wrx, wwby);
	DrawLine(wrx, wwby, wrx, wwty);
	DrawLine(wrx, wwty, wlx, wwty);
    }

    CheckGlErrors();
}

string AVWidget::colorCntUri(const string& aType, const string& aPart)
{
    GUri res(aType);
    res.appendElem(aPart);
    return res;
}

void AVWidget::onSeCursorPosition(double aX, double aY)
{
    // Window coordinates
    auto dwc = GetParInt(KUri_AlcW);
    auto dhc = GetParInt(KUri_AlcH);
    if (dwc && dwc->IsValid() && dhc && dhc->IsValid()) {
        int wc = dwc->mData;
        int hc = dhc->mData;
        int wx0 = 0, wy0 = 0, wxw = 0, wyh = 0;
        getWndCoord(0, 0, wx0, wy0);
        getWndCoord(wc, hc, wxw, wyh);
        int wdX = aX - wx0;
        int wdY = aY - wy0;
        if (wdX >= 0 && wdX < wc && wdY >= 0 && wdY < hc) {
            onWdgCursorPos(wdX, wdY);
        }
    }
}

bool AVWidget::IsInnerWidgetPos(double aX, double aY)
{
    bool res = false;
    auto dwc = GetParInt(KUri_AlcW);
    auto dhc = GetParInt(KUri_AlcH);
    if (dwc && dwc->IsValid() && dhc && dhc->IsValid()) {
        int wc = dwc->mData;
        int hc = dhc->mData;
        int wlx = 0, wty = 0, wrx = 0, wby = 0;
        getWndCoord(0, 0, wlx, wty);
        getWndCoord(wc, hc, wrx, wby);
        int wndWidth = 0, wndHeight = 0;
        GetScelOwner()->GetFbSize(&wndWidth, &wndHeight);
        int wwty = wndHeight - wty;
        int wwby = wwty - hc;
        res = (aX > wlx && aX < wrx && aY > wwby && aY < wwty);
    }
    return res;
}

void AVWidget::onWdgCursorPos(int aX, int aY)
{
    //cout << "Widget [" << iMan->Name() << "], cursor, X: " << aX << ", Y:" << aY << endl;
}

MSceneElemOwner* AVWidget::GetScelOwner()
{
    auto pair = mScelCp.pairAt(0);
    return pair ? pair->provided() : nullptr;
}

const MSceneElemOwner* AVWidget::GetScelOwner() const
{
    auto pair = mScelCp.pairAt(0);
    return pair ? pair->provided() : nullptr;
}

bool AVWidget::getWndCoord(int aInpX, int aInpY, int& aOutX, int& aOutY)
{
    bool res = true;
    MSceneElemOwner* owner = GetScelOwner();
    if (owner) {
        auto dx = GetParInt(KUri_AlcX);
        auto dy = GetParInt(KUri_AlcY);
        if (dx && dx->IsValid() && dy && dy->IsValid()) {
            int x = dx->mData;
            int y = dy->mData;
            owner->getCoordOwrSeo(aOutX, aOutY);
            aOutX += (x + aInpX);
            aOutY += (y + aInpY);
        } else {
            res = false;
        }
    } else {
        aOutX = aInpX;
        aOutY = aInpY;
    }
    return res;
}

bool AVWidget::onMouseButton(TFvButton aButton, TFvButtonAction aAction, int aMods)
{
    bool res = false;
    double x = 0, y = 0;
    GetCursorPosition(x, y);
    if (IsInnerWidgetPos(x, y)) {
	//cout << "Widget [" << MNode::Uid() << "], button" << endl;
        auto* vs = mOstLbpUri->MNode::lIft<MDVarSet>();
	if (aButton == EFvBtnLeft && aAction == EFvBtnActPress) {
            vs->VDtSet(DGuri(ahostNode()->name()));
	} else if (aButton == EFvBtnLeft && aAction == EFvBtnActRelease) {
            DGuri data;
	    vs->VDtSet(data);
	}
	res = true;
    }
    return res;
}

void AVWidget::GetCursorPosition(double& aX, double& aY)
{
    GetScelOwner()->GetCursorPos(aX, aY);
}

void AVWidget::DrawLine(float x1, float y1, float x2, float y2)
{
    glBegin(GL_LINES);
    glVertex2f(x1, y1);
    glVertex2f(x2, y2);
    glEnd();
}

void AVWidget::GetAlc(float& aX, float& aY, float& aW, float& aH)
{
    aX = (float) GetParInt(KUri_AlcX)->mData;
    aY = (float) GetParInt(KUri_AlcY)->mData;
    aW = (float) GetParInt(KUri_AlcW)->mData;
    aH = (float) GetParInt(KUri_AlcH)->mData;
}

MNode* AVWidget::ahostNode()
{
    auto* pair = mAgentCp.pairAt(0);
    MAhost* ahost = pair ? pair->provided() : nullptr;
    return ahost ? ahost->lIft<MNode>() : nullptr;
}

CpStateInp* AVWidget::addInput(const string& aName)
{
    auto* inp = new CpStateInp(string(CpStateInp::idStr()), aName, mEnv);
    assert(inp);
    bool res = attachOwned(inp);
    assert(res);
    return inp;
}

BState* AVWidget::addState(const string& aName)
{
    auto* state = new BState(string(BState::idStr()), aName, mEnv);
    assert(state);
    bool res = attachOwned(state);
    assert(res);
    return state;
}

const Sdata<int>* AVWidget::GetParInt(const string& aUri)
{
    const Sdata<int>* res = 0;
    MNode* hostn = ahostNode();
    MNode* pu = hostn ? hostn->getNode(aUri, this) : nullptr;
    MDVarGet* pvg = pu->lIf(pvg);
    if (pvg) {
	res = pvg->DtGet(res);
    }
    return res;
}

const Sdata<string>* AVWidget::getText()
{
    const Sdata<string>* res = 0;
    MNode* hostn = ahostNode();
    MNode* pu = hostn ? hostn->getNode(KUri_Text, this) : nullptr;
    MDVarGet* pvg = pu->lIf(pvg);
    if (pvg) {
	res = pvg->DtGet(res);
    }
    return res;

}

AVWidget::TColor AVWidget::GetColor(const string& aUri)
{
    TColor res{0,0,0,0,false};
    MNode* hostn = ahostNode();
    MNode* pu = hostn ? hostn->getNode(aUri, this) : nullptr;
    MDVarGet* pvg = pu->lIf(pvg);
    if (pvg) {
	auto* dt = pvg->DtGet<NTuple>();
        if (dt && dt->mData.size() == 4) {
            for (auto it = dt->mData.begin(); it != dt->mData.end(); it++) {
                if (it->first == "r") res.r = static_cast<float>(reinterpret_cast<Sdata<int>*>(it->second)->mData);
                else if (it->first == "g") res.g = static_cast<float>(reinterpret_cast<Sdata<int>*>(it->second)->mData);
                else if (it->first == "b") res.b = static_cast<float>(reinterpret_cast<Sdata<int>*>(it->second)->mData);
                else if (it->first == "a") res.a = static_cast<float>(reinterpret_cast<Sdata<int>*>(it->second)->mData);
            }
            res.valid = dt->IsValid(); 
        }
    }
    return res;
} 

void AVWidget::update()
{
    if (mWinpFontPath.mActive) {
        if (mFont) {
            delete mFont; mFont = nullptr;
        }
        const string& fontPath = getInpSdata<string>(mWinpFontPath.mInp)->mData;
        mFont = new FTPixmapFont(fontPath.c_str());
        mWinpFontPath.mActive = false;
        auto* fontSizeD = getInpSInt(mWinpFontSize.mInp);
        if (fontSizeD && fontSizeD->IsValid()) {
            mFont->FaceSize(fontSizeD->mData);
            updateRqsW();
        }
    }
    if (mWinpFontSize.mActive) {
        mWinpFontSize.mActive = false;
        if (mFont) {
            auto* fontSizeD = getInpSInt(mWinpFontSize.mInp);
            if (fontSizeD && fontSizeD->IsValid()) {
                mFont->FaceSize(fontSizeD->mData);
                updateRqsW();
            }
        }
    }
}

void AVWidget::setActivated()
{
    if (!mActNotified) {
        MDesObserver* obs = desObserver();
        if (obs) {
            obs->onActivated(this);
            mActNotified = true;
        }
    }

}

void AVWidget::confirm()
{
}

#endif


AVWidget::AVWidget(const string& aType, const string& aName, MEnv* aEnv): Node(aType, aName, aEnv),
    mDesSyncableCp(this), mAgentCp(this), mScelCp(this), mIsInitialised(true), mFont(nullptr)
{
}

void AVWidget::Construct()
{
    mInpFontPath = addInput(KUri_InpFont);
    mInpFontSize = addInput(KUri_InpFontSize);
    mInpText = addInput(KUri_InpText);
    mOutpRqsW = addOutput(KUri_OstRqsW);
    mOutpRqsH = addOutput(KUri_OstRqsH);
    mOstLbpUri = addState(KUri_OstLbpUri);
}

AVWidget::~AVWidget()
{
    delete mFont;
}

MIface* AVWidget::MOwned_getLif(TIdHash aId)
{
    MIface* res = nullptr;
    if (res = checkLif2(aId, mMSceneElem));
    else if (res = checkLif2(aId, mMDesSyncable));
    else if (res = checkLif2(aId, mMAgent));
    else if (res = Node::MOwned_getLif(aId));
    return res;
}

MIface* AVWidget::MAgent_getLif(TIdHash aId)
{
    MIface* res = nullptr;
    if (res = checkLif2(aId, mMSceneElem));
    return res;
}

void AVWidget::CheckGlErrors()
{
    // check for errors
    const GLenum errCode = glGetError();
    if (errCode != GL_NO_ERROR){
	const GLubyte *errString;
	errString=gluErrorString(errCode);
	printf("error: %s\n", errString);
    }
}

bool AVWidget::getAlcWndCoord(int& aLx, int& aTy, int& aRx, int& aBy)
{
    bool res = false;
    auto dwc = GetParInt(KUri_AlcW);
    auto dhc = GetParInt(KUri_AlcH);
    if (dwc && dwc->IsValid() && dhc && dhc->IsValid()) {
        float wc = (float) dwc->mData;
        float hc = (float) dhc->mData;
        getWndCoord(0, 0, aLx, aTy);
        getWndCoord(wc, hc, aRx, aBy);
        int wndWidth = 0, wndHeight = 0;
        GetScelOwner()->GetFbSize(&wndWidth, &wndHeight);
        aTy = wndHeight - aTy;
        aBy = aTy - hc;
    }
    return res;
}


void AVWidget::Render()
{
    if (!mIsInitialised) return;
    if (mDrawOnComplete && isActive()) return;

    // Debugging
    float xc, yc, wc, hc;
    GetAlc(xc, yc, wc, hc);
    LOGN(EDbg, "Render: " + to_string(xc) + ", "  + to_string(yc) + ", " + to_string(wc) + ", " + to_string(hc));

    //LOGN(EDbg, "Render");
    // Get viewport parameters
    GLint viewport[4];
    glGetIntegerv( GL_VIEWPORT, viewport );
    int vp_width = viewport[2], vp_height = viewport[3];
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    glOrtho(0, (GLdouble)vp_width, 0, (GLdouble)vp_height, -1.0, 1.0);

    // Window coordinates
    int wlx, wwty, wrx, wwby;
    getAlcWndCoord(wlx, wwty, wrx, wwby);
    LOGN(EDbg, "Render, wnd coords: " + to_string(wlx) + ", "  + to_string(wwty) + ", " + to_string(wrx) + ", " + to_string(wwby));

    // Background
    auto bgColor = GetColor(KUri_BgColor);
    glColor4f(bgColor.r, bgColor.g, bgColor.b, bgColor.a);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glBegin(GL_POLYGON);
    glVertex2f(wlx, wwty);
    glVertex2f(wrx, wwty);
    glVertex2f(wrx, wwby);
    glVertex2f(wlx, wwby);
    glEnd();
    
    // Border
    //
    auto vpBorder = GetParInt(KUri_Border);
    auto fgColor = GetColor(KUri_FgColor);
    if (vpBorder && vpBorder->IsValid() && vpBorder->mData) {
	glColor3f(fgColor.r, fgColor.g, fgColor.b);
	DrawLine(wlx, wwty, wlx, wwby);
	DrawLine(wlx, wwby, wrx, wwby);
	DrawLine(wrx, wwby, wrx, wwty);
	DrawLine(wrx, wwty, wlx, wwty);
    }

    CheckGlErrors();
}

string AVWidget::colorCntUri(const string& aType, const string& aPart)
{
    GUri res(aType);
    res.appendElem(aPart);
    return res;
}

void AVWidget::onSeCursorPosition(double aX, double aY)
{
    // Window coordinates
    auto dwc = GetParInt(KUri_AlcW);
    auto dhc = GetParInt(KUri_AlcH);
    if (dwc && dwc->IsValid() && dhc && dhc->IsValid()) {
        int wc = dwc->mData;
        int hc = dhc->mData;
        int wx0 = 0, wy0 = 0, wxw = 0, wyh = 0;
        getWndCoord(0, 0, wx0, wy0);
        getWndCoord(wc, hc, wxw, wyh);
        int wdX = aX - wx0;
        int wdY = aY - wy0;
        if (wdX >= 0 && wdX < wc && wdY >= 0 && wdY < hc) {
            onWdgCursorPos(wdX, wdY);
        }
    }
}

bool AVWidget::IsInnerWidgetPos(double aX, double aY)
{
    bool res = false;
    auto dwc = GetParInt(KUri_AlcW);
    auto dhc = GetParInt(KUri_AlcH);
    if (dwc && dwc->IsValid() && dhc && dhc->IsValid()) {
        int wc = dwc->mData;
        int hc = dhc->mData;
        int wlx = 0, wty = 0, wrx = 0, wby = 0;
        getWndCoord(0, 0, wlx, wty);
        getWndCoord(wc, hc, wrx, wby);
        int wndWidth = 0, wndHeight = 0;
        GetScelOwner()->GetFbSize(&wndWidth, &wndHeight);
        int wwty = wndHeight - wty;
        int wwby = wwty - hc;
        res = (aX > wlx && aX < wrx && aY > wwby && aY < wwty);
    }
    return res;
}

void AVWidget::onWdgCursorPos(int aX, int aY)
{
    //cout << "Widget [" << iMan->Name() << "], cursor, X: " << aX << ", Y:" << aY << endl;
}

MSceneElemOwner* AVWidget::GetScelOwner()
{
    auto pair = mScelCp.pairAt(0);
    return pair ? pair->provided() : nullptr;
}

const MSceneElemOwner* AVWidget::GetScelOwner() const
{
    auto pair = mScelCp.pairAt(0);
    return pair ? pair->provided() : nullptr;
}

bool AVWidget::getWndCoord(int aInpX, int aInpY, int& aOutX, int& aOutY)
{
    bool res = true;
    MSceneElemOwner* owner = GetScelOwner();
    if (owner) {
        auto dx = GetParInt(KUri_AlcX);
        auto dy = GetParInt(KUri_AlcY);
        if (dx && dx->IsValid() && dy && dy->IsValid()) {
            int x = dx->mData;
            int y = dy->mData;
            owner->getCoordOwrSeo(aOutX, aOutY);
            aOutX += (x + aInpX);
            aOutY += (y + aInpY);
        } else {
            res = false;
        }
    } else {
        aOutX = aInpX;
        aOutY = aInpY;
    }
    return res;
}

bool AVWidget::onMouseButton(TFvButton aButton, TFvButtonAction aAction, int aMods)
{
    bool res = false;
    double x = 0, y = 0;
    GetCursorPosition(x, y);
    if (IsInnerWidgetPos(x, y)) {
	//cout << "Widget [" << MNode::Uid() << "], button" << endl;
        auto* vs = mOstLbpUri->MNode::lIft<MDVarSet>();
	if (aButton == EFvBtnLeft && aAction == EFvBtnActPress) {
            vs->VDtSet(DGuri(ahostNode()->name()));
	} else if (aButton == EFvBtnLeft && aAction == EFvBtnActRelease) {
            DGuri data;
	    vs->VDtSet(data);
	}
	res = true;
    }
    return res;
}

void AVWidget::GetCursorPosition(double& aX, double& aY)
{
    GetScelOwner()->GetCursorPos(aX, aY);
}

void AVWidget::DrawLine(float x1, float y1, float x2, float y2)
{
    glBegin(GL_LINES);
    glVertex2f(x1, y1);
    glVertex2f(x2, y2);
    glEnd();
}

void AVWidget::GetAlc(float& aX, float& aY, float& aW, float& aH)
{
    aX = (float) GetParInt(KUri_AlcX)->mData;
    aY = (float) GetParInt(KUri_AlcY)->mData;
    aW = (float) GetParInt(KUri_AlcW)->mData;
    aH = (float) GetParInt(KUri_AlcH)->mData;
}

MNode* AVWidget::ahostNode()
{
    auto* pair = mAgentCp.pairAt(0);
    MAhost* ahost = pair ? pair->provided() : nullptr;
    return ahost ? ahost->lIft<MNode>() : nullptr;
}

ExtdStateInp* AVWidget::addInput(const string& aName)
{
    auto* comp = new ExtdStateInp(string(ExtdStateInp::idStr()), aName, mEnv);
    assert(comp);
    comp->Construct();
    bool res = attachOwned(comp);
    assert(res);
    return comp;
}

ExtdStateOutp* AVWidget::addOutput(const string& aName)
{
    auto* comp = new ExtdStateOutp(string(ExtdStateOutp::idStr()), aName, mEnv);
    assert(comp);
    comp->Construct();
    bool res = attachOwned(comp);
    assert(res);
    return comp;
}

BState* AVWidget::addState(const string& aName)
{
    auto* state = new BState(string(BState::idStr()), aName, mEnv);
    assert(state);
    bool res = attachOwned(state);
    assert(res);
    return state;
}

const Sdata<int>* AVWidget::GetParInt(const string& aUri)
{
    const Sdata<int>* res = 0;
    MNode* hostn = ahostNode();
    MNode* pu = hostn ? hostn->getNode(aUri, this) : nullptr;
    MDVarGet* pvg = pu->lIf(pvg);
    if (pvg) {
	res = pvg->DtGet(res);
    }
    return res;
}

const Sdata<string>* AVWidget::getText()
{
    const Sdata<string>* res = 0;
    MNode* hostn = ahostNode();
    MNode* pu = hostn ? hostn->getNode(KUri_Text, this) : nullptr;
    MDVarGet* pvg = pu->lIf(pvg);
    if (pvg) {
	res = pvg->DtGet(res);
    }
    return res;

}

AVWidget::TColor AVWidget::GetColor(const string& aUri)
{
    TColor res{0,0,0,0,false};
    MNode* hostn = ahostNode();
    MNode* pu = hostn ? hostn->getNode(aUri, this) : nullptr;
    MDVarGet* pvg = pu->lIf(pvg);
    if (pvg) {
	auto* dt = pvg->DtGet<NTuple>();
        if (dt && dt->mData.size() == 4) {
            for (auto it = dt->mData.begin(); it != dt->mData.end(); it++) {
                if (it->first == "r") res.r = static_cast<float>(reinterpret_cast<Sdata<int>*>(it->second)->mData);
                else if (it->first == "g") res.g = static_cast<float>(reinterpret_cast<Sdata<int>*>(it->second)->mData);
                else if (it->first == "b") res.b = static_cast<float>(reinterpret_cast<Sdata<int>*>(it->second)->mData);
                else if (it->first == "a") res.a = static_cast<float>(reinterpret_cast<Sdata<int>*>(it->second)->mData);
            }
            res.valid = dt->IsValid(); 
        }
    }
    return res;
} 

void AVWidget::update()
{
    /*
    if (mWinpFontPath.mActive) {
        if (mFont) {
            delete mFont; mFont = nullptr;
        }
        const string& fontPath = getInpSdata<string>(mWinpFontPath.mInp)->mData;
        mFont = new FTPixmapFont(fontPath.c_str());
        mWinpFontPath.mActive = false;
        auto* fontSizeD = getInpSInt(mWinpFontSize.mInp);
        if (fontSizeD && fontSizeD->IsValid()) {
            mFont->FaceSize(fontSizeD->mData);
            updateRqsW();
        }
    }
    if (mWinpFontSize.mActive) {
        mWinpFontSize.mActive = false;
        if (mFont) {
            auto* fontSizeD = getInpSInt(mWinpFontSize.mInp);
            if (fontSizeD && fontSizeD->IsValid()) {
                mFont->FaceSize(fontSizeD->mData);
                updateRqsW();
            }
        }
    }
    */
}

void AVWidget::setActivated()
{
    if (!mActNotified) {
        MDesObserver* obs = desObserver();
        if (obs) {
            obs->onActivated(this);
            mActNotified = true;
        }
    }

}

void AVWidget::confirm()
{
}


void AVWidget::updateFont(const Sdata<string>* aFontPath, const Sdata<int>* aFontSize)
{
    if (aFontPath && aFontPath->IsValid() && aFontPath->mData != mFontPath) {
        if (mFont) {
            delete mFont; mFont = nullptr;
        }
        mFont = new FTPixmapFont(aFontPath->mData.c_str());
        mFontPath = aFontPath->mData;
    }
    if (mFont && aFontSize && aFontSize->IsValid() && aFontSize->mData != mFontSize) {
        mFont->FaceSize(aFontSize->mData);
        mFontSize = aFontSize->mData;
    }
}

