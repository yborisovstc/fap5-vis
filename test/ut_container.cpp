#include <stdlib.h>
#include <sys/types.h>
#include <signal.h>
#include <iostream>
#include <fstream>
#include <env.h>
#include <elem.h>
#include <mdes.h>
#include "../src/visprov.h"
#include "../src/mvisenv.h"

#include <cppunit/extensions/HelperMacros.h>
#include "ut_base.h"

#include <GLFW/glfw3.h>

/*
 * To run particular test suite: ./ut-fap2vis-lib [test_suite_name] for instance ./ut-fap2vis-lib Ut_ExecMagt
 */



/** @brief Test of container using approach of widget assosiation to slots via link
 * */
class Ut_cntr : public Ut_fixture
{
    CPPUNIT_TEST_SUITE(Ut_cntr);
    CPPUNIT_TEST(testVlayout1);
    //CPPUNIT_TEST(testVlayoutCmb);
    //CPPUNIT_TEST(testVlayoutCmb2);
    //CPPUNIT_TEST(testHlayout1);
    //CPPUNIT_TEST(testHlayout2);
    //CPPUNIT_TEST(testHlayout_RmWidget1);
    //CPPUNIT_TEST(testDCntr1);
    //CPPUNIT_TEST(testDCntr2);
    //CPPUNIT_TEST(testDCntr3);
    //CPPUNIT_TEST(testDCntr4);
    //CPPUNIT_TEST(testColumnsLayout);
    //CPPUNIT_TEST(testColumnsLayout2);
    //CPPUNIT_TEST(testColumnsLayout3);
    //CPPUNIT_TEST(testColumnsLayout4);
    CPPUNIT_TEST_SUITE_END();
    public:
    virtual void setUp();
    virtual void tearDown();
    private:
    void testVlayout1();
    void testVlayoutCmb();
    void testVlayoutCmb2();
    void testHlayout1();
    void testHlayout2();
    void testHlayout_RmWidget1();
    void testDCntr1();
    void testDCntr2();
    void testDCntr3();
    void testDCntr4();
    void testColumnsLayout();
    void testColumnsLayout2();
    void testColumnsLayout3();
    void testColumnsLayout4();
};

CPPUNIT_TEST_SUITE_REGISTRATION( Ut_cntr );
CPPUNIT_TEST_SUITE_NAMED_REGISTRATION(Ut_cntr, "Ut_cntr");

void Ut_cntr::setUp()
{
}

void Ut_cntr::tearDown()
{
    CPPUNIT_ASSERT_EQUAL_MESSAGE("tearDown", 0, 0);
}


void Ut_cntr::testVlayout1()
{
    printf("\n === Vertical layout test 1\n");

    MNode* root = constructSystem("ut_vlayout_1");
    CPPUNIT_ASSERT_MESSAGE("Failed creating system", root);

    bool run = mEnv->RunSystem(100, 10);
    CPPUNIT_ASSERT_MESSAGE("Fail to run system", run);

    delete mEnv;
}


void Ut_cntr::testVlayoutCmb()
{
    printf("\n === Combined Vertical layout (SLW approach) test 1\n");
    const string specn("ut_vlayout_2");
    string ext = "chs";
    string spec = specn + string(".") + ext;
    string log = specn + "_" + ext + ".log";
    mEnv = new Env(spec, log);
    CPPUNIT_ASSERT_MESSAGE("Fail to create Env", mEnv != 0);
    mEnv->ImpsMgr()->AddImportsPaths("../modules");
    VisProv* visprov = new VisProv("VisProv", mEnv);
    mEnv->addProvider(visprov);
    mEnv->constructSystem();
    bool run = mEnv->RunSystem(100, 20);
    CPPUNIT_ASSERT_MESSAGE("Fail to run system", run);

    delete mEnv;
}

void Ut_cntr::testVlayoutCmb2()
{
    printf("\n === Combined Vertical layout (SLW approach) test 1\n");
    const string specn("ut_vlayout_3");
    string ext = "chs";
    string spec = specn + string(".") + ext;
    string log = specn + "_" + ext + ".log";
    mEnv = new Env(spec, log);
    CPPUNIT_ASSERT_MESSAGE("Fail to create Env", mEnv != 0);
    mEnv->ImpsMgr()->AddImportsPaths("../modules");
    VisProv* visprov = new VisProv("VisProv", mEnv);
    mEnv->addProvider(visprov);
    mEnv->constructSystem();
    bool run = mEnv->RunSystem(100, 20);
    CPPUNIT_ASSERT_MESSAGE("Fail to run system", run);

    delete mEnv;
}

