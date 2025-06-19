#ifndef __FAP5VIS_MSCEL_H
#define __FAP5VIS_MSCEL_H

#include "mvisenv.h"
#include "miface.h"
#include "nconn.h"
#include "mscene.h"

class MSceneElemOwner;

/** @brief Scene element of Visial environment interface
 * */
class MSceneElem: public MIface
{
    public:
	using TCp = MNcp<MSceneElem, MSceneElemOwner>;
    public:
	inline static constexpr std::string_view idStr() { return "MSceneElem"sv;}
	inline static constexpr TIdHash idHash() { return 0x1166858ad08fbd05;}

	virtual TCp* getCp() = 0;
	virtual void Render() = 0;
	/** @brief Cursor position handler
	 * @param aX, aY  cursor pos in window coordinates
	 * */
	virtual void onSeCursorPosition(double aX, double aY) = 0;

	/** @brief Handles mouse button events
	 * @param[in] aButton - button Id
	 * @param[in] aAction - action: GLFW_PRESS or GLFW_RELEASE
	 * @param[in] aMods - modes
	 * @return  Sign of the event is processed and accepted
	 * */
	virtual bool onMouseButton(TFvButton aButton, TFvButtonAction aAction, int aMods) = 0;

	// From MIface
	TIdHash id() const override { return idHash();}
	virtual string Uid() const override { return MSceneElem_Uid();}
	virtual string MSceneElem_Uid() const = 0;
};

/** @brief Scene element owner
 * */
class MSceneElemOwner: public MIface
{
    public:
	inline static constexpr std::string_view idStr() { return "MSceneElemOwner"sv;}
	inline static constexpr TIdHash idHash() { return 0x81f81a9179a6d3d8;}

        /** @brief Gets topleft coordinate in owning scene element
         * @param aLevel - owning scene element level, 0 - direct owner
         * */
	virtual void getCoordOwrSeo(int& aOutX, int& aOutY, int aLevel = -1) = 0;
	/** @brief Gets cursor position in window coordinate system */
	virtual void GetCursorPos(double& aX, double& aY) = 0;
	/** @brief Gets size of window in pixels (actually framebuffer size) */
	virtual void GetFbSize(int* aW, int* aH) const = 0;

	// From MIface
	TIdHash id() const override { return idHash();}
	virtual string Uid() const override { return MSceneElemOwner_Uid();}
	virtual string MSceneElemOwner_Uid() const = 0;
};


#endif
