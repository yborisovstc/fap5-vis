
#include "mwindow.h"

#include "container.h"

////// ACnt
//
ACnt::ACnt(const string &aType, const string& aName, MEnv* aEnv): AgtBase(aType, aName, aEnv)
{
}

ACnt::~ACnt()
{
}

MIface* ACnt::MAgent_getLif(TIdHash aId)
{
    MIface* res = nullptr;
    if (aId == MSceneElem::idHash()) {
        res = getSceneElem();
    } else res = AgtBase::MAgent_getLif(aId);
    return res;
}

MSceneElem* ACnt::getSceneElem()
{
    MSceneElem* res = nullptr;
    auto* hostn = ahostNode();
    auto* hostsebl = hostn ? hostn->lIft<MSystExplorable>() : nullptr;
    MNode* seblCtld = hostsebl ? hostsebl->getMag() : nullptr;
    res = seblCtld ? seblCtld->lIft<MSceneElem>() : nullptr;
    return res;
}



//// AVDContainer

AVDContainer::AVDContainer(const string& aType, const string& aName, MEnv* aEnv): AVWidget(aType, aName, aEnv),
    mSelemOwnerCp(this), mObrCp(this)
{
}

AVDContainer::~AVDContainer()
{
}

MIface* AVDContainer::MNode_getLif(TIdHash aId)
{
    MIface* res = nullptr;
    if (res = checkLif2(aId, mMSceneElemOwner));
    else if (res = AVWidget::MNode_getLif(aId));
    return res;
}

void AVDContainer::Render()
{
    //Log(TLog(EDbg, this) + "Render");

    if (mDrawOnComplete && isActive()) return;

    AVWidget::Render();

    for (auto it = mSelemOwnerCp.pairsBegin(); it != mSelemOwnerCp.pairsEnd(); it++) {
        MSceneElem* mse = (*it)->provided();
        if (mse) {
	    try {
		mse->Render();
	    } catch (std::exception e) {
		LOGN(EErr, "Error on render [" + mse->Uid() + "]");
	    }
        }
    }
}

bool AVDContainer::onMouseButton(TFvButton aButton, TFvButtonAction aAction, int aMods)
{
    bool res = false;
    bool lres = AVWidget::onMouseButton(aButton, aAction, aMods);
    if (lres) {
        for (auto it = mSelemOwnerCp.pairsBegin(); it != mSelemOwnerCp.pairsEnd(); it++) {
            MSceneElem* mse = (*it)->provided();
            if (mse) {
                res = mse->onMouseButton(aButton, aAction, aMods);
            }
        }
    }
    return res;
}

void AVDContainer::getCoordOwrSeo(int& aOutX, int& aOutY, int aLevel)
{
    MSceneElemOwner* owner = GetScelOwner();
    if (owner && aLevel != 0) {
        auto dwx = GetParInt(KUri_AlcX);
        auto dwy = GetParInt(KUri_AlcY);
        if (dwx && dwx->IsValid() && dwy && dwy->IsValid()) {
                owner->getCoordOwrSeo(aOutX, aOutY, aLevel - 1);
                aOutX += dwx->mData;
                aOutY += dwy->mData;
        }
    } else {
	aOutX = 0;
	aOutY = 0;
    }
}

void AVDContainer::GetCursorPos(double& aX, double& aY)
{
}

void AVDContainer::GetFbSize(int* aW, int* aH) const
{
    GetScelOwner()->GetFbSize(aW, aH);
}

void AVDContainer::onOwnerAttached()
{
    MNode* ahostn = ahostNode(); 
    MObservable* ahostobl = ahostn ? ahostn->lIf(ahostobl) : nullptr;
    if (ahostobl) {
        bool res = ahostobl->addObserver(this, TNodeEventOwnedAttached::idHash);
        if (!res) {
            LOGN(EErr, "onOwnerAttached failed");
        }
    }
}

void AVDContainer::onObsEvent(MObservable* aObl, const MEvent* aEvent)
{
    if (aEvent->mId == TNodeEventOwnedAttached::idHash) {
	auto* event = reinterpret_cast<TNodeEventOwnedAttached*>(const_cast<MEvent*>(aEvent));
        assert(event);
	MOwned* owned = const_cast<MOwned*>(event->mOwned);
        assert(owned);
	//LOGN(EDbg, "EventOwnedAttached, owned: " + owned->Uid());
        MSceneElem* owdSce = owned->lIft<MSceneElem>();
        if (owdSce) {
            LOGN(EDbg, "EventOwnedAttached, scene elem owned: " + owdSce->Uid());
            mSelemOwnerCp.connect(owdSce->getCp());
        }
    }
}
