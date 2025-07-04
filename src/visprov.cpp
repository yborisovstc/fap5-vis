
#include <chromo2.h>

#include "visprov.h"

#include "visenv.h"
#include "scene.h"
#include "widget.h"
#include "label.h"
#include "button.h"
#include "container.h"
//#include "agentvr.h"
//#include "vissdo.h"

// TODO [YB] To import from build variable
const string KModulesPath = "/usr/share/fap5-vis/modules/";

/** @brief Chromo arguments */
const string KChromRarg_Chs = "chs";

/** Native agents factory registry */
const VisProv::TFReg VisProv::mReg ( {
	Item<VisEnv>(), Item<GWindow>(), Item<GtScene>(), Item<AVWidget>(), Item<AVLabel>(), Item<AButton>(),
	Item<AVDContainer>(), Item<ACnt>(),
        /*
	Item<AVrpView>(),
	Item<AEdgeCrp>(),
	Item<VDesLauncher>(),
	Item<SdoCoordOwr>()
        */
	});

const VisProv::TDtFReg VisProv::mDtReg;


VisProv::VisProv(const string& aName, MEnv* aEnv): ProvBase(aName, aEnv)
{
}

VisProv::~VisProv()
{
}

void VisProv::getNodesInfo(vector<string>& aInfo)
{
    for (auto elem : mReg) {
	aInfo.push_back(elem.first);
    }
}

const string& VisProv::modulesPath() const
{
    return KModulesPath;
}
