#ifndef __FAP5VIS_WIDGET_H
#define __FAP5VIS_WIDGET_H

#include <mscel.h>
#include <des.h>

#include <GL/glew.h>
#include <GL/gl.h>
#include <GLFW/glfw3.h>


class MWindow;
class FTPixmapFont;

/* @brief Transition of native font, ref ds_usaid_staid for approach
 * */
//class TrFont: public TrBase
//{
//};

/** @brief Widget base agent
 * Implements local providing (not completed) to support transition with agents context, ref ds_dee_sac
 * Uses embedded DES elements to create seamless DES, ref ds_dee
 * */
class AVWidget : public Node, public MDesSyncable, public MAgent, public MSceneElem
{
    public:
        using TScelCp = NCpOnp<MSceneElem, MSceneElemOwner>;
	using TColor = struct {float r, g, b, a; bool valid;};
    public:
        /* @brief Widget's input
         * */
        struct WInp: public MDesInpObserver {
            WInp(AVWidget* aHost, const string& aInpName): mHost(aHost), mInpName(aInpName) {}
            void Construct();
            string MDesInpObserver_Uid() const override {return string();}
            void MDesInpObserver_doDump(int aLevel, int aIdt, ostream& aOs) const override {}
            MIface* MDesInpObserver_getLif(TIdHash aId) override;
            void onInpUpdated() override {
                mHost->setActivated();
                mActive = true;
            }
            AVWidget* mHost;
            CpStateInp* mInp;
            string mInpName;
            bool mActive = false;
        };
    public:
	inline static constexpr std::string_view idStr() { return "AVWidget"sv;}
	AVWidget(const string& aType, const string& aName = string(), MEnv* aEnv = NULL);
        void Construct() override;
	virtual ~AVWidget();
        // From Node
	MIface* MOwned_getLif(TIdHash aId) override;
	// From MSceneElem
	string MSceneElem_Uid() const override { return getUid<MSceneElem>();}
        MSceneElem::TCp* getCp() override { return &mScelCp; }
	void Render() override;
	void onSeCursorPosition(double aX, double aY) override;
	bool onMouseButton(TFvButton aButton, TFvButtonAction aAction, int aMods) override;
        // From MAgent
	string MAgent_Uid() const override { return getUid<MAgent>();}
	MIface* MAgent_getLif(TIdHash aId) override;
        MAgent::TCp* getMAgentCp() override { return &mAgentCp; }
        // From MDesSyncable
	string MDesSyncable_Uid() const override {return getUid<MDesSyncable>();}
	void MDesSyncable_doDump(int aLevel, int aIdt, ostream& aOs) const override {}
	MIface* MDesSyncable_getLif(TIdHash aId) override { return nullptr; }
	void update() override;
	void confirm() override;
	void setUpdated() override {}
	void setActivated() override;
	bool isActive() const override { return false;}
	int countOfActive(bool aLocal = false) const override { return 0;}
        TDesSyncableCp* desSyncableCp() override { return &mDesSyncableCp; }
    protected:
        inline MDesObserver* desObserver() { return mDesSyncableCp.mPair ? mDesSyncableCp.mPair->provided() : nullptr;}
	/** @brief Handles cursor position change
	 * @param[in] aX, aY  Pos widget coordinates
	 * */
	virtual void onWdgCursorPos(int aX, int aY);
	static void DrawLine(float x1, float y1, float x2, float y2);
	bool getWndCoord(int aInpX, int aInpY, int& aOutX, int& aOutY);
    protected:
        CpStateInp* addInput(const string& aInpName);
        BState* addState(const string& aName);
	MNode* ahostNode();
	MSceneElemOwner* GetScelOwner();
	const MSceneElemOwner* GetScelOwner() const;
	void GetAlc(float& aX, float& aY, float& aW, float& aH);
        TColor GetColor(const string& aUri);
        inline TColor getFgColor() { return GetColor(KUri_FgColor);}
        inline TColor getBgColor() { return GetColor(KUri_BgColor);}
        const Sdata<string>* getText();
	bool getAlcWndCoord(int& aLx, int& aTy, int& aRx, int& aBy);
	static void CheckGlErrors();
	void GetCursorPosition(double& aX, double& aY);
	bool IsInnerWidgetPos(double aX, double aY);
	static string colorCntUri(const string& aType, const string& aPart);
        const Sdata<int>* GetParInt(const string& aUri);
        template <class T> const Sdata<T>* getInpSdata(Vert* aInp) {
            const Sdata<T>* res = nullptr;
            auto vget = aInp->mPairs.empty() ? nullptr : aInp->mPairs.at(0)->lIft<MDVarGet>();
            if (vget) {
                res = vget->DtGet<Sdata<T>>();
            }
            return res;
        }
        inline const Sdata<int>* getInpSInt(Vert* aInp) { return getInpSdata<int>(aInp); }

	// Internal transitions
	virtual void updateRqsW() {}
    protected:
        NCpOnp<MDesSyncable, MDesObserver> mDesSyncableCp;
        NCpOnp<MAgent, MAhost> mAgentCp;
        TScelCp mScelCp;
	bool mIsInitialised = false;
	//CpStateInp* mInpFontPath;   //!< Input "Font Paths"
	//CpStateInp* mInpFontSize;   //!< Input "Font size"
	//CpStateInp* mInpText;   //!< Input "Text"
        WInp mWinpFontPath;
        WInp mWinpFontSize;
        WInp mWinpText;
	BState* mOstRqsW;   //!< Output state "RqsW"
	BState* mOstRqsH;   //!< Output state "RqsH"
	BState* mOstLbpUri;   //!< Output "Mouse left button pressed"
	BState* mStFontPath;
	BState* mStFontSize;
	FTPixmapFont* mFont = nullptr;
        bool mFontInpsUpdated = false;
	bool mDrawOnComplete = false;
	MSceneElem* mMSceneElem = nullptr;
	MDesSyncable* mMDesSyncable = nullptr;
	MAgent* mMAgent = nullptr;
	bool mActNotified;
	static const string KUri_AlcX;
	static const string KUri_AlcY;
	static const string KUri_AlcW;
	static const string KUri_AlcH;
	static const string KUri_BgColor;
	static const string KUri_FgColor;
	static const string KUri_Border;
	static const string KUri_Text;
	static const string KUri_InpFont;
	static const string KUri_InpFontSize;
        static const string KUri_InpText;
        static const string KUri_OstRqsW;
        static const string KUri_OstRqsH;
        static const string KUri_OstLbpUri;
	static const int K_Padding;
};

#endif
