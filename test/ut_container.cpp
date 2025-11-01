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

#include "des.h"

/*
 * To run particular test suite: ./ut-fap2vis-lib [test_suite_name] for instance ./ut-fap2vis-lib Ut_ExecMagt
 */



/** @brief Test of container using approach of widget assosiation to slots via link
 * */
class Ut_cntr : public Ut_fixture
{
    CPPUNIT_TEST_SUITE(Ut_cntr);
    //CPPUNIT_TEST(testVlayout1);
    //CPPUNIT_TEST(testVlayoutCmb);
    //CPPUNIT_TEST(testVlayoutCmb2);
    //CPPUNIT_TEST(testHlayout1);
    //CPPUNIT_TEST(testHlayout2);
    //CPPUNIT_TEST(testHlayout_RmWidget1);
    //CPPUNIT_TEST(testDCntr1);
    //CPPUNIT_TEST(testDCntr2);
    //CPPUNIT_TEST(testDCntr3);
    //CPPUNIT_TEST(testDCntr4);
    //CPPUNIT_TEST(testDCntr5);
    //CPPUNIT_TEST(testDCntr6);
    //CPPUNIT_TEST(testColumnsLayout);
    //CPPUNIT_TEST(testColumnsLayout2);
    //CPPUNIT_TEST(testColumnsLayout3);
    CPPUNIT_TEST(testColumnsLayout4);
    CPPUNIT_TEST_SUITE_END();
    public:
    virtual void setUp();
    virtual void tearDown();
    string getStateDstr(const string& aUri);
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
    void testDCntr5();
    void testDCntr6();
    void testColumnsLayout();
    void testColumnsLayout2();
    void testColumnsLayout3();
    void testColumnsLayout4();
};

string Ut_cntr::getStateDstr(const string& aUri)
{
    MNode* st = mEnv->Root()->getNode(aUri);
    MDVarGet* stg = st ? st->lIf(stg) : nullptr;
    const DtBase* data = stg ? stg->VDtGet(string()) : nullptr;
    return data ? data->ToString(true) : string();
}


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
    cout << endl << "=== Combined vertical layout test" << endl;

    MNode* root = constructSystem("ut_vlayout_2");
    CPPUNIT_ASSERT_MESSAGE("Failed creating system", root);

    bool run = mEnv->RunSystem(200, 10);
    CPPUNIT_ASSERT_MESSAGE("Fail to run system", run);

    delete mEnv;
}

void Ut_cntr::testVlayoutCmb2()
{
    cout << endl << "=== Combined vertical layout test 2" << endl;

    MNode* root = constructSystem("ut_vlayout_3");
    CPPUNIT_ASSERT_MESSAGE("Failed creating system", root);

    bool run = mEnv->RunSystem(200, 10);
    CPPUNIT_ASSERT_MESSAGE("Fail to run system", run);

    delete mEnv;

}

void Ut_cntr::testHlayout1()
{
    printf("\n === Horizontal layout test 1\n");

    MNode* root = constructSystem("ut_hlayout_1");
    CPPUNIT_ASSERT_MESSAGE("Failed creating system", root);

    bool run = mEnv->RunSystem(200, 10);
    CPPUNIT_ASSERT_MESSAGE("Fail to run system", run);

    delete mEnv;
}

void Ut_cntr::testHlayout2()
{
    cout << endl << "=== Horizontal layout test 2" << endl;

    MNode* root = constructSystem("ut_hlayout_2");
    CPPUNIT_ASSERT_MESSAGE("Failed creating system", root);

    bool run = mEnv->RunSystem(200, 10);
    CPPUNIT_ASSERT_MESSAGE("Fail to run system", run);

    delete mEnv;
}


/** @brief HLayout, removing widget
 *
 * */
void Ut_cntr::testHlayout_RmWidget1()
{
    cout << endl << "=== Combined horisontal layout, removing widget 1" << endl;

    MNode* root = constructSystem("ut_hlayout_rmwidget_1");
    CPPUNIT_ASSERT_MESSAGE("Failed creating system", root);

    // Checking the widget/slot exists
    MNode* slot = root->getNode("Test.Window.Scene.HBox.Slot_2");
    CPPUNIT_ASSERT_MESSAGE("Failed creating widget/slot", slot);

    bool run = mEnv->RunSystem(200, 10);
    CPPUNIT_ASSERT_MESSAGE("Fail to run system", run);

    // Checking the widget removed
    slot = root->getNode("Test.Window.Scene.HBox.Slot_2");
    CPPUNIT_ASSERT_MESSAGE("Fail to remove widget", slot == nullptr);

    delete mEnv;

}

/** @brief DES controlled container, vert layout
 *
 * */