void Ut_cntr::testHlayout1()
{
    printf("\n === Single horisontal layout (SLW approach) test 1\n");
    const string specn("ut_hlayout_1");
    string ext = "chs";
    string spec = specn + string(".") + ext;
    string log = specn + "_" + ext + ".log";
    mEnv = new Env(spec, log);
    CPPUNIT_ASSERT_MESSAGE("Fail to create Env", mEnv != 0);
    mEnv->ImpsMgr()->AddImportsPaths("../modules");
    VisProv* visprov = new VisProv("VisProv", mEnv);
    mEnv->addProvider(visprov);
    mEnv->constructSystem();
    bool run = mEnv->RunSystem(100, 20);
    CPPUNIT_ASSERT_MESSAGE("Fail to run system", run);

    delete mEnv;
}

void Ut_cntr::testHlayout2()
{
    printf("\n === Combined horisontal layout (SLW approach) test 1\n");
    const string specn("ut_hlayout_2");
    string ext = "chs";
    string spec = specn + string(".") + ext;
    string log = specn + "_" + ext + ".log";
    mEnv = new Env(spec, log);
    CPPUNIT_ASSERT_MESSAGE("Fail to create Env", mEnv != 0);
    mEnv->ImpsMgr()->AddImportsPaths("../modules");
    VisProv* visprov = new VisProv("VisProv", mEnv);
    mEnv->addProvider(visprov);
    mEnv->constructSystem();
    bool run = mEnv->RunSystem(200, 20);
    CPPUNIT_ASSERT_MESSAGE("Fail to run system", run);

    delete mEnv;
}


/** @brief HLayout, removing widget
 *
 * */
void Ut_cntr::testHlayout_RmWidget1()
{
    printf("\n === Combined horisontal layout, removing widget 1\n");
    const string specn("ut_hlayout_rmwidget_1");
    string ext = "chs";
    string spec = specn + string(".") + ext;
    string log = specn + "_" + ext + ".log";
    mEnv = new Env(spec, log);
    CPPUNIT_ASSERT_MESSAGE("Fail to create Env", mEnv != 0);
    mEnv->ImpsMgr()->AddImportsPaths("../modules");
    VisProv* visprov = new VisProv("VisProv", mEnv);
    mEnv->addProvider(visprov);
    mEnv->constructSystem();
    MNode* root = mEnv->Root();
    CPPUNIT_ASSERT_MESSAGE("Fail to get root", root != 0);
    // Checking the widget/slot exists
    MNode* slot = root->getNode("Test.Window.Scene.HBox.Slot_2");
    CPPUNIT_ASSERT_MESSAGE("Failed creating widget/slot", slot);

    bool run = mEnv->RunSystem(40, 20);
    CPPUNIT_ASSERT_MESSAGE("Fail to run system", run);

    // Checking the widget removed
    slot = root->getNode("Test.Window.Scene.HBox.Slot_2");
    CPPUNIT_ASSERT_MESSAGE("Fail to remove widget", slot == NULL);

    delete mEnv;
}

/** @brief DES controlled container, vert layout
 *
 * */
void Ut_cntr::testDCntr1()
{
    printf("\n === DES controlled container, base.\n");
    MNode* root = constructSystem("ut_dcntr_1");
    bool run = mEnv->RunSystem(40, 20);
    CPPUNIT_ASSERT_MESSAGE("Fail to run system", run);
    mEnv->profiler()->saveMetrics();
    delete mEnv;

    printf("\n === DES controlled container, base. LSC MSO approach.\n");
    root = constructSystem("ut_dcntr_1l");
    run = mEnv->RunSystem(40, 20);
    CPPUNIT_ASSERT_MESSAGE("Fail to run system", run);
    mEnv->profiler()->saveMetrics();
    delete mEnv;

}

/** @brief DES controlled container, hrz layout
 *
 * */
void Ut_cntr::testDCntr2()
{
    MNode* root = nullptr;
    bool run = false;

    printf("\n === DES controlled container, hrz layout\n");
    root = constructSystem("ut_dcntr_2");
    run = mEnv->RunSystem(40, 20);
    CPPUNIT_ASSERT_MESSAGE("Fail to run system", run);
    delete mEnv;

    /*
    printf("\n === DES controlled container, hrz layout. LSC MSO approach.\n");
    root = constructSystem("ut_dcntr_2_mso");
    run = mEnv->RunSystem(40, 20);
    CPPUNIT_ASSERT_MESSAGE("Fail to run system", run);
    delete mEnv;
    */
}

