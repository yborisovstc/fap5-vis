#ifndef __FAP5VIS_SCENE_H
#define __FAP5VIS_SCENE_H

#include <des.h>
#include <mscene.h>
#include <mscel.h>


using namespace std;

class MSceneElem;

/** @brier Scene of GLUT base visualization module
 * It is also visual representation of model
 * */
class GtScene: public Des, public MScene, public MSceneElemOwner
{
    public:
	using TSceneCp = NCpOnp<MScene, MWindow>;
	using TSelemOwnerCp = NCpOmnp<MSceneElemOwner, MSceneElem>;
        using TBase = Des;
    public:
	inline static constexpr std::string_view idStr() { return "GtScene"sv;}
	GtScene(const string& aType, const string& aName, MEnv* aEnv);
        virtual ~GtScene();
	// From MScene
	virtual string MScene_Uid() const override {return getUid<MScene>();}
	// From MSceneElemOwner
	string MSceneElemOwner_Uid() const override {return getUid<MSceneElemOwner>();}
	void getCoordOwrSeo(int& aOutX, int& aOutY, int aLevel = -1) override;
	void GetCursorPos(double& aX, double& aY) override;
	void GetFbSize(int* aW, int* aH) const override;
	// From Node
	virtual MIface* MNode_getLif(TIdHash aId) override;
        void onOwnedAttached(MOwned* aOwned) override;
	// From MScene
        MScene::TCp* getSceneCp() override { return &mSceneCp;}
	void RenderScene(void) override;
	void onCursorPosition(double aX, double aY) override;
	void onMouseButton(TFvButton aButton, TFvButtonAction aAction, int aMods) override;
    public:
	// From MDesSyncable
	virtual void update() override;
    protected:
        const MWindow* getWnd() const;
        inline MWindow* getWnd() { return mSceneCp.mPair ? mSceneCp.mPair->provided() : nullptr;}
	// From MOwned
	MIface* MOwned_getLif(TIdHash aId) override;
    protected:
        TSceneCp mSceneCp;
	TSelemOwnerCp mSelemOwnerCp;  /*!< Scene elements owner connpoint */
	MScene* mMScene = nullptr;
};

#endif


