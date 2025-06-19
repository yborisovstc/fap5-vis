
#ifndef __FAP5VIS_LABEL_H
#define __FAP5VIS_LABEL_H

#include "widget.h"

class FTPixmapFont;

/** @brief Label widget agent
 * */
class AVLabel : public AVWidget
{
    public:
	inline static constexpr std::string_view idStr() { return "AVLabel"sv;}
	AVLabel(const string& aType, const string& aName = string(), MEnv* aEnv = NULL);
	// From MSceneElem
	virtual void Render() override;
    protected:
	// Internal transitions
	virtual void updateRqsW() override;
};

#endif

