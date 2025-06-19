
#ifndef __FAP5VIS_BUTTON_H
#define __FAP5VIS_BUTTON_H

#include "widget.h"

class FTPixmapFont;

/** @brief Button widget agent
 * */
class AButton : public AVWidget
{
    public:
	inline static constexpr std::string_view idStr() { return "AButton"sv;}
	AButton(const string& aType, const string& aName = string(), MEnv* aEnv = NULL);
	// From MSceneElem
	virtual void Render() override;
	virtual bool onMouseButton(TFvButton aButton, TFvButtonAction aAction, int aMods) override;
    protected:
	// Internal transitions
	virtual void updateRqsW() override;
    protected:
	// TODO to have to shared font in visual env
	MNode* GetStatePressed();
};


#endif