/** @brief DES controlled container, vert - hrz combined layout
 *
 * */
void Ut_cntr::testDCntr3()
{
    MNode* root = nullptr;
    bool run = false;

    printf("\n === DES controlled container, vert/hrz combined layout\n");
    root = constructSystem("ut_dcntr_3");
    run = mEnv->RunSystem(40, 20);
    CPPUNIT_ASSERT_MESSAGE("Fail to run system", run);
    delete mEnv;

    printf("\n === DES controlled container, vert/hrz combined layout. LSC MSO approach.\n");
    root = constructSystem("ut_dcntr_3_mso");
    run = mEnv->RunSystem(40, 20);
    CPPUNIT_ASSERT_MESSAGE("Fail to run system", run);
    delete mEnv;
}


/** @brief DES controlled container, vert layout, massive insertion
 * */
void Ut_cntr::testDCntr4()
{
    MNode* root = nullptr;
    bool run = false;

    printf("\n === DES controlled container, vert layout, massive insertion\n");
    root = constructSystem("ut_dcntr_4");
    run = mEnv->RunSystem(400, 50);
    CPPUNIT_ASSERT_MESSAGE("Fail to run system", run);
    mEnv->profiler()->saveMetrics();
    delete mEnv;

    printf("\n === DES controlled container, vert layout, massive insertion. LSC MSO approach.\n");
    root = constructSystem("ut_dcntr_4_mso");
    run = mEnv->RunSystem(200, 20);
    CPPUNIT_ASSERT_MESSAGE("Fail to run system", run);
    mEnv->profiler()->saveMetrics();
    delete mEnv;
}



/** @brief DES controlled container, columns layout. Direct creation.
 *
 * */
void Ut_cntr::testColumnsLayout()
{
    MNode* root = nullptr;
    bool res = false;

    printf("\n === Columns layout. Direct creation.\n");
    root = constructSystem("ut_columns_layout");
    res = mEnv->RunSystem(40, 20);
    CPPUNIT_ASSERT_MESSAGE("Fail to run system", res);
    delete mEnv;

    printf("\n === Columns layout. Direct creation. LSC MSO.\n");
    root = constructSystem("ut_columns_layout_mso");
    res = mEnv->RunSystem(40, 20);
    CPPUNIT_ASSERT_MESSAGE("Fail to run system", res);
    delete mEnv;
}

/** @brief DES controlled container, columns layout. Controlling creation.
 *
 * */
void Ut_cntr::testColumnsLayout2()
{
    MNode* root = nullptr;
    bool res = false;

    printf("\n === Columns layout. Controlling creation.\n");
    root = constructSystem("ut_columns_layout_2");
    res = mEnv->RunSystem(40, 20);
    CPPUNIT_ASSERT_MESSAGE("Fail to run system", res);
    mEnv->profiler()->saveMetrics();
    delete mEnv;

    printf("\n === Columns layout. Controlling creation. LSC MSO approach.\n");
    root = constructSystem("ut_columns_layout_2_mso");
    res = mEnv->RunSystem(40, 20);
    CPPUNIT_ASSERT_MESSAGE("Fail to run system", res);
    mEnv->profiler()->saveMetrics();
    delete mEnv;
}

/** @brief DES controlled container, columns layout. Controlling creation. Requisition
 * testColumnsLayout2 didn't detect the problem with columns layout requisition not working
 *
 * */
void Ut_cntr::testColumnsLayout3()
{
    printf("\n === Columns layout as widget of container. Update of col layout requisition.\n");
    MNode* root = constructSystem("ut_columns_layout_3");

    bool run = mEnv->RunSystem(40, 20);
    CPPUNIT_ASSERT_MESSAGE("Fail to run system", run);

    delete mEnv;
}

/** @brief DES controlled container, columns layout. Controlling creation. Requisition
 * testColumnsLayout2 didn't detect the problem with columns layout requisition not working
 *
 * */
void Ut_cntr::testColumnsLayout4()
{
    printf("\n === Columns layout as widget of container. . Controlling creation.\n");
    MNode* root = constructSystem("ut_columns_layout_4");

    bool run = mEnv->RunSystem(40, 20);
    CPPUNIT_ASSERT_MESSAGE("Fail to run system", run);

    delete mEnv;
}






