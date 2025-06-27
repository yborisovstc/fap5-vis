#include <GL/glew.h>
#include <GL/gl.h>
#include <GLFW/glfw3.h>

#include "scene.h"
#include "mscel.h"
#include "mwindow.h"

const string KWndCnt_Init = "Init";
const string KWndCnt_Init_Val = "Yes";

GtScene::GtScene(const string& aType, const string& aName, MEnv* aEnv): Des(aType, aName, aEnv),
    mSelemOwnerCp(this), mSceneCp(this)
{
}

GtScene::~GtScene()
{
}

MIface* GtScene::MNode_getLif(TIdHash aId)
{
    MIface* res = nullptr;
    if (res = checkLif2(aId, mMScene));
    else res = Des::MNode_getLif(aId);
    return res;
}

MIface* GtScene::MOwned_getLif(TIdHash aId)
{
    MIface* res = nullptr;
    if (res = checkLif2(aId, mMScene));
    else res = TBase::MOwned_getLif(aId);
    return res;
}

void GtScene::RenderScene(void)
{
    if (mDrawOnComplete && isActive()) return;
    glClearColor(0.0, 0.0, 0.0, 0.0);
    glClear(GL_COLOR_BUFFER_BIT);

    for (auto it = mSelemOwnerCp.pairsBegin(); it != mSelemOwnerCp.pairsEnd(); it++) {
        MSceneElem* mse = (*it)->provided();
        if (mse) {
            mse->Render();
        }
    }
    glFlush();
}

void GtScene::update()
{
    //Logger()->Write(EInfo, this, "Update");
    Des::update();
}

void GtScene::onCursorPosition(double aX, double aY)
{
    for (auto it = mSelemOwnerCp.pairsBegin(); it != mSelemOwnerCp.pairsEnd(); it++) {
        MSceneElem* mse = (*it)->provided();
        if (mse) {
            mse->onSeCursorPosition(aX, aY);
        }
    }
}

void GtScene::onMouseButton(TFvButton aButton, TFvButtonAction aAction, int aMods)
{
    for (auto it = mSelemOwnerCp.pairsBegin(); it != mSelemOwnerCp.pairsEnd(); it++) {
        MSceneElem* mse = (*it)->provided();
        if (mse) {
            mse->onMouseButton(aButton, aAction, aMods);
        }
    }
}

void GtScene::onOwnedAttached(MOwned* aOwned)
{
    Des::onOwnedAttached(aOwned);
    auto selem = aOwned->lIft<MSceneElem>();
    if (selem) {
        bool res = mSelemOwnerCp.connect(selem->getCp());
        assert(res);
    }
}

void GtScene::GetCursorPos(double& aX, double& aY)
{
}

void GtScene::GetFbSize(int* aW, int* aH) const
{
    const MWindow* wnd = getWnd();
    if (wnd) {
        wnd->GetFbSize(aW, aH);
    }
}

void GtScene::getCoordOwrSeo(int& aOutX, int& aOutY, int aLevel)
{
    aOutX = 0;
    aOutY = 0;
}

const MWindow* GtScene::getWnd() const
{
    auto pair = mSceneCp.pairAt(0);
    return pair ? pair->provided() : nullptr;
}
