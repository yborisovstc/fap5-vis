
#ifndef __FAP5VIS_CONTAINER_H
#define __FAP5VIS_CONTAINER_H

#include <map>
#include <mdes.h>
#include <mdata.h>
#include <desadp.h>

#include "widget.h"

/** @brief Containter agent
 * Resolves MSceneElem redirecting to Controlled part
 * */
class ACnt: public AgtBase
{
    public:
	using TSelemOwnerCp = NCpOmnp<MSceneElemOwner, MSceneElem>;
    public:
	inline static constexpr std::string_view idStr() { return "ACnt"sv;}
	ACnt(const string &aType, const string& aName = string(), MEnv* aEnv = NULL);
	virtual ~ACnt();
	// From MAgent
	MIface* MAgent_getLif(TIdHash aId) override;
    protected:
        MSceneElem* getSceneElem();
};

/** @brief Widgets containter agent using approach of widgets linked to slot
 * With this approach each widget is assosiates to corresponding slot but not embedded to it
 * This container doesn't provide widgets allocation by itself but delegates it to slots
 * Each slot can have its own rules for allocating assosiated widget
 * This is containter version that supports DES controlling
 * */
class AVDContainer: public AVWidget, public MSceneElemOwner
{
    public:
	using TSelemOwnerCp = NCpOmnp<MSceneElemOwner, MSceneElem>;
    public:
	inline static constexpr std::string_view idStr() { return "AVDContainer"sv;}
	AVDContainer(const string& aType, const string& aName = string(), MEnv* aEnv = NULL);
	virtual ~AVDContainer();
	// From MNode
	MIface* MNode_getLif(TIdHash aId) override;
	// From MSceneElem
	void Render() override;
	bool onMouseButton(TFvButton aButton, TFvButtonAction aAction, int aMods) override;
	// From MSceneElemOwner
	string MSceneElemOwner_Uid() const override {return getUid<MSceneElemOwner>();}
	void getCoordOwrSeo(int& aOutX, int& aOutY, int aLevel = -1) override;
	void GetCursorPos(double& aX, double& aY) override;
	void GetFbSize(int* aW, int* aH) const override;
    protected:
	MSceneElemOwner* mMSceneElemOwner = nullptr;
	TSelemOwnerCp mSelemOwnerCp;  /*!< Scene elements owner connpoint */
};


#endif

