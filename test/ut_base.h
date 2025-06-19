
#ifndef __FAP5VIS_UT_BASE_H
#define __FAP5VIS_UT_BASE_H

#include <cppunit/extensions/HelperMacros.h>

#include "env.h"

/** @brief UT base fixture
*/
class Ut_fixture : public CPPUNIT_NS::TestFixture
{
    protected:
        MNode* constructSystem(const string& aFname);
    protected:
        Env* mEnv;
};

MNode* Ut_fixture::constructSystem(const string& aSpecn)
{
    string ext = "chs";
    string spec = aSpecn + string(".") + "chs";
    string log = aSpecn + "_" + ext + ".log";
    mEnv = new Env(spec, log);
    CPPUNIT_ASSERT_MESSAGE("Fail to create Env", mEnv != 0);
    mEnv->ImpsMgr()->ResetImportsPaths();
    mEnv->ImpsMgr()->AddImportsPaths("../modules");
    mEnv->ImpsMgr()->AddImportsPaths("../../fap5/modules");
    VisProv* visprov = new VisProv("VisProv", mEnv);
    mEnv->addProvider(visprov);
    mEnv->constructSystem();
    MNode* root = mEnv->Root();
    MElem* eroot = root ? root->lIf(eroot) : nullptr;
    CPPUNIT_ASSERT_MESSAGE("Fail to get root", root && eroot);
    return root;
}



#endif


