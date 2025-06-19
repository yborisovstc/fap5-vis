#ifndef __FAP5VIS_VISPROV_H
#define __FAP5VIS_VISPROV_H


#include "prov.h"


/** @brief Default provider
 * */
class VisProv: public ProvBase
{
    public:
	VisProv(const string& aName, MEnv* aEnv);
	virtual ~VisProv();
	// From ProvBase
	virtual const TFReg& FReg() const override {return mReg;}
	virtual const TDtFReg& FDtReg() const override {return mDtReg;}
	// From MProvider
	virtual void getNodesInfo(vector<string>& aInfo);
	virtual const string& modulesPath() const;
	virtual void setChromoRslArgs(const string& aRargs) {}
	virtual void getChromoRslArgs(string& aRargs) {}
    private:
	static const TFReg mReg;
	static const TDtFReg mDtReg;
};


#endif
