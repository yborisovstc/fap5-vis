
#ifndef __FAP5VIS_BUTTON_H
#define __FAP5VIS_BUTTON_H

#include "widget.h"

class FTPixmapFont;

/** @brief Button widget agent
 * The design of the agent is far from canonic one. Transition of requisition
 * is just proxy of AButton context but not "classic" transition.
 * */
class AButton : public AVWidget
{
    public:
        /* @brief Transition of requisition
         * */
        class TrRqs: public TrBase {
            public:
                inline static constexpr std::string_view idStr() { return "TrRqs"sv;}
                TrRqs(const string& aType, const string& aName, MEnv* aEnv, AVWidget* aHost, bool aRqsH);
                void Construct() override;
            protected:
                CpStateInp* addInput(const string& aName);
                string VarGetIfid() const override;
                const DtBase* doVDtGet(const string& aType) override;
            public:
                CpStateInp* mInpFont = nullptr;
                CpStateInp* mInpFontSize = nullptr;
                CpStateInp* mInpText = nullptr;
            protected:
                AVWidget* mHost = nullptr;
                bool mRqsH = false; // Requisition for hight, otherwise for width
        };
        friend class TrRqs;
    public:
	inline static constexpr std::string_view idStr() { return "AButton"sv;}
	AButton(const string& aType, const string& aName = string(), MEnv* aEnv = NULL);
        void Construct() override;
	void updateRqs() override;
	// From MSceneElem
	virtual void Render() override;
	virtual bool onMouseButton(TFvButton aButton, TFvButtonAction aAction, int aMods) override;
    protected:
	// TODO to have to shared font in visual env
	MNode* GetStatePressed();
        TrRqs* mTrRqsW = nullptr;
        TrRqs* mTrRqsH = nullptr;
        static const string KUri_TrRqsW;
        static const string KUri_TrRqsH;
};


#endif
