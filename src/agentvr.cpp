
#include <iostream> 
#include <FTGL/ftgl.h>

#include "agentvr.h"
#include "mwindow.h"
#include "des.h"




#if 0
// Agents Visual representation view manager

static const string K_UriNodeSelected = "NodeSelected";

AVrpView::AVrpView(const string& aType, const string& aName, MEnv* aEnv): AgtBase(aType, aName, aEnv), mAgtCp(this)
{
}

MNode* AVrpView::ahostNode()
{
    MAhost* ahost = (*mAgtCp.pairsBegin())->provided();
    MNode* hostn = ahost ? ahost->lIf(hostn) : nullptr;
    return hostn;
}
#endif



// Edge CRP

const string K_PLeftCpUri = "VertPApAlc";
const string K_QRightCpUri = "VertQApAlc";
const string K_StartSeg = "LeftVertAlcCp";
const string K_RightBridge = "RightVertAlcCp";
const string K_DrpAdpUri = "DrpAdp";
const string K_DrpAdpExplbUri = "DrpAdp.CpExpbl";
const string K_SegCountUri = "DrpAdp.EdgeColRank";

const string AEdgeCrp::KUri_TrRqsW = "TrRqsW";
const string AEdgeCrp::KUri_TrRqsH = "TrRqsH";

AEdgeCrp::TrRqs::TrRqs(const string& aType, const string& aName, MEnv* aEnv, AVWidget* aHost, bool aRqsH):
    TrBase(aType, aName, aEnv), mHost(aHost), mRqsH(aRqsH)
{}

void AEdgeCrp::TrRqs::Construct()
{
}

CpStateInp* AEdgeCrp::TrRqs::addInput(const string& aName)
{
    auto* inp = new CpStateInp(string(CpStateInp::idStr()), aName, mEnv);
    assert(inp);
    bool res = attachOwned(inp);
    assert(res);
    return inp;
}

string AEdgeCrp::TrRqs::VarGetIfid() const
{
    return Sdata<int>::TypeSig();
}

const DtBase* AEdgeCrp::TrRqs::doVDtGet(const string& aType)
{
    const DtBase* res = nullptr;
    res = mRqsH ? &mHost->mRqsH : &mHost->mRqsW;
    return res;
}




AEdgeCrp::AEdgeCrp(const string& aType, const string& aName, MEnv* aEnv): AVWidget(aType, aName, aEnv)
{ }

void AEdgeCrp::Render()
{
    if (!mIsInitialised) return;

    GLint viewport[4];
    glGetIntegerv( GL_VIEWPORT, viewport );
    int vp_width = viewport[2], vp_height = viewport[3];
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    glOrtho(0, (GLdouble)vp_width, 0, (GLdouble)vp_height, -1.0, 1.0);

    auto fgColor = GetColor(KUri_FgColor);
    glColor3f(fgColor.r, fgColor.g, fgColor.b);

    // Draw Edge CRP default segments slots
    DrawSegment("LtSlot");
    DrawSegment("RtSlot");
    DrawSegment("VsSlot");
    // Traversing with Edge CRP regular segments slots
    int i = 0;
    bool res = false;
    do {
	string sname = "Rs_" + to_string(i++ + 1);
	// Vertical sub-segment
	res = DrawSegment(sname + ".Vs");
	// Horizontal sub-segment
	res &= DrawSegment(sname + ".Hs");
    } while (res);
    CheckGlErrors();
}

void AEdgeCrp::Construct()
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
    res = res && MVert::connect(mOutpRqsW->mInt, mTrRqsW);
    res = res && MVert::connect(mOutpRqsH->mInt, mTrRqsH);
    assert(res);
}


bool AEdgeCrp::DrawSegment(const string& aSegName)
{
    bool res = false;
    int lX, lY, rX, rY;
    int lwX, lwY, rwX, rwY;
    bool valid = true;
    auto* drpAdpn = ahostNode()->getNode(K_DrpAdpExplbUri);
    auto* drpAdpv = drpAdpn ? drpAdpn->lIft<MVert>() : nullptr;
    MSystExplorable* drpAdp = drpAdpv ? drpAdpv->lIf(drpAdp) : nullptr;
    auto* drp = drpAdp ? drpAdp->getMag() : nullptr;
    if (drp) {
	string segName = ahostNode()->name() + "_" + aSegName;
	auto* wcp = drp->getNode(segName + ".Coords");
	if (wcp) {
	    valid &= GetSegCoord(wcp, "LeftX", lX);
	    valid &= GetSegCoord(wcp, "LeftY", lY);
	    valid &= GetSegCoord(wcp, "RightX", rX);
	    valid &= GetSegCoord(wcp, "RightY", rY);
	    LOGN(EDbg, "Seg [" + aSegName + "]:" + to_string(lX) + ", "  + to_string(lY) + ", " + to_string(rX) + ", " + to_string(rY));
	    if (valid) {
		GetDirectWndCoord(lX, lY, lwX, lwY);
		GetDirectWndCoord(rX, rY, rwX, rwY);
		DrawLine(lwX, lwY, rwX, rwY);
		res = true;
	    }
	}
    }
    return res;
}

const DtBase* AEdgeCrp::GetStOutpData(const GUri& aCpUri, const string& aTypeSig)
{
    const DtBase* res = nullptr;
    auto* cpn = ahostNode()->getNode(aCpUri);
    if (cpn) {
	MVert* cpv = cpn->lIf(cpv);
	MDVarGet* cpg = cpv ? cpv->lIf(cpg) : nullptr;
	res = cpg ? cpg->VDtGet(aTypeSig) : nullptr;
    }
    return res;
}


bool AEdgeCrp::GetSegCoord(MNode* aWdgCp, const GUri& aCpUri, int& aData)
{
    bool res = false;
    aData = -1;
    auto* ccp = aWdgCp->getNode(aCpUri);
    if (ccp) {
	MVert* ccpe = ccp->lIf(ccpe); // Coords (socket) elems are extenders
        MVert* ccpv = ccpe ? ccpe->getExtd() : nullptr;
	MDVarGet* ccpg = ccpv->lIf(ccpg);
	if (ccpg) {
	    const Sdata<int>* data = reinterpret_cast<const Sdata<int>*>(ccpg->VDtGet(data->TypeSig()));
	    if (data) {
		res = data->IsValid();
		if (res) {
		    aData = data->mData;
		}
	    }
	}
    }
    return res;
}

void AEdgeCrp::updateRqsW()
{
    mRqsW = 0;
    mRqsH = 0;
}

void AEdgeCrp::GetDirectWndCoord(int aInpX, int aInpY, int& aOutX, int& aOutY)
{
    int x,y;
    getWndCoord(aInpX, aInpY, x, y);
    int wndWidth = 0, wndHeight = 0;
    GetScelOwner()->GetFbSize(&wndWidth, &wndHeight);
    aOutX = x;
    aOutY = wndHeight - y;
}