void Ut_cntr::testDCntr1()
{
    cout << endl << "=== DES controlled container, base." << endl;
    MNode* root = constructSystem("ut_dcntr_1");
    bool run = mEnv->RunSystem(40, 20);
    CPPUNIT_ASSERT_MESSAGE("Fail to run system", run);
    mEnv->profiler()->saveMetrics();
    delete mEnv;

    cout << endl << "=== DES controlled container, base. LSC MSO approach." << endl;
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
    cout << endl << "=== DES controlled container, hrz layout" << endl;
    MNode* root = constructSystem("ut_dcntr_2");
    bool run = mEnv->RunSystem(40, 20);
    CPPUNIT_ASSERT_MESSAGE("Fail to run system", run);
    delete mEnv;

    /*
    cout << endl << "=== DES controlled container, hrz layout. LSC MSO approach." << endl;
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
    cout << endl << "=== DES controlled container, vert/hrz combined layout" << endl;
    MNode* root = constructSystem("ut_dcntr_3");
    bool run = mEnv->RunSystem(40, 20);
    CPPUNIT_ASSERT_MESSAGE("Fail to run system", run);
    delete mEnv;

    cout << endl << "=== DES controlled container, vert/hrz combined layout. LSC MSO approach." << endl;
    root = constructSystem("ut_dcntr_3_mso");
    run = mEnv->RunSystem(40, 20);
    CPPUNIT_ASSERT_MESSAGE("Fail to run system", run);
    delete mEnv;
}


/** @brief DES controlled container, vert layout, massive insertion
 * */
void Ut_cntr::testDCntr4()
{
    cout << endl << "=== DES controlled container, vert layout, massive insertion" << endl;
    MNode* root = constructSystem("ut_dcntr_4");
    bool run = mEnv->RunSystem(400, 50);
    CPPUNIT_ASSERT_MESSAGE("Fail to run system", run);
    mEnv->profiler()->saveMetrics();
    delete mEnv;

    printf("\n === DES controlled container, vert layout, massive insertion. LSC MSO approach.\n");
    cout << endl << "=== DES controlled container, vert layout, massive insertion. LSC MSO approach." << endl;
    root = constructSystem("ut_dcntr_4_mso");
    run = mEnv->RunSystem(200, 20);
    CPPUNIT_ASSERT_MESSAGE("Fail to run system", run);
    mEnv->profiler()->saveMetrics();
    delete mEnv;
}

/** @brief DES controlled container, vert layout, massive insertion
 * */
void Ut_cntr::testDCntr5()
{
    cout << endl << "=== DES controlled container, vert layout, massive insertion" << endl;
    MNode* root = constructSystem("ut_dcntr_5");
    bool run = mEnv->RunSystem(400, 1);
    CPPUNIT_ASSERT_MESSAGE("Fail to run system", run);
    mEnv->profiler()->saveMetrics();
    delete mEnv;
}

/** @brief DES controlled container, continous insertion/removal
 * */
void Ut_cntr::testDCntr6()
{
    cout << endl << "=== DES controlled container, continous insertion/removal" << endl;
    MNode* root = constructSystem("ut_dcntr_6");
    bool run = mEnv->RunSystem(400, 1);
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

    cout << endl << "=== Columns layout. Direct creation." << endl;
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

    cout << endl << "=== Columns layout. Controlled creation." << endl;
    root = constructSystem("ut_columns_layout_2");
    res = mEnv->RunSystem(40, 20);
    CPPUNIT_ASSERT_MESSAGE("Fail to run system", res);
    mEnv->profiler()->saveMetrics();
    CPPUNIT_ASSERT_MESSAGE("New button name is wrong", getStateDstr("Test.Wnd.Scene.ColumnsView.BtnNew_2.SText") == "SS 'Button_New'");
    MNode* colSlot = mEnv->Root()->getNode("Test.Wnd.Scene.ColumnsView.New_column");
    CPPUNIT_ASSERT_MESSAGE("New column not created", colSlot != nullptr);
    delete mEnv;

    /*
    printf("\n === Columns layout. Controlling creation. LSC MSO approach.\n");
    root = constructSystem("ut_columns_layout_2_mso");
    res = mEnv->RunSystem(40, 20);
    CPPUNIT_ASSERT_MESSAGE("Fail to run system", res);
    mEnv->profiler()->saveMetrics();
    delete mEnv;
    */
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
    MNode* colSlot = mEnv->Root()->getNode("Test.Wnd.Scene.HBox.ColView1.Column2");
    CPPUNIT_ASSERT_MESSAGE("New column not created", colSlot != nullptr);

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
    MNode* colSlot = mEnv->Root()->getNode("Test.Wnd.Scene.HBox.ColView3.Column2");
    CPPUNIT_ASSERT_MESSAGE("New column not created", colSlot != nullptr);

    delete mEnv;
}






