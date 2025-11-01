
#ifndef __FAP5VIS_AGENTVR_H
#define __FAP5VIS_AGENTVR_H

#include "widget.h"
#include "container.h"

/** @brief Edge CRP widget agent
 * */
class AEdgeCrp : public AVWidget
{
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
            protected:
                AVWidget* mHost = nullptr;
                bool mRqsH = false; // Requisition for hight, otherwise for width
        };
        friend class TrRqs;

    public:
        inline static constexpr std::string_view idStr() { return "AEdgeCrp"sv;}
	AEdgeCrp(const string& aType, const string& aName = string(), MEnv* aEnv = NULL);
        void Construct() override;
	// From MSceneElem
	virtual void Render() override;
    protected:
	void GetDirectWndCoord(int aInpX, int aInpY, int& aOutX, int& aOutY);
	/** @brief Get data from host state outp connpoint */
	const DtBase* GetStOutpData(const GUri& aCpUri, const string& aTypeSig);
	template <typename T> const T* GetStOutpData(const GUri& aCpUri) { return reinterpret_cast<const T*>(GetStOutpData(aCpUri, T::TypeSig()));}
    protected:
	// Segments rendering support
	bool DrawSegment(const string& aSegName);
	bool GetSegCoord(MNode* aWdgCp, const GUri& aCpUri, int& aData);
    protected:
	// Internal transitions
	virtual void updateRqsW();
    protected:
        TrRqs* mTrRqsW = nullptr;
        TrRqs* mTrRqsH = nullptr;
        static const string KUri_TrRqsW;
        static const string KUri_TrRqsH;
};


#endif

